+++
title = "Week of Awesome 5 - Post-Mortem"
date = "Sun, 20 Aug 2017 00:34:09 +0000"
draft = false
tags = ["Programming", "Game Development", "Java"]
aliases = ["/2017/08/week-of-awesome-5-post-mortem/"]
+++

{{< thumbnail x400 "startscreen-screenshot.png" "Invasion of The Liquid Snatchers! - Start-Screen" >}}

Well the 5th Week of Awesome Gamedev competition is over! It's incredible to think that this thing has been running for half a decade.

So the way this competition worked this year is that there are four themes announced at the beginning of the week, which were: **Chain Reaction** | **Alien Invasion** | **Assassination** | **Castles**.  And each contestant needs to pick two of those and make a game around them, with a week to do so.

My game was <mark>"Invasion of The Liquid Snatchers!"</mark>.

The Idea
--------

Straight away **Chain Reaction** and **Alien Invasion** spoke to me as strong themes that would go well together. I had vague ideas for the other themes too so I spent my 1st day conceptualising ideas for different mixes of themes and trying come up with a viable concept.

In the end I settled on an idea where the game is staged from the perspective of an alien species who are invading Earth to harvest its resources. You play by helping a handful of blue-collar (manual labour) alien minions to undertake the "behind the scenes" activities of an on-going invasion. Activities such as processing Earth's resources or refuelling a wave of saucerships.

All of this would be driven by the use of the Earth-bound liquid resources that they had been collecting. **Water**, **Magma**, **Oil** and **Nuclear Waste** were the 4 resources that I settled on. From there I really, really wanted to try and manifest these using a real-time fluid simulation, because that just seemed like a novel and somewhat challenging thing to do - which is exactly the whole point of the gamejam for me: To push myself and do something different.

{{< thumbnail x400 "ingame-oilrefinery-screenshot.png" "Invasion of The Liquid Snatchers! - In-Game Screenshot" >}}

Each kind of fluid would serve a different function in the game: Water activates hydraulics (raises platforms or opens doors), Oil activates machinery, Nuclear Waste powers saucerships and Magma is supposed to be used by the aliens to forge saucerships.

The chain reaction theme would feature by way of the environment changing in response to these liquids (hydraulic platforms activating or mechanised gears rotating, etc). Most of those changes would be good and allow progression through the level but others would trigger "hazards in the workplace" such as having a row of missiles lined up to fall like dominos that end up crushing your minions!

What Went Well?
---------------

Let's see...

* **Time** \- I had the week off work. Never done that for previous years where I've always worked during the week. So this year I had a lot more free-time in comparison. I didn't spend it all programming mind you, but it was just nice to not have to hold down the day-job _and then_ spend my evenings coding as well!
* **Existing code-base** \- From the previous two times I have competed I have built up a thin framework over the top of LibGDX which really helps me hit the ground running. Mostly it's just resource caches for textures/sounds/etc and some 'fix your timestep' gameloop stuff. Nothing too fancy.
* **Shaders** \- My fluid simulation is rendered using a custom shader. I'm no shader expert having written a merely a handful of simple shaders in my time.Shaders cause(d) other people a lot of agro where their games don't work on other GPUs, etc. For that alone I tend to avoid them generally. But this year I couldn't, not for the fluid anyway. Fortunately I had very few issues with the shader authoring. I'll write a bit more about how the fluid sim works in a follow up technical post.
* **Audio** \- I was able to find online several soundbite recordings of water sloshing around (each 0-2 seconds long). I picked several that sounded good and classified them into two sets: One for water being _emitted_ and one for water being _collected_. Then to create the seamless sound of running liquid I select a sound snippet at random every 1 or 2 seconds and play it with sufficient falloff and overlap with the previous snippet while also making sure to never play the same sound twice in a row because humans are too good at noticing repeating patterns. It sounded pretty bad at first but after a but of tuning I'm quite pleased with the end result.
* **Art(?!)** \- As I say every year: I don't attribute myself with much of any digital graphics design skills and I'm colour-blind which is a huge pain in the ass for this sort of thing. So I try to mask my artistic failings with code. But I surprised myself with the art work this year, it kind of works I think?! For the first time this is ALL my own art work, I didn't take anything from the interwebs, I just used Paint.Net and a lot of it is drawn free-hand with the mouse.

What Went 'Not So' Well?
------------------------

* **Liquid CPU performance** \- To begin with I simply assumed that performance wasn't going be an issue in my little old game. I was wrong. It took some ingenuity to prevent the sim from becoming a bottleneck. Fortunately I have a copy of JProfiler which is my favourite profiler for finding performance hotspots. I'll write more about that in the follow up post about the fluid rendering.
* **Level creation** \- In previous years I would implement an ASCII-based level format that gives a reasonable-ish approximation of how the level will look on-screen. The idea works ok for purely grid-based worlds but it doesn't scale very well with multiple layers or when things are not grid-aligned. So this year I spent some time mid-way through the week to write a crappy in-game interactive level editor. Even with that I found it very hard to create engaging levels. And since my game is heavily physics-oriented I had to account for all sorts of "physics bullshit" in order to get each level to a point where it is deterministically solvable by the player and not just a big mess of physics stuff that may or may-not play out.
* **Box2D Determinism** \- It is my belief that Box2D is supposed to be deterministic (as long as the input is the same and the timestep is fixed - which it is). Yet I am definitely seeing slight variation from run-to-run. So I can't explain that yet. I need to investigate what the 'f' is going on there. For this time around I just decoded to design around the problem.

Reception So Far...
-------------------

So far I have had very positive reviews. First and foremost I'm very pleased to hear that people enjoyed the game.

Many/most of the criticisms I've received are about things which I completely agree with too, so no surprises there. I would definitely have fixed them where this not a week-long development. There's just not time to do everything unfortunately.

It's not known yet how all the judges feel as that still remains to be seen.

Riuthamus (one of the judges) [live-streamed his play-through of my game on Twitch](https://www.twitch.tv/videos/168126246). It was hilarious! He actually found some pretty decent 'alternative' ways of solving one or two of the levels that looks to me every bit as good as my intended solution. So that's fine by me! It was great fun to watch and valuable feedback too.

So How Does That Fluid Simulation Work Anyway?
----------------------------------------------

One of the biggest compliments I've had is when people think the fluid simulation is a soft-body physics or a true fluid simulation. It's really not 😛

I've decided to write up a technical article about the fluid simulation and rendering process which you can find [over here](/blog/fluid-rendering-with-box2d).

That's A Wrap!
--------------

I had good fun over the week and just want to extend a big thanks to the competition organiser (slicer4ever), to the other judges and to the prize-pool contributors.  They have all done a fantastic job at making this competition happen! Every year I see the competition evolve in very positive ways!

And good luck to all the contestants!