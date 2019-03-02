+++
title = "Week of Awesome IV - Gamut of Blob - Postmortem"
date = "Mon, 15 Aug 2016 23:44:26 +0000"
draft = false
tags = ["Programming", "Game Development", "Java"]
aliases = ["/2016/08/week-of-awesome-iv-gamut-of-blob-postmortem/"]
+++

Embarrassingly I haven't used this blog in 2 years and that was for my WoA2 postmortem!

Well WoA4 is over and I am super pleased with my entry. It is somehow more complete and polished than I had anticipated to achieve considering I had a full week of work and a couple of weekend commitments that would see me Macbook-bound for the majority of the weekend.

This year announced 4 themes and contestants were expected to select and incorporate 2 of these for their game: **Shadows, Evolution, Ruins, Undead**.

A restriction was that Shadows and Evolution had to manifest as gameplay mechanics, whilst Ruins and Undead would need to manifest as graphical theming. Since I am no artist, it takes me a long time to produce art and I have no experience producing art of any kind on a Mac, I decided to opt for the 2 gameplay themes: Shadows & Evolution.

Scope is always an issue in any project. So I took the entire Monday just to let the themes sink in and try to come up with an idea that was appropriate in scope for the free-time I had. I was open to extremely simple games like Flappy Bird but I simply could not marry that up with the requisite themes (evolution, shadows, ruins, undead) in a way that enthused me. Also under consideration was a farming game where veggies are bred and transmuted to achieve a desired phenotype with a supply & demand mechanic driving that, as well as some kind of underwater game like flOw. Both interesting ideas but were too ambitious.

The idea I went with was top-down maze-puzzler with minimalist graphical look featuring cute little blob creatures. Gameplay-wise I was partially inspired by games like Chronotron or the Clank levels from Ratchet & Clank: A Crack in Time. In these games there is a way to generate multiple versions of yourself which must collaborate together to finish the level, things like standing on buttons to open gates. While I did not include their time-travelling mechanic I do have lots of cute little blob creatures running around standing on switches to banish **shadows** and allow fellow blobs to progress. Blobs can replicate themselves by finding DNA/gene fragments in the level; picking these up will spawn an **evolved** blob friend, each blob colour has a unique skill which allows it to access parts of the map that your regular unevolved green blob is unable to reach.

{{< thumbnail x400 "ingame-screenshot.png" "Gamut of Blob - In-Game Screenshot" >}}

The great thing about this idea is that it scales up/down depending on how productive I am: If things go well I can always develop new types of blob which enables new gameplay elements. If things go slowly then I can scale back on my ambitions for lots of different kinds of blob and focus up on just getting \*something\* done. My original plan included 5 types of blob:

*   Green - The standard unevolved blob
*   Blue - Able to swim and pass through water.
*   Red - Tolerant to extreme temperatures and can walk over lava.
*   Purple - Resistant to the genetic stresses of teleportation and can use teleport pads.
*   Yellow - Speedy, takes long straight paths very quickly and does not stop until it hits a wall.

I probably could have implemented all of these if I had sacrificed some polish but I didn't want to do that.  In the end I managed all but the Yellow blob, not bad at all! And I don't feel that the game has suffered at all.

One of the hard-learned lessons from previous years was that starting from a position of no code (just an empty main() method) is tough going. I end up spending a good 2-3 days just knocking out basic infrastructure (resource management, game-states, sprite-rendering, audio, physics, etc). So this year I prepped a very light-weight game-agnostic framework based on LibGDX to handle all that. This was a massive productivity boon and this 'engine' wasn't at all constraining either having received only a minimal amount of frantic hack'n'slash near the end, which I will probably refactor and generalise for the future!

Something that didn't work out as well I had hoped was the level file format. I used a similar format to my WoA2 game which worked very well for that game. However this time around I had lots of layers to the map and keeping them in-sync was an error-prone head-ache. Some kind of level-editor would have gone a long way to ameliorating this but there wasn't time for that kind of development. Perhaps for next time I can generalise the concept of a tile-based level editor? Or learn to use an existing one and write an importer for its file format.

Overall, as usual, it was a lot of fun. Very tiring. But a lot of fun.

I have whizzed through playing the other contestants' games (need to go back and play some of them for longer) and I have to say that I really do not have a good sense for where my game will place amongst them once the judging is over. As usual I am blown away by what people are able to achieve in a week!

Congratulations to everybody who managed to submit an entry. I am looking forward to next year's competition already! 😉