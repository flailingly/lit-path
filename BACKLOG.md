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

- [ ] **More than one camp choice, tied to what you met on the walk.** Today Camp & Debrief offers one generic A/B pair. Owner wants a choice for each notable thing met on the way (a place visited, a drift, a person), using its name and kind. Suggested: up to 3 per debrief, built from per-kind templates (grove, mural, archive, Hearthkeeper, lookout, spring, echo, drift types, story landmarks). The template text goes to the content session.
- [ ] **Oriel's check-ins feel one-way.** Owner likes the physio notes but wants to interact with them, or at least see a log of past check-ins (knee rating by day, what Oriel said). Partly done: the Journal now lists past check-ins with Oriel's replies. Still open: some way to interact with her.

## From the owner's field guide prototype (2026-10-28)

The owner built a separate prototype, "The Wayfarer's Folio: An Enchanted City Field Guide" (kept outside the repo). Much of it is mocked up with fixed text, but these ideas are worth bringing into this game:

- [ ] **Named districts with "% surveyed"**: explore 50% of a named area to claim it, with no loop needed. Use real SF neighborhood boundaries (not drawn rectangles) so it works anywhere. Keep the hex loops as well.
- [ ] **District dossiers and ledger**: tap a district to see its lore, elevation and progress; a list shows every district. Lore writing goes to the content session.
- [ ] **Progress clocks on encounters**: small boxes that fill over several visits, so places and people build up over time.
- Left out on purpose: a daily distance target that rises on its own (the game must not set rehab pace), items with fake medical effects (poultices, "+20% knee cushion"), step-rate targets, borrowed names ("Marauder's Map", "Hitchhiker's Guide"), test controls on the main screen, and switching to Leaflet and Tailwind.

## Content

- [ ] Write more Camp & Debrief choice pairs. There are only 4 (`CAMP` in `lamplighter.html`), so they will repeat within a week. Each pair is two short options plus a one-line result in a character's voice; rewards are a friendship, an item or XP.
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
- 2026-10-28: New look: leather and brass top bar and buttons, serif headings on sheets, pixel text kept for collection messages (STYLE.md updated).
- 2026-10-28: Camp & Debrief: ending an outing lists the places, drifts and items found, territory claimed, then one either/or choice (+15 XP and a friendship or item). Walking through your own territory turns up 1 find per 8 hexes, at most 3 a day. Tested with simulated walking.
- 2026-10-28: Screens reorganized so every control leads somewhere different. Bottom: Today (Maren's dispatch, drifts, errands, rest day), Journal (week strip, recent walks, Oriel check-in history, story, log), Set out, Satchel (items only), Guide (places, territory, people, Bestiary, lore). Top: level badge opens the Scout record (stats), the goal ring is a gauge only, and a gear opens Settings and saves.
- 2026-10-28: Map is quieter: tiles capped at zoom 16, so house numbers are gone and street names stay (bigger and chunkier when zoomed in). Business and building labels mostly drop out too.
