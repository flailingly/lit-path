# Scout's Folio

A walking RPG laid over real San Francisco, made to get one person out the door during knee surgery recovery (ACL and meniscus).

You're a Scout of the Wayfarer's Guild, mapping the Hidden City: a quiet, magical layer of San Francisco that only shows up for people who walk slowly enough to notice it. Walking lifts the fog off real streets, walking a loop claims the ground inside it, and real parks, murals, cafés and landmarks turn into places with people, stories and things to gather.

## How it plays

- **Fog:** streets you walk stay clear for 3 days, then the fog (locals call it Karl) slowly settles back over the next 11.
- **Territory:** close a loop on foot and every hex inside is yours. Ground you keep clear gathers items for you each day.
- **Places:** 37 hand-written story landmarks, plus about 2,200 real places from OpenStreetMap.
- **Daily choices:** at each place, choose once a day to gather, learn something, or spend time with whoever is there.
- **Recovery-friendly:** a daily goal in minutes that grows slowly, a knee check-in after each walk, and rest days that keep your streak.

This is a personal project, not medical advice. The game only nudges. Your surgeon's and physio's limits come first.

## Running it

The game is a single web page: `lamplighter.html`.

```powershell
powershell -File tools/build.ps1   # builds the phone-ready folder in lamplighter-phone/
powershell -File tools/serve.ps1   # serves it at http://localhost:8765
```

Real GPS only works over HTTPS, for example once `lamplighter-phone/` is deployed to a static host. Without GPS you can still play with simulated walking: tap the map to walk.

## How it was made

This project is built almost entirely with Claude (Anthropic), an AI model, working from the owner's design direction and playtesting. If your project or community has rules about AI-generated code, please take that into account.

## Credits and licenses

- Code: MIT License (see `LICENSE`).
- Story, characters and writing: CC BY 4.0 (see `CONTENT-LICENSE.md`).
- Map tiles and `places.json`: © OpenStreetMap contributors, available under the Open Database License (ODbL). https://www.openstreetmap.org/copyright
- Fonts: Pixelify Sans, IM Fell English and Atkinson Hyperlegible, via Google Fonts (SIL Open Font License).
