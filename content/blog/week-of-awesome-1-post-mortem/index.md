+++
title = "My \"Week of Awesome\" Competition Entry: Post-Mortem"
date = "Sun, 08 Sep 2013 01:18:41 +0000"
draft = false
tags = ["Programming", "Game Development", "Java"]
aliases = ["/2013/09/my-week-of-awesome-competition-entry-post-mortem/"]
+++

So it's been a while since I last posted but here I am writing a new entry!

The other week I competed in the unofficial [GameDev.net 'The Week of Awesome' game development competition](http://www.gamedev.net/topic/646780-the-week-of-awesome-unofficial-gdnet-competition/ "The Week of Awesome GDNet Competition Thread."). The idea is you're given a week to develop a game and the game must fit a theme which is only announced at the very start of the competition. The theme was: "What if Dinosaurs hadn't gone extinct?" There were various takes on the theme, all of them were good ideas.

My take on it was that the dinosaurs didn't go extinct because, after the meteorite hit, they came back to 'life' as zombies. Clearly then the hordes of dinos romping around are the bad guys. To bring a good-guy into the mix (and therefore the player)  I settled on the idea of Granny who was on her way out to the Bingo but is highly inconvenienced by the zombie dinosaurs; hence her reason for kicking some zombie-dino butt.

For anyone looking to download my entry, you can download it here: [Granny v.s. Zombie Dinosaurs](https://github.com/daveagill/GvZD/releases/download/v1.0/Granny-v.s.-Zombie-Dinosaurs.zip). You'll need at least Java 6 to run it.

Planning
--------

The first thing I did was to plan the game. I don't think you have to plan every aspect of something before you start coding. I'm a strong believer that requirements can rarely be gathered in full in advance and they _will_ change once the thing begins to take shape and new & improved ideas begin to form in peoples' mind. Maintaining a level of agility is important and, let's face it, we've only got a week to develop a game. Analysis paralysis is something to be avoided.

{{< thumbnail x300 "planning1.jpg" "Initial Sketches of Dinosaurs" >}}

My planning involved sketching ideas down in a notebook. I already knew I wanted to do a 2D side-scroller with zombie dinos coming in from both sides of the screen so it was really the case of fleshing that out a bit:

*   What would the dinosaurs look like?
*   What would the main character be and look like?
*   What would the world look like?
*   Miscellaneous things: Weapons, pickups, etc

{{< thumbnail x300 "planning2.jpg" "Initial Sketches of Granny" >}}

One of the key things for me was to play to my strengths: I am a good programmer. I am somewhat creative and artistic but I am NOT an artist. I know nothing about making music, sound effects or animation. Sophisticated artwork would take time to produce; waste time even! The game needed simple graphics that could be produced quickly. Which means they either need to be abstract shapes that can be rendered by code, or they need to be simple sprites that I can knock together quickly in Paint. Since we're talking dinosaurs rather than just squares and circles, I opted for the latter. I've always liked the idea of making a monochrome game, just two colours. Like as if you're playing as silhouettes. So I thought I would test that out somewhat with this: White on Black. That would play nicely with my goal of simple graphics as there would be very little detail within each sprite.

Development
-----------

In keeping with the goal of playing to my strengths I opted to use Java for the development language. I use it everyday at work, so my present state of familiarity with the language is very high. For the graphics I chose LibGDX, which is a framework I dabbled with once before and it imparted a good impression. In fact, they have a swanky looking website now, so it's obviously doing well. Turned out that 4, if not more, of the other entries also used libGDX so it must be gaining traction.

Since I was doing a 2D game I decided to stick to libGDX's 2D framework, which is a high-level abstraction over OpenGL in the form of textures, sprites and batched-rendering. It's easy to use, which is the important thing.

I wanted to have non-flat ground and I wanted Granny to be able to jump. This meant I needed at least rudimentary physics for gravity and ground collisions. Throw in the requirement to track collisions between Granny and dinosaurs (for them to inflict damage) and between Granny's bullets and the dinosaurs - and I decided to just go right ahead and integrate Box2D (of which libGDX includes a JNI wrapper) to handle the collision detection and entity movement.

{{< thumbnail x400 "day-4-screenshot.png" "Day 4 progress screenshot" >}}

I posted almost-daily progress updates on [the GDNet forum topic](http://www.gamedev.net/topic/646780-the-week-of-awesome-unofficial-gdnet-competition/ "The Week of Awesome GDNet Competition Thread."), which included screenshots. The important thing was to stay focused; to always have it clear in mind what feature I'm implementing currently and which features I wanted to pick off next of all. Such as today I'm all about integrating physics, or today I want a highscrores table and improved blood, etc.

I made the deliberate decision not to worry too much about the code health as I won't be maintaining it long-term. There are various devices in software engineering that slow down the short-term development in favor of improved maintenance and development costs in the long term. Things like coming up with a perfect abstraction and removing duplicate code, etc. By not doing these things you accrue technical debt that must be paid off later on, but if there is no "later on" then it's a no-brainer that getting shit done fast is a Good Thing (tm), especially for a competition. As a result I have plenty of duplicate code. Rather than trying to common-up the granny entity with the dino entity, I just have two classes: Granny and Dino. Both of these do a lot of the same stuff. I could have created an abstract base class for them both, but I was worried that I would need to slap in hacks at the final second and by having them share code would make that kind of thing harder to do.

I had it fairly well defined in my head that the World, Granny, Dino, Bullet, etc classes where "the model" from a traditional MVC architecture. I had a renderer that was obviously the view; it maintained all the sprite information and used the data from the model to paint the scene, quite literally something like: `renderer.draw(world);` I also had a WorldEvents class, which kind of acted like the controller. It would receive events from the input mapper, from physics collisions and from the World itself. Its job was to decide how to influence the model based on those events.

What I was less sure about - and still am - is about my handling of the simulation. For whatever reason I decided to couple it very tightly with the model. Most entity classes had a Box2D Body data member within them. The physics engine itself was hosted inside the World class and even besides physics, various bits of game logic such as dino spawning where handled by the World in its update() method. ...Possibly all of that should have been extracted from the model... In which case the various entity classes would hold their own positional data and some external update loop would synchronize that with Box2D while also use public methods on the World to periodically spawn Dinos, etc. I think perhaps by coupling them together it simplified and sped-up the development for this game, but for a longer-term project separating the model from the simulation would be a good choice.

Sound effects where another big thing in this game. I only use 3 audio files, one of those is the background music. This was all done on the final day so it does look a bit hacked in. I had never implemented sound before so it was a cool experience. LibGDX makes it very straightforward affair. I know from perusing the DirectX audio documentation in the past that sound can be a complex matter but LibGDX cuts all the crap and has only a basic API that was all I needed. One of the interesting thing about audio (at least in libGDX) is that unlike most other things it's a fire-and-forget type resource. You don't have to advance through the sound frame by frame like you do with animation, or keep hold of any handles (you can, but it's optional). You simply invoke the non-blocking play() method and it just begins to play. So it was an absolute breeze!

What went well?
---------------

A lot of it went well, I was fortunate really:

**Spare Time** \- I had much more free time than I expected to get initially. Most of this allowed for better polishing.

**LibGDX** - A very pleasant framework to use. The only gotcha is that it's high-level and even where it exposes just a simple JNI wrapper (e.g. around Box2D) there are no guarantees that it's 100% complete. But if you don't necessarily need all the bells and whistles then it's a perfect choice for a Java media library.

**Box2D** \- It is really easy to use and paid dividends in speeding up development. Initially I began to implement my own simplified physics for jumping but when I began to consider bullets firing, inter-entity collisions, blood splats, etc, I decided that Box2D would be a smarter choice. It took about a day to integrate whereas it would probably have taken me 2 days to implement all the physical interactions in my own code and fix all the ensuing bugs. When it came to implementing blood it took me mere moments to get a basic implementation up and running!

LibGDX also comes with a debug-renderer for Box2D, it is worth its weight in gold, so get that running early on! Being able to see visually how the physics is behaving relative to your own visuals is incredibly helpful and helped me nail tons of bugs much faster than I otherwise would have.

**Art-style** \- Using paint for all the artwork (and Paint.Net to apply alpha) made for a unique visual style, almost like an animated Paint drawing. In the end I quite like it. It won't win an awards for artistry but it hangs together well. Much better than mis-mashed images stolen of the internet would have. Or if I'd tried to actually do a good job at the artwork :P

{{< thumbnail x400 "cutscene-screenshot.png" "Screenshot of Cutscene" >}}

**Animation** \- Bringing things to life is important. Static sprites sliding around just looks rubbish. It was pretty easy to add walking feet. I just tween across a sine-wave to create the swinging motion of the dinosaur's feet and the up-down motion of Granny when she walks. If I had more time I would have animated her walking stick and the jaws of the dinosaurs.

**GameStates** \- GameStates are full-screen states that the game can be in at any one time. For example there's a game-state for actually playing the game, a game-state for the high-scores table, for the start-screen, etc. They can decide when to transition from one state to another, in effect it's an FSM. I had heard about people implementing game-states like this before but wasn't sure how well it would work out - turned out great for me. It made adding new features like the high-scores table really easy.

The only state that is a bit iffy is the sign-reading state. Probably this shouldn't be a state at all, just a boolean within the in-game game-state; I got it to work this way though, which just goes to demonstate the flexibility of the system. In fact it acts like a stacked state, it first renders the in-game game-state before rendering itself. I knew this would be the only stacked state though so I didn't implement any generic handling of stacked game-states, I just had the sign-reading state handle it on its own.

{{< thumbnail x400 "signposts-screenshot.png" "Screenshot of Signpost System" >}}

I actually recently wrote about [the game-state system on the GDNet forums](http://www.gamedev.net/topic/647525-code-review-basic-state-system/?view=findpost&p=5092158 "Description of my Game-State system.").

**Focusing on the scoring criteria** \- There were 5 criteria each marked out of 20: Graphics, Audio, Gameplay/fun-factor, First time user experience and Theme. I aimed to keep my graphics simple and the audio I decided just had to be simple and sensible to work well. The gameplay/fun-factor was always going to be a challenge, making something really fun involves a surprising amount of work and time but I decided that you can't go wrong with a game that involves shooting things that squirt blood.

The first-time user experience is something I thought a lot of other entries might lack so I decided to try and win some points in this area by adding a cutscene at the start, comical in-game help along the way with the use of sign-posts and also a highscores table with humorous entries in and also a guaranteed position on the leaderboard for the first-time play through (i.e. 7 out of a maximum of 8 entries were pre-populated).

What went wrong?
----------------

Well, a number of things:

**Being too ambitious** \- Partly this was deliberate, I wanted to use the competition as an excuse to play with graphics, physics and audio. It did mean it really took over my life for a week though and I was up against the clock at the end.

**Co-ordinate systems** \- I should have nailed this one down early on really, but I didn't. There are a few coordinate systems in-play within the game: Box2D has one on the scale of real-world objects (meters), the renderer has another one defined just as a scaling of the coordinate system used by Box2d in order to render it. The renderer also has regular screen-space coordinates (pixels) that is used for drawing the full-screen backgrounds as well as applying multi-part sprite offsets (e.g. for the legs relative to the body). None of that code is particularly well encapsulated and it was always a bit of a headache to remember which one I'm using for what and how to convert between them all.

**Separating entity representations** \- The physical properties of an entity are held in one place, the rendering properties in another. They're actually quite related values though; if an entity is physically larger the it should also be rendered bigger, right? It's nice in some ways to keep them separate but it was a pain at crunch time to keep those values in sync. What I should have had is an abstract representation and the physical & visual properties be calculated from those. Arguably that might have been more work.

**Floor/Terrain** \- This didn't go wrong so much as it didn't pan out to be as awesome as I initially envisioned. I had planned that there would be multiple routes through the game e.g. a high route and low route, done using foreground and background terrain as well as platforms which would further emphasise Granny's jumping ability and add an extra dimension to the player's decision-making which, as it stands, is pretty limited to just which dino to target next.

{{< thumbnail x400 "ingame-screenshot.png" "In-Game Screenshot Showing Off Terrain" >}}

In the end I only had time to implement a basic continuous height-mapped terrain system. I did however make it infinitely auto-generate by selecting randomly from a set of a pre-made level-segments each with differing probabilities. I only had time to create 3 level-segments though: A flat segment, a step-up/step-down segment (see screenshot) and a hill. The camera also won't follow Granny vertically so the useful height was effectively  constrained to about 5 units, when combined with the limitation that the terrain be continuous it pretty much  limits the amount of creativity possible when designing terrain segments.

**Level Balancing** \- I didn't get to spend as much time on this as I would have liked, in fact I only spent about a half hour on the run-up to the end of the contest configuring the gameplay difficultly and how that changes as you progress. This is definitely something I should have been more on-top of.

I implemented the concepts of Levels, which are actually demarcated by the signposts but I purposely didn't want an overly explicit level counter, just continuous gameplay. As the player reaches each level the settings are adjusted to control how frequently the dinosaurs spawn from either side, which dinosaurs will spawn (and the likelihood of spawning any given type of dino), which floor segments will be used  to auto-generate the terrain (and again to what likelihood) and the frequency of spawning ammo-pickups. I managed to define about 7 levels (with the final level being a never-ending one) that gradually introduce more complex terrain, more kinds of dinosaur, more frequently spawning dinos and all the while have the signposts introduce the new content as the player progresses.

It worked out okay but it was sheer fluke that my level-balancing was as good as it turned out. That said, it seems like you cannot progress past about level 5 when the stegosaurus are introduced since I simply don't provide enough ammo to take them all out. Fortunately, by that point, all the game's content is introduced except for a couple of non-helpful, comedic sign-posts; the remaining levels are just about making things harder. But at least you get to see everything the game has to offer, by and large.

As a final point, Granny has health, but I didn't have time to add health-pickups so she'll only ever get more and more unwell, poor Granny.

Other Lessons
-------------

Besides those that have been mentioned above I learnt (or "learned" - crazy irregular verbs) a few good lessons during development. Mostly these were about peculiarities of Box2D and/or LibGDX as these were essentially new tech to me.

**Always cpy() your Vector2s** \- It turns out that Vector2's in LibGDX are mutable little devils. Presumably this is done as an optimisation. Nevertheless it caught me by surpise a number of times. Consequently if returning a Vector2 from a function, or accepting one as a parameter: Always make a copy! This is actually good general advice whenever you accept a mutable value that you intend to own. Last thing you want is for it be changed under your feet!

My worst experience with this was when I was returning Vector2's from a Box2D body and forgetting to make a copy (in fact you might have thought LibGDX's wrapper would do that; it isn't clear whether mutating this object is actually safe and if it would correctly modify the body's physical property). Consequently when the body was destroyed it left a now-dangling Vector2 held some place else that would crash the JVM once touched. Tracking that back to a missing cpy() was more guesswork than scientific debugging.

**Defer your deletes** \- This one kind of depends on how your architect things. For me the various entities exposed details such as their position and velocity, but these were just being passed straight out from the underlying Box2D bodies. So, say a dino was killed by a bullet impact. I would remove the dino from the World, which would also destroy the Box2D body. It appears that Box2D immediately frees the resource (it doesn't wait for the next tick, for example). The problem is what if you wanted to spawn some blood from the dino's position? You can't if you kill him first. Obviously you could spawn the blood and then kill him (and maybe, for blood, that makes sense) but it's a little on the brittle side and a leaky abstraction - The dino-to-bullet collision handler is just telling the world that the dino is dead; if it has to know that the dino will also become invalidated then it undesirably knows something about the implementation that I would have preferred to keep hidden.

Another issue is when multiple collision handlers are invoked by Box2D. One of my more serious and bugs was an occasional crash that only began to appear after I introduced multiple dinos. It turned out that a bullet could collide with multiple dinos at once. This is obvious in hindsight - the bullet isn't infinitely tiny like a raycast, it's a circle with an area being simulated by Box2D. If both those dinos happened to die from that bullet impact then one of those collision handlers is dealing with an already-deleted Body and badness ensues.

This was all fixed by buffering all deletes up inside of my own Box2D World wrapper. Multiple deletes were de-duped by storing them in a HashSet container. At the next tick I would then run through and do all the deferred removals for that frame. Now those bodies would remain valid for the entire frame and I could go back to forgetting about memory management issues 😉

**Finding free assets is hard** \- By far the hardest asset to acquire was the font. It's called DINk. Many "free" fonts have uncertain licenses, I'm sure the owners intend them to be wholly free but unless they give clear licensing terms then I am uneasy going near them. Many other fonts are free for virtually any purpose but may not be redistributed. Lack of redistribution is a massive bummer because that is exactly what I need to do - package it as an asset and redistribute it as part of my game. Most of the font licenses I found were around the idea that a font is used in subset to create a document and that document is about the only derived work that can be created from that font. I did my best to acknowledge all the asset authors in the ReadMe, as well as being clear about what the licenses are.

Conclusion
----------

Overall it was really fun. I hope they do another one as I'll surely participate. I think I've learned a few lessons for this one though: It was too ambitious to truly finish and sucked up far too much time. I think a much simpler game could fair just as well. Using the competition as an excuse to play with new tech is quite fun though - Maybe next time I'll play with shaders; perhaps some kind of game involving making things glow or somehow involving the lighting such having to stay hidden in the shadows. I have already [expressed an interest in another competition](http://www.gamedev.net/topic/647312-another-unofficial-contest "Another competition"), this one initiated by one of the judges and the goal is to make some flavour of a Pong clone - could be quite cool!

I shall post this post-mortem to the GameDev.net forums when all the judging is complete - I think that pointing out the flaws in my game whilst the judging is still underway would be unwise 😛

If you want to see what kind of twisted, scary code and sheer quantity of magic numbers that went into making this game, I have open-sourced it on GitHub: [https://github.com/daveagill/GvZD](https://github.com/daveagill/GvZD)

In closing I would also like to thank those who voted for my game in the [Peoples' Choice Award](http://www.gamedev.net/topic/647313-voting-for-the-week-of-awesome-vote-for-your-favorite "The People's Choice Award for The Week of Awesome games."), which I am delighted to have won.

I look forward to seeing what the final verdict was from the judges!