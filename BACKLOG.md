# Backlog

Everything open, newest priorities first within each section. Claude keeps this file: the owner reports things in chat, and Claude writes them here, sorts them and moves them to Done with the date and commit.

Priority order: **knee safety → bugs → things walk reports asked for → ideas.** Real walks decide priorities, not ideas from the couch.

## Now: phone test week

- [ ] Owner installs the game from https://flailingly.github.io/lit-path/ and walks with it for 5 to 7 days.
- [ ] Owner sends walk reports: what was fun, what was annoying or confusing, battery use with the screen on, anything that triggered in the wrong place. Screenshots welcome.

### Walk log

- 2026-10-28, walk 1: about a 20-minute loop from home with a short shop stop. GPS tracking was better than Google Maps. Battery about 100% → 77% with the screen on at full brightness the whole time (about 1% a minute, so measure again at normal brightness). Knee: the game did not push for more, but missing the two drifts made the owner think about doubling back for them.

## Knee safety

- [ ] Missing a drift tempts a detour. On walk 1 the owner walked past a Shimmer and a Familiar, did not get them, and thought about looping back. Drifts should be collected when you pass them (see Bugs) so nobody adds distance to chase one.

- [ ] XP has no ceiling past the daily goal, so the game rewards overdoing it. Add diminishing returns past about 1.5x the goal.
- [ ] Hills and stairs (climb errands, Track-Keeper readings, the High Ground chapter) should unlock only when the owner says their physio has cleared them, not by level alone.
- [ ] Walking while looking at the screen is a trip hazard. Long-term fix is the native app (pocket the phone, buzz when something is near). Short-term, keep on-screen actions to "do it when you get home".

## Bugs and known weak spots

- [ ] **The map goes back to full fog after the screen is turned off and on (walk 1).** Screenshot: right after getting home, the whole map was grey fog, including the loop just walked and the clear circle that should always surround the Scout. Only the drift labels, Home and You showed through. The walk was still saved: the Satchel still said 22 hexes held and 22 clear. Likely cause: when Chrome on Android puts the page in the background, it can wipe canvases that were drawn ahead of time, and the fog uses two of these (the soft round "brush" that cuts holes and the fog texture). With the brush blank, nothing gets cut out. Fix: redraw both when the page comes back (`visibilitychange` / `contextrestored`). Workaround until then: reload the page.
- [ ] **Walking past a drift does not collect it.** Today you must be within 48 m of the drift *and* tap the "Investigate" button that appears at the bottom of the screen. The owner walked a loop past the Shimmer and the Familiar, expected passing by to count, and got neither. Fix: collect automatically within about 60 m (GPS error downtown is 10 to 30 m) and show what you got in the end-of-walk summary. Keep the button for when you are standing still.
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
