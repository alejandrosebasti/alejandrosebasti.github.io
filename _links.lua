-- Adds a "Links" section at the end of a post from the `links` list
-- (each link has a label and a url). YouTube links become embedded videos.
local function youtube_id(url)
  return url:match("youtube%.com/watch%?v=([%w_%-]+)")
      or url:match("youtube%.com/watch%?.-&v=([%w_%-]+)")
      or url:match("youtu%.be/([%w_%-]+)")
      or url:match("youtube%.com/shorts/([%w_%-]+)")
      or url:match("youtube%.com/live/([%w_%-]+)")
end

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

function Pandoc(doc)
  local links = doc.meta.links
  if not links or #links == 0 then return doc end
  local items, videos = {}, {}
  for _, l in ipairs(links) do
    local url = pandoc.utils.stringify(l.url or "")
    local label = pandoc.utils.stringify(l.label or "")
    if url ~= "" then
      if label == "" then label = url end
      local id = youtube_id(url)
      if id then
        table.insert(videos, pandoc.RawBlock("html",
          '<figure class="post-video"><div class="video-wrap"><iframe src="https://www.youtube-nocookie.com/embed/' .. id ..
          '" title="' .. esc(label) .. '" allowfullscreen loading="lazy" ' ..
          'allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe></div>' ..
          '<figcaption><a href="' .. esc(url) .. '">' .. esc(label) .. '</a></figcaption></figure>'))
      else
        table.insert(items, { pandoc.Plain({ pandoc.Link(label, url) }) })
      end
    end
  end
  if #items == 0 and #videos == 0 then return doc end
  local section = { pandoc.Header(2, "Links", pandoc.Attr("links", { "post-links" })) }
  for _, v in ipairs(videos) do table.insert(section, v) end
  if #items > 0 then table.insert(section, pandoc.BulletList(items)) end
  for _, b in ipairs(section) do doc.blocks:insert(b) end
  return doc
end
