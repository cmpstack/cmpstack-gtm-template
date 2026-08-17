# CMPStack — Google Tag Manager template

Community Template that loads [`consent.js`](https://consently.app/consent.js) with your CMPStack Domain ID so Google tags can wait for visitor consent.

Gallery listing (after Google review): [Community Template Gallery](https://tagmanager.google.com/gallery)

## Install from the Gallery (after approval)

1. In GTM, open **Templates** → **Search Gallery**.
2. Search for **CMPStack Cookie Consent**.
3. Add the template, then create a tag from it.
4. Paste your **CMPStack Domain ID** (dashboard → domain → Install).
5. Trigger: **Consent Initialization – All Pages**.
6. Publish. Verify with [Consent Mode checker](https://consently.app/tools/consent-mode-checker).

## Manual import

1. Download [`template.tpl`](./template.tpl).
2. GTM → **Templates** → **Tag Templates** → **New** → **Import**.
3. Save, create a tag, set Domain ID, use **Consent Initialization – All Pages**.

## Permissions

This template only injects `https://consently.app/consent.js` (and `*.consently.app`). It does not read cookies, write the data layer, or change Consent Mode itself — the CMPStack banner script does that after it loads.

Self-hosted CMPStack: fork this repo and add your origin to the `inject_script` permission in `template.tpl`.

## Gallery maintainers

Required root files (Google will remove listings that do not match this layout):

- `template.tpl`
- `metadata.yaml`
- `LICENSE` (Apache 2.0 only)
- `README.md`

To publish a new version after changing `template.tpl`:

1. Commit the template change.
2. Copy that commit’s full SHA.
3. Add a new entry at the **top** of `versions` in `metadata.yaml`.
4. Commit `metadata.yaml`. Gallery updates usually appear within 2–3 days.

Submit (first time, GitHub account that owns this repo):

1. Open [tagmanager.google.com/gallery](https://tagmanager.google.com/gallery).
2. Menu → **Submit Template**.
3. Repository URL: `https://github.com/sakil-ahmed/cmpstack-gtm-template`
