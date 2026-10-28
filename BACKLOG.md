# Backlog

Everything open, newest priorities first within each section. Claude keeps this file: the owner reports things in chat, and Claude writes them here, sorts them and moves them to Done with the date and commit.

Priority order: **knee safety → bugs → things walk reports asked for → ideas.** Real walks decide priorities, not ideas from the couch.

## Now: phone test week

- [ ] Owner installs the game from https://flailingly.github.io/lit-path/ and walks with it for 5 to 7 days.
- [ ] Owner sends walk reports: what was fun, what was annoying or confusing, battery use with the screen on, anything that triggered in the wrong place. Screenshots welcome.

### Walk log

- 2026-10-28, walk 1: about a 20-minute loop from home with a short shop stop. GPS tracking was better than Google Maps. Battery about 100% → 77% with the screen on at full brightness the whole time (about 1% a minute, so measure again at normal brightness). Knee: the game did not push for more, but missing the two drifts made the owner think about doubling back for them.

## Knee safety


- [ ] XP has no ceiling past the daily goal, so the game rewards overdoing it. Add diminishing returns past about 1.5x the goal.
- [ ] Hills and stairs (climb errands, Track-Keeper readings, the High Ground chapter) should unlock only when the owner says their physio has cleared them, not by level alone.
- [ ] Walking while looking at the screen is a trip hazard. Long-term fix is the native app (pocket the phone, buzz when something is near). Short-term, keep on-screen actions to "do it when you get home".

## Bugs and known weak spots

- [ ] **Drifts can land inside buildings.** They are placed at a random angle and distance from home, so one Shimmer sat inside a house, about 30 to 40 m off the street. Fix: move each drift to the nearest point on a street or path, or onto a real public place.
- [ ] **The Guild board can offer the same errand twice.** Screenshot: Home showed "Survey the edges: Ink 18 hexes nobody in the Guild has mapped yet. +46 XP" twice, one accepted and one not. `makeOffers` picks each of its two errands separately and doesn't check for repeats. Fix: never offer the same errand type twice.
- [ ] **Walk time reads low.** The owner was out about 20 minutes; the game counted 13. The shop stop is left out on purpose (time only counts while moving), but a gap of more than 30 s between GPS fixes also counts as zero time, and phones often space fixes out. Check against the next walk; consider showing both "time out" and "time moving".

- [ ] GPS jitter downtown can add fake distance or claim territory through buildings. Filters are basic (accuracy > 40 m dropped, < 4 m ignored, > 12 m/s dropped). Tune from real walk data.
- [ ] Ascent comes from GPS altitude, which is off by 10 to 30 m. Replace with a bundled SF elevation grid (web) or the barometer (native).
- [ ] The 37 story landmarks were placed from memory and some may be off by a block. Snap each one to its OpenStreetMap position.
- [ ] Map tiles need a network connection; dead zones show a blank map. Consider caching tiles for the home area.

- [ ] Outside San Francisco the game has almost nothing to find: `places.json` only covers SF, and the random fallback places switch off once it loads. A friend elsewhere would get fog, territory and drifts, but no places. Fix: re-enable fallback places wherever no real places are nearby.
- [ ] Untested on iPhone (Safari). Should work, but nobody has tried it.

## Asked for in walk reports

- [ ] **End-of-walk summary: "here's what you collected."** Today territory yields items once a day as an overnight toast (`dailyYield`), and nothing sums up the walk itself. Owner wants every owned area to gather something while you walk through it, and a short, satisfying recap when you end the outing (distance, time, hexes, drifts, items). The summary is the most important part; build it first.
- [ ] **Every walk should include at least one choice or interaction**, even if it isn't main story. Ideas: a drift that is always placed on today's likely route, or a small either/or at the end-of-walk summary. Game logic goes here; the writing goes to the content session.
- [ ] **Oriel's check-ins feel one-way.** Owner likes the physio notes but wants to interact with them, or at least see a log of past check-ins (knee rating by day, what Oriel said).

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
- 2026-10-28: Fog no longer goes fully grey after the screen is turned off and on: the fog brushes are rebuilt whenever the page comes back (walk 1). Tested by firing the resume events in the browser; still needs a real phone check.
- 2026-10-28: Drifts are collected automatically within 60 m, with a "+25 XP" toast, so there's no reason to double back for one (walk 1). The Investigate button still works for reading them.
