# Backlog

Everything open, newest priorities first within each section. Claude keeps this file: the owner reports things in chat, and Claude writes them here, sorts them and moves them to Done with the date and commit.

Priority order: **knee safety → bugs → things walk reports asked for → ideas.** Real walks decide priorities, not ideas from the couch.

## Now: phone test week

- [ ] Owner installs the game from https://flailingly.github.io/lit-path/ and walks with it for 5 to 7 days.
- [ ] Owner sends walk reports: what was fun, what was annoying or confusing, battery use with the screen on, anything that triggered in the wrong place. Screenshots welcome.

## Knee safety

- [ ] XP has no ceiling past the daily goal, so the game rewards overdoing it. Add diminishing returns past about 1.5x the goal.
- [ ] Hills and stairs (climb errands, Track-Keeper readings, the High Ground chapter) should unlock only when the owner says their physio has cleared them, not by level alone.
- [ ] Walking while looking at the screen is a trip hazard. Long-term fix is the native app (pocket the phone, buzz when something is near). Short-term, keep on-screen actions to "do it when you get home".

## Bugs and known weak spots

- [ ] GPS jitter downtown can add fake distance or claim territory through buildings. Filters are basic (accuracy > 40 m dropped, < 4 m ignored, > 12 m/s dropped). Tune from real walk data.
- [ ] Ascent comes from GPS altitude, which is off by 10 to 30 m. Replace with a bundled SF elevation grid (web) or the barometer (native).
- [ ] The 37 story landmarks were placed from memory and some may be off by a block. Snap each one to its OpenStreetMap position.
- [ ] Map tiles need a network connection; dead zones show a blank map. Consider caching tiles for the home area.

## Content

- [ ] Sync the landmark sheet into the game whenever the owner adds a batch: https://claude.ai/artifact/7cx9oVbZkZz15d2m1UHoBY
- [ ] Personal places (home block, favorite bench) go in `private/`, which never reaches GitHub.
- [ ] Each place offers only 2 lore lines, so repeat visits will start to repeat. Write more lines, prioritizing the places the owner actually walks past.

## Next big steps

- [ ] Native Android app: wrap the web game with Capacitor plus a background-geolocation plugin, so tracking works with the screen off. Build it in the cloud with GitHub Actions so nothing needs installing locally.
- [ ] Saves live only in Chrome's storage on the phone. Move to a proper on-device database in the native app, with an optional backup.
- [ ] Pull the core rules (loop capture, fog fade, XP, daily yields) into small testable functions with automated tests before the native port.

## Ideas (not scheduled)

- [ ] Bundle the fonts with the game so it never contacts Google Fonts (cleaner supply chain).
- [ ] Real SF weather: foggy days change what drifts appear.
- [ ] Muni rides as fast travel to reach far neighborhoods early, without the ride counting as walking.
- [ ] Benches as rest spots: sit for 2 minutes for a small bonus.

## Done

- 2026-10-28: Real pixelated SF map, real-looking fog, loop capture and territory, daily drifts, 2,189 OpenStreetMap places, Wayfarer's Guild setting and cast.
- 2026-10-28: Project moved into git, published at https://github.com/flailingly/lit-path, live on GitHub Pages.
