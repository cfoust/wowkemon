# WoWKemon

![logo](http://i.imgur.com/JSjIs.png)

## About

*WARNING! THIS CODE WAS WRITTEN IN 2012. IT IS SLOPPY AND I MAKE NO APOLOGIES
FOR THE DESIGN DECISIONS MADE BY A 17-YEAR-OLD ME.*

I used to play a lot of World of Warcraft. Heck, I still do sometimes, but they
say that you never really quit the game, you just AFK for a while. Anyway, I
was a senior in high school and had never published a project that got more
than a few dozen downloads. For some reason, when the Mists of Pandaria
expansion released with a fresh pet battling system, I just _had_ to create a
completely new UI around it base on the Pokemon games. For the uninformed, World
of Warcraft has an amazing addon system wherein you extend the game's UI by
writing code in Lua. 

I had never attempted a project of such scale. As a result, I ended up hardly
sleeping for weeks and even skipped class to work on the addon. I dedicated
just about every waking hour to adding features and expanding the scope.

Finally, a month after the expansion released, I let loose the code abomination
to the world.  The crazy part? It worked. And it was popular. I made the [front page of MMO-Champion](http://www.mmo-champion.com/content/3045-Tom-Chilton-Interview-WoWkemon).
I also got interviewed by [Curse](https://mods.curse.com/spotlight/addons/wow/47154-wowkemon-bringing-pokemon-to-world-of-warcraft).
Over the course of the addon's lifetime it got well over 50,000 downloads.

## Functionality

You can find a video of the addon in action [here](https://www.youtube.com/watch?v=4-AEMibGYrA). It had
a few themes that implemented most of the Pokemon battle UI from the Emerald,
Ruby/Sapphire, and even DS games. I handled all of the weather effects present in
the game at the time including rain!

![rain](https://media-curse.cursecdn.com/attachments/79/547/weather.jpeg)

A few designers reached out to make parts of the UI after I released it, so
the UI you see in the video isn't the original one that I made.

There was another feature that has as yet not been replicated by Blizzard in
World of Warcraft's user interface: spectator mode! `WoWkemon_TV` was an addon
that worked in tandem with WoWkemon that allowed you to watch your friends as
they battled, even if they were on a completely different game server. It was actually
pretty far ahead of its time.

![tv](http://media-curse.cursecdn.com/attachments/79/544/spectating.png)

## Retrospective

All in all, I'm glad I made it! I haven't updated it in many years. The code style is awful.
I wrote it without any sort of guidance or version control. Remarkably, there weren't that
many bugs that weren't me hitting limitations in the WoW client.
