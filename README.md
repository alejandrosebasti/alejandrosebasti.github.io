# rechu

A minimal personal site with four sections: **Gaming**, **Thoughts**, **Research** and **Gallery**.
It's built with [Quarto](https://quarto.org) and published for free on GitHub Pages. Every time something changes in this repository, the site rebuilds by itself within a minute or two.

## Writing and uploading in the browser

1. Go to **https://app.pagescms.org** and sign in with GitHub.
2. Pick this repository.
3. On the left you'll see **Gaming**, **Thoughts**, **Research**, **Gallery** and **About page**.
   - To write a post, open a section, click **Add an entry**, fill in the title and date, write, then click **Save**.
   - To add a photo to the gallery, open **Gallery** → **Add an entry** → upload the photo (a caption is optional) → **Save**.
   - Images inside posts: use the image button in the editor toolbar.
   - To delete a post, open it and use the menu next to **Save**.
4. Wait a minute or two, then refresh your site.

The example posts and the two sample photos are only there to show the layout. Delete them whenever you like.

## Adding your own domain

1. Buy a domain (Cloudflare Registrar and Porkbun sell close to cost, about $10–15 a year for a .com).
2. On GitHub, open this repository → **Settings** → **Pages** → **Custom domain**, type your domain (for example `yourname.com`) and click **Save**.
3. Where you bought the domain, open its **DNS** settings and add:

   | Type  | Name  | Value                        |
   |-------|-------|------------------------------|
   | A     | `@`   | `185.199.108.153`            |
   | A     | `@`   | `185.199.109.153`            |
   | A     | `@`   | `185.199.110.153`            |
   | A     | `@`   | `185.199.111.153`            |
   | CNAME | `www` | `<your-github-username>.github.io` |

   On Cloudflare, set these records to **DNS only** (grey cloud) until HTTPS is working.
4. After a few minutes (sometimes a few hours), go back to **Settings → Pages** and tick **Enforce HTTPS**.

## Where things live

| What | Where |
|------|-------|
| Posts | `posts/gaming`, `posts/thoughts`, `posts/research` |
| Gallery photos | `gallery/` (one small file per photo) and `images/` (the photo files) |
| Site name and menu | `_quarto.yml` |
| Home page intro | `index.qmd` |
| Look and feel | `styles.scss`, `dark.scss` (black background, white text) |
| Browser editor settings | `.pages.yml` |
| Publishing | `.github/workflows/publish.yml` |
