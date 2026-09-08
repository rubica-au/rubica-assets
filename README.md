# rubica-assets

Public, static asset hosting for Rubica. Anything committed here is served at a stable public URL, so images, logos, icons and other content can be referenced directly from presentations, generated documents, emails, Salesforce components and Claude artefacts instead of being embedded as base64.

**This repo is PUBLIC.** Never commit client data, screenshots containing client information, credentials, or anything under NDA. Logos and marketing imagery are fine.

## URL patterns

Every file is reachable two ways.

| Use for | URL pattern |
|---|---|
| Images, fonts, PDFs, anything binary (use in docs, slides, emails) | `https://raw.githubusercontent.com/rubica-au/rubica-assets/main/<path>` |
| HTML pages, SVG, anything that must render in a browser | `https://rubica-au.github.io/rubica-assets/<path>` |

Raw URLs serve HTML as `text/plain`, so browsers will not render it. Use the GitHub Pages URL for anything you want to open as a page.

Example:

```
https://raw.githubusercontent.com/rubica-au/rubica-assets/main/logos/clients/acumon-logo.png
https://rubica-au.github.io/rubica-assets/logos/clients/acumon-logo.png
```

Both URLs update within about five minutes of a push to `main`. If you need an immutable link (a file you might later change), use a commit SHA instead of `main`:

```
https://raw.githubusercontent.com/rubica-au/rubica-assets/<commit-sha>/<path>
```

## Folder layout

| Folder | What goes here |
|---|---|
| `logos/rubica/` | Rubica brand marks, wordmarks, favicons |
| `logos/clients/` | Customer firm logos used in generated documents and portals |
| `images/` | General imagery: diagrams, screenshots (no client data), illustrations |
| `icons/` | Small UI icons and pictograms |
| `presentations/` | Images and media referenced from slide decks, grouped by deck name |
| `documents/` | Public PDFs and reference documents |
| `scripts/` | Helper scripts (not served content) |

Add a subfolder per deck or per project rather than dumping files at the top level.

## Naming

- Lower-case, hyphen-separated: `acumon-logo.png`, not `Property 1=Default.png`
- No spaces or special characters. URLs with spaces break in most tools.
- Keep the original file extension and make it match the content (`.png` is a PNG, `.jpeg` is a JPEG)
- Prefer PNG or SVG for logos, JPEG for photos, WebP where the consumer supports it

## Publishing a file

From this repo's root:

```bash
scripts/publish.sh ~/Downloads/new-logo.png logos/clients/
```

The script copies the file into the target folder, commits, pushes, and prints both public URLs. Or do it by hand:

```bash
cp ~/Downloads/new-logo.png logos/clients/new-logo.png
git add logos/clients/new-logo.png
git commit -m "Add new-logo"
git push
```

Files can also be uploaded through the GitHub web UI (Add file, Upload files) into the right folder.

## Size limits

Keep individual files under 10 MB and prefer well under 1 MB for anything embedded in documents or slides. GitHub blocks files over 100 MB and this repo is not configured for Git LFS. Large media belongs in the content hosting service, not here.

## Related

- [rubica-Content-Hosting](https://github.com/rubica-au/rubica-Content-Hosting): authenticated hosting for generated HTML artefacts at content.rubica.au. Use that for client-facing or access-controlled content. This repo is for public, static brand and reference assets only.

## Legacy root files

`acumon-logo.png` also remains at the repo root because existing document templates reference that URL. New assets go in the folders above. Do not add more files at the root.
