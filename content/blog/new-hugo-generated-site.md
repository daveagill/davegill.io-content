+++
title = "New Hugo Generated Site"
date = "Mon, 04 Mar 2019 03:12:31 GMT"
tags = ["Web Development"]
+++

**Welcome to the new site!** Here we are with a fresh new look and as you can it's a minimalistic and content-first design which is enhanced by the ever so elegant Merriweather font.

The minimalistic mantra extends beyond just the cosmetics to the inner workings of the site too; being fully offline-generated using a Static-Site-Generator (SSG) known as [Hugo](https://gohugo.io/) and skinned with a custom site theme I have named [Jörmungander](https://github.com/daveagill/jormungandr).

Meaning:

* No server-side scripting (goodbye Wordpress!)
* No client-side frameworks (like React, Angular or Vue.js)
* No CSS frameworks (like Bootstrap or Ant.d, not even a 'reset' style)

The few JS libraries that I have used, such as highlight.js for code highlighting, are loaded from CDNs to keep things speedy and the main CSS is completely hand-rolled and less than 2KB.

In fact Google's [PageSpeed Insights tool](https://developers.google.com/speed/pagespeed/insights/?url=https%3A%2F%2Fdavegill.io%2F) awards a score of 99/100 for mobile and 100/100 for desktop. 👌

Besides just raw performance, using a Static-Site-Generator like Hugo or Jekyll comes with other solid benefits that I wanted to exploit:

* **Free hosting.** This is all hosted on Github Sites for free. They even take care of creating a Let's Encrypt SSL certificate for HTTPS.
* **Version control.** All the content for my blog is version controlled with Git.
* **Offline authoring.** I can write my blog posts offline because every page and every post is just a Markdown text-file. As a developer this suits me extremely well considering how much time I spend inside a text editor.
* **Security.** No more keeping all of Linux, Wordpress, PHP & MySQL up-to-date and hacker-proof.
* **Easier custom theming.** Hugo themes are simpler than Wordpress themes.

My process for migrating content from Wordpress to Hugo was relatively straight-forward but I did have to grind through every blog post to fixup paragraphs and images. That was fine for me because there weren't too many posts and I really wanted to make sure that all my content was perfect anyway.

I'll be covering the migration process in an up-coming post.

Looking ahead, I am hoping that the ease with which I can author content now will inspire me to blog more frequently. Especially as I have a few exciting things in the pipeline that I'll be working on.