+++
title = "\"Week of Awesome II\" - Post-Mortem"
date = "Wed, 01 Oct 2014 17:43:42 +0000"
draft = false
tags = ["Programming", "Game Development", "Java"]
aliases = ["/2014/10/week-of-awesome-ii-post-mortem/"]
+++

Amazingly it has been a whole year since Gamedev.net hosted the first Week of Awesome competition. I competed last year and [wrote a post-mortem of my game](/blog/week-of-awesome-1-post-mortem/ "My “Week of Awesome” Competition Entry: Post-Mortem") so it's that time again! A bunch of people have already written up post-mortems, which is great to see. As far as I recall last year only a couple of us did.

This year the rules were much the same: A theme is announced at the start and 7 days with which to implement that into a playable game.

Last year the theme was about what if dinosaurs were still alive. This year the theme was "**The toys are alive!**". I'm beginning to notice a sub-theme going on 😉

You can download my game (with a few bugfixes) here: [Save My Toys.zip](https://github.com/daveagill/WoA2/releases/download/v1.0/Save-My-Toys.zip)

{{< thumbnail x400 "startscreen-screenshot.png" "Save My Toys - Start Screen" >}}

What follows is my post-mortem, covering how I approached the problem and how I thought it went after-the-fact...  

Early Considerations
--------------------

Before even knowing the theme there are some considerations to make.

*   I am working by myself on this.
*   I am a good programmer (I think) and precious little else - Not an artist, sound designer, level designer... nothing.
*   We have only 7 days available to build/test/polish a game and I have work on 5 of those too.
*   I believe the secret to a good entry is to have a simple idea that is executed well. (The secret to a winning entry might well be a big idea executed well, but that's something else entirely)
*   When brainstorming ideas it is important to stop and think about how that idea will rack up points from the individual judging criteria. Which include categories like graphics, gameplay, sound, etc.

With these things in mind there is no chance of me making an asset-heavy game. If it requires 3D meshes, skeletal animation, complex sprites, custom sound FX, complex manually-created levels -- basically anything like that. It won't work for me. I am more or less limited to a 2D game with simple, (mostly) static sprites. Last year I got around this by going for a deliberately over-simple MSPaint look and procedurally generated levels, I wanted to try something a bit different this year though.

Additionally it goes (almost) without saying that scope will be a constraining factor here, and feature-creep is an ever-present enemy of any project.

Toy Theme & Brainstorming
-------------------------

The toy-related theme was challenging because it's not an abstract idea (like "Light vs Dark" say). I concluded that one simply cannot get very far without actually rendering some toys to the screen at some point - and asset production is a major nemesis here.

Being a cutesy theme I wanted some cutesy graphics and was reminded of an artist called Kenny who had posted on GDNet some months prior to tell us all about his free-to-use tilesets that he'd created. I was impressed at the time and quickly hunted them down: [http://opengameart.org/users/kenney](http://opengameart.org/users/kenney) This guy has done a wonderful thing because are all licensed to Creative Commons Zero which puts them in the Public Domain, as in totally freebee!

It's hard to pass up a resource like that, so I very easy settled on the idea of a tile-based game. At this point I brainstormed 3 possible ideas:

*   [Sokoban](http://en.wikipedia.org/wiki/Sokoban) \- The idea would be you play as "Mom" or maybe <Insert Generic Child Name Here> tidying away the toys who had up'd and littered themselves around the bedroom during the night.
*   A [Rodent's Revenge](http://en.wikipedia.org/wiki/Rodent's_Revenge) variant - Except obviously instead of cat and mouse, the toys would be defending themselves against some kind of enemy (maybe Mom is the enemy?)
*   A [Lemmings](http://en.wikipedia.org/wiki/Lemmings_(video_game)) variant - You control a stream of alive toys who are just trying to get home.

I decided to discard Sokoban. As a core idea it is too simple - I would easily have that game polished in just a few days which would be a waste of the full week. At the same time the prospect of extending the gameplay is daunting. It turns out that the impressive thing about Sokoban is not the gameplay itself, it's the fact that some poor guy once managed to dream up those devilish maps!

Rodent's Revenge didn't really inspire me enough so Lemmings it was! This was always going to be a favourite idea as I have long wanted to make a Lemmings variant.

I began researching for ideas that would be a good fit for a tile-based version. In original Lemmings you assign individual lemmings to specific tasks and they add/remove terrain pixels which alters the flow of those low-res dudes. I had a simpler idea in mind where the Toys are completely self-autonomous and instead you indirectly control them by adding behaviour-altering tiles to the map (like making them jump, turn around, land safely, explode, etc).

I drew my early inspiration from a game called [MinimaLemmings](https://www.google.co.uk/webhp?#safe=off&q=minimalemmings); my research indicated that this game has been cloned/re-skinned by others. I didn't want to clone it but I really liked the core idea of placing jump tiles, so I "borrowed" that and consequently paid homage to them by roughly basing Level 5 "Difficulty Gradient" from their first level. The forces and velocities between my game and theirs aren't the same, so I was surprised to be able to mimic that level so easily to be honest!  

What went well?
---------------

### Sprites & Animations

Kenny's tiles are great, not only are they a source of inspiration all on their own (mushrooms!), but they work beautifully in the game. At least I think so, I \*am\* colour-blind so take that sentiment with a pinch of salt 😉

I drew all the toys and their animation frames myself (and the angled mushrooms). Granted they are very simple but I am no artist so I am pleased with the result. I think the cutesy animations work well with the rest of the game.

### Level Design

To some extent, this remains to be seen as they haven't been extensively play-tested yet. For all I know there are flaws in them. That being said, I am pleased with the number and quality of the levels I managed to produce.

The fact that this year I was making a game which would require manually-crafted levels was a major concern to me all the way through, at least until day 6 when I had managed to put a few together finally. In the end I managed to produce 10 levels in the game, in increasing difficulty, although the early levels are really quite easy and exploit low-hanging fruit in terms of level design.

To help ease level production and mitigate the amount of time spent fixing level design flaws close to crunch time I came up with a file format that could convey the shape of the level straight from a text file - quick, easy and low-tech!

For example, here is level4.txt:

```
<level name="Hazards can be Hazardous!">
    <rescue>10</rescue>
    <map>
        X . . . . X X X X X X X X .
        # . . . X # # # # # # # # X
        # . . F # . S . . . . . . #
        # . . # # # # # # # . . . #
        # . . . . . . . . . . . . #
        # . . . . . . . . . . . . #
        # # # X X # . X . X X # X #
        # # # # # # . # # # # # # #
    </map>
    <spawnerConfigs>
        <spawn amount="10" freq="0.5" />
    </spawnerConfigs>
    <inventory>
        <blockers available="5" />
        <jumpSingle available="5" />
        <jumpDouble available="5" />
        <jumpLeft available="5" />
        <jumpRight available="5" />
    </inventory>
</level>
```

I opted for "convention over configuration" when it came to levels, meaning I could trivially add new levels just by dropping a file called "levelN.txt" (just replace 'N' with a consecutive level number) and the game will load to it when appropriate. No need to register the files with the code.

### Time Management

Unlike last year I was more or less on top of my time management this year. My minimum viable entry was essentially ready by some point on day 6 so I had a whole day and half to iron out bugs, design levels and apply other polish.

Part of the reason for this was that I had learnt lessons from last year which minimised the amount of time I spent hunting down terminal bugs. I cpy()'d my Vector2's, I deferred my Box2d deletes and I had last year's readme to point me in the direction of good sites to find free fonts and sounds!

### Building, Packaging & Deployment

On the week prior to the competition I spent a bit of time nailing the build, package and deployment processes. As this was something that very nearly sunk the ship last year since I left it till the last minute.

First I bundled a complete JRE with my game, so no external dependencies for judges to install! Until the promise of a modularised Java 9 comes out the current JRE is still huuuuge so I had to trim it down a tad. Oracle publish a list of optional files and note one big-ass uncompressed JAR that can be compressed. By eyeing it up, I reckon the JRE is still way fatter than I needed but unfortunately Oracle doesn't permit you to remove anything further for licensing reasons.

I also needed a way to connect my game with that JRE. A batch script would do it but isn't very pretty so I found a project called [Launch4j](http://launch4j.sourceforge.net/) which creates an .exe that will launch your JAR for a given JRE - perfect!

Finally, LibGDX (the simplistic game framework I was using) has radically changed their build process since I last played with it. They now use a tool called Gradle, which is a coming together of Groovy, Ant and Maven into a single build tool. It's quite swanky but I am not familiar with it. So I had some tedious "fun" getting all that to work correctly.

By doing all this the week before, I could just focus on the game itself.  

What went wrong?
----------------

### Non-gameplay Screens

Those following my progress updates during the competition would have seen that I posted a few times about getting non-gameplay screens working. My update loop, input handling and rendering were so slapdash that it wasn't possible for me to handle anything that wasn't "in-game". I decided to expend a bunch of time refactoring them to support non-gameplay screens and I ended up re-inventing the old idea of GameStates once again.

Unfortunately I spent so much time doing this that in the end I didn't have the time to fully exploit the feature. My final game has only 4 states:

*   Start screen
*   Text-based intro screen
*   In-game
*   Text-based end-game screen

Whereas I planned to have highscores and level-selection screens. But hey ho.

The idea and implementation of GameStates is very generic but very useful. I think for next year I will prepare in advance an empty LibGDX project template that includes a GameStates implementation from the beginning.

### Box2D is a Physics Engine and will always want to be a Physics Engine!

I coped with this by staying calm. But I know that Box2d is basically a poor choice for the movement controllers in my game.

What I really wanted was:

*   Non-physical horizontal movement but fully-elastic rebound off walls.
*   Gravity (read: physical vertical movement) but completely inelastic landing on floors.
*   Non-physical (but physically "believable"!) jumping movements.
*   Collision detection & resolution (but NOT involving conservation of momentum, etc).

You basically have to fight Box2d to get the non-physical behaviours that you want. On the whole what I want is a colliding kinematic simulation, not a dynamics simulation.

I could probably write one myself, but not in the timeframe of the competition. I decided it would be wiser to fight with Box2d and get the result I wanted.

The magic here basically amounts to tracking velocity yourself outside of Box2d and just keeping the simulation in sync using setLinearVelocity(). Gross but it works.

Additionally, to get completely plastic collision against the ground working well, I had to implement a ContactListener and disregard the contact entirely. To start with I was just detecting the case using the impact normal and calling setLinearVelocity with a zero'd vertical component to remove any bounce, but it was producing visual artifacts (I presume because it was - by necessity - spread across two update cycles with a frame rendered in-between).

Lots of hair-tearing fun to be had all round! Like any framework though, it's a matter of becoming familiar with its foibles.

### My Upload Speed

I always forget how crap my home internet is. It took me 20 - 30 minutes to make an upload. What I should have done is get it all setup on my work PC, remote into it and do the upload from there!

Since I was making incrementally more-finished uploads as the competition drew to a close I ended up losing a couple of hours total just managing my uploads - each one was very tense and I could hardly focus on code while one was going on. I would have liked to churn out a couple more levels, but nevermind.

What Got Cut?
-------------

With more time I would have extended the player's tool-set to include one-way barriers and explosives (sacrifice a toy to carve a route through for others in its wake - ala traditional Lemmings blowing up).

I would also have liked to explore the lock-and-key mechanic more. I had different coloured lock and key sprites, which would have been used for more complex puzzle logic. I only managed to make a couple of levels involving these, which doesn't do it justice really.

I also wanted a level where you have a stream of toys that spawn at a slower frequency and you exploit that to split the stream into two teams which head off in different directions simultaneously.

In-game-help - Like last year I wanted to introduce signposts that would popup helpful tips and comedy relief. Some signposts would be off the critical path and only there for the hard-core players to reach.

Gems - Some kind of collectible that would encourage replay and allow for gauging how good a particular solution was.

Water - I had spikes and water was essentially just another hazard. I had pondered the idea that maybe only the ball and the duck could cross water tiles.

One-way Platforms - Currently solid blocks will block from all directions. But there was an occasional need (that I had to work-around in the level design) for a platform tile that could be passed through from the under-side but would be hard like a floor when landed on.  

Final Thoughts
--------------

Once again the competition was a load of fun. It eats a week of your life but the result always feels completely worth it.

I have played many/most/all of the other entries and they are impressive to say the least. Those made with Unity are of particular interest because the pace at which those contestants could churn out gameplay was staggering. I think I will have to spend some time getting to grips with Unity at some point - who knows maybe next year's entry from me could be Unity powered!

It is interesting actually, the shift in technology choices since last year. This time around there were a lot of people using Unity and other engines. Last year there was a high percentage of Java/LibGDX entries, but only 1 or 2 this year. I expect next year will be even bigger and badder as the competition gains visibility and people improve their skillsets.

Since I was using github to keep my codebase in sync between home PC and travelling laptop my code is (and always was!) available online. But I have spent a bit of time today converting my readme to markdown and cleaning up directories, etc. You can find the repo here: [https://github.com/daveagill/WoA2](https://github.com/daveagill/WoA2)

Now it's all in the hands of the judges.

Good luck to everybody!