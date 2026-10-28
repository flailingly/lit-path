# Scout's Folio

A personal walking RPG over real San Francisco, built to make post-ACL/meniscus-surgery walks fun. One player (the owner), Android phone, web prototype first, native Android later.

## Working agreement

- Act as a blunt engineering partner: lead with risks and tradeoffs, recommend one option, push back on scope creep and frontend polish that skips execution.
- The owner does not code. Explain steps plainly, run commands for them, and verify changes in the browser before calling them done.
- Plan before big changes. Keep changes small and testable.
- Never push walking intensity past physio limits. The game nudges; it never demands.

## Files

- `lamplighter.html` — the whole game (page content, CSS and one script). Also published as a claude.ai artifact preview.
- `places.json` — ~2,200 real SF places from OpenStreetMap: `[kind, name, lat, lon]`. Kinds: grove, lookout, mural, archive, spring, hearthkeeper, echo.
- `lamplighter-phone/` — the deployable folder (generated; do not edit by hand): `index.html`, `places.json`, manifest, icons.
- `tools/build.ps1` — wraps `lamplighter.html` into `lamplighter-phone/index.html` and writes the manifest.
- `tools/serve.ps1` — serves `lamplighter-phone/` at http://localhost:8765 for testing.

## Build, test, deploy

```powershell
powershell -File tools/build.ps1          # regenerate lamplighter-phone/
powershell -File tools/serve.ps1          # local test server (leave running)
```

Test in the browser pane at mobile size (375x812). Simulated walking: start with "Try it with simulated walking", set speed 20x in Dispatch, tap the map. To fake GPS, override `navigator.geolocation` before tapping "Use my location as home"; keep fake movement under 12 m/s or the jump filter drops it.

Deploy: the owner drags `lamplighter-phone/` onto their Netlify project's Deploys page (Netlify Drop). URL stays the same.

Preview: `lamplighter.html` is also published as a claude.ai artifact at https://claude.ai/artifact/G2DMEZLacrttTTSs8fcKx2. Update it in place (pass that `url`, and `places.json` in `files`) rather than creating a new artifact. In the artifact viewer, map tiles and GPS are blocked, so it falls back to drawn terrain and simulated walking.

## Architecture (inside the script)

- World frame: real SF in metres, origin (0,0) near 18th & Guerrero (`ORIGIN`, `ll2w`, `w2ll`).
- Hex grid (pointy-top axial, R=26 m) stores fog state: `S.cells[q,r] = last visit time`. Clear for 3 days, fades over the next 11 (`clarity`).
- Territory: closing a walked loop within ~24 m claims enclosed hexes (`checkLoop`, `claim`) into `S.owned`. Owned hexes that are still clear yield items once a day (`dailyYield`).
- Places: 37 hand-written story landmarks (`LANDMARKS`), OSM places from `places.json` (`OSMP`), daily drifts near home (`ensureDrifts`), and a hash-grid fallback (`poiAt`) only when places.json can't load.
- Each place offers one daily choice: gather / learn / befriend (+ survey at lookouts).
- Rendering: OSM raster tiles drawn one zoom out without smoothing (pixel look), then a low-res fog canvas with soft holes (`drawFog`), then sprites (`SPRITES`) and banners.
- Save: `localStorage['lamplighter-v1']`, plus manual save codes (base64 JSON) in Dispatch.

## Content

- Setting: the Wayfarer's Guild. Grounded, optimistic urban fantasy for adults; not twee. Factions: Hearthkeepers (cafés/bakeries), Track-Keepers, Courier Union. Cast: Maren (dispatch), Kip (courier, brass magpie), Professor Val (archives), Bramble (cat), Oriel (Guild physio). The fog is the Fading, which locals call Karl.
- The owner edits landmarks in the Claude Docs sheet "Scout's Folio Landmark Sheet": https://claude.ai/artifact/7cx9oVbZkZz15d2m1UHoBY
- Story bible (earlier, partly superseded): https://claude.ai/artifact/NCoe5RgWRef3Q2esEUGehc

## Known risks and next steps

- Web version cannot track with the screen locked. Native plan: wrap with Capacitor plus a background-geolocation plugin (Android foreground service).
- GPS jitter downtown; filters are basic (accuracy > 40 m dropped, < 4 m ignored, > 12 m/s dropped).
- GPS altitude is noisy, so Ascent XP is unreliable. Replace with a bundled SF elevation grid or the barometer (native).
- XP has no ceiling past the daily goal. Add diminishing returns around 1.5x the goal.
- Story landmark coordinates are approximate; snap them to OSM positions.
- Map tiles come from tile.openstreetmap.org: fine for one personal user, not for distribution.
- No automated tests yet. Pull the core rules (loop capture, fog decay, XP, yields) into testable functions before the native port.
