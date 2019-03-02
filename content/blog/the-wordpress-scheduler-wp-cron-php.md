+++
title = "The WordPress Scheduler: wp-cron.php"
date = "Mon, 09 Sep 2013 12:00:19 +0000"
draft = false
tags = ["Web Development", "WordPress", "SysAdmin"]
aliases = ["/2013/09/the-wordpress-scheduler-wp-cron-php/"]
+++

So, I recently noticed that my site was not doing its automatic backups. In fact it had never done a backup and I simply had not bothered to check!

I use UpdraftPlus to do my site backups, it is a WordPress plugin that zips up the database and uploaded files and sends them to you (I have it send them to my DropBox). After a bit of investigation and following some of the debug steps on their site I came to the conclusion that it must be WordPress's internal scheduler to blame. Without the scheduler the backups will never get kicked off and other things like checking for updates may be failing too. Question was, why was the scheduler borked?

To understand this we first have to understand how the scheduler works in WordPress.

It basically takes the form of wp-cron.php, a little script that checks to see if there is any scheduled work to do and, if there is, then it performs the necessary processing. This script is called whether a page is loaded on a WP site.

Already, this has some consequences (and some potential red-herrings for my investigation). Clearly if the cron script is only invoked when there is site activity then for a lowly unloved site like mine the cron script isn't going to get called very regularly and scheduled tasks are not going take place on-time. Maybe the sheer amount of spam comments I get would keep things ticking over, I don't know. One day, when this site goes viral becomes an internet sensation, the vast quantity of page views would actually keep the cron script too busy, clearly it doesn't need to be called hundreds of time a minute! In fact as I understand it, in previous versions of WP concurrent invocations could cause problems; a problem that is solved these days using locks.

You might wonder whether page loading is slowed down for those people who happen to visit the site when there is a scheduled task to perform. Fortunately this is not the case. The cron script is initiated concurrently.

WordPress launches the concurrent task by making an HTTP request back to itself, thereby spawning a second server-side thread to handle the request. Something like this:

```
GET: http://www.yoursite.co.uk/wp-cron.php
```

Unfortunately this could fail for all kinds of reasons. LIke not being able to resolve the DNS name, for example.

I use a shared hosting provider. This website is hosted on some server alongside a bunch of other websites. The overall server configuration is therefore out of my control. It turns out that a lot of hosting providers (including mine) disable loopback requests. In other words the server is unable to invoke a request on itself. Apparently this is for security reasons, perhaps to prevent some kind of infinite request loop. Personally I'm inclined to disagree, I cannot think of any particularly good reason to do this; there is nothing malevolent that the machine could do by calling back to itself that couldn't also be achieved externally; they're just web calls after all!

Initially I wasn't sure if this was really the case for me. I couldn't see anything in the logs about failed attempts to invoke wp-cron. But I had a script tat makes HTTP GET calls and using that I proved that it was indeed the case and showed empirically that such failures (which were request denied errors) are not logged for some reason.

So what is the solution? Well there are two possible solutions...

One is that WordPress actually has a second way to trigger concurrent work, you just have to enable it. It works by sending the user on a redirect and hijacking their original request to perform the cron work. I don't imagine that is the most pleasant user experience for the person visiting your site though.

Another solution - the one I opted for - is to invoke wp-cron.php periodically from a genuine cron-job configured on the server. For many people this may not be a viable option if they don't have access to cron, or if they lack the technical skills to use it.

Luckily my provider exposes a UI through CPanel that lets me configure up to 3 scheduled tasks. Of course I only need one for this and it would be trivial to write some kind of program that used a single cronjob but multiplexed that out to emulate an unlimited number of scheduled tasks.

The ideal way (perhaps) to have cron invoke wp-cron would be to use wget to make a web request:

```
/usr/bin/wget http://yoursite.co.uk/wp-cron.php
```

Alas, that would obviously still involve the loopback, from which I am blocked, so it was not an option for me. Instead I just run php directly over the script. Which seems to work just fine:

```
/usr/bin/php5 /path/to/wp-cron.php
```

I configured the cronjob to run every half an hour. A lot of people seem to run it more frequently even than that! Seems like overkill to me. I suspect you could get away with running it less than once a day in reality.

So now I have smooth-running automatic backups of my WordPress database and files 🙂

It only seems appropriate to use the scheduler to publish this post. It was actually written on September 8th 2013, but as I've recently published a post just yesterday I will schedule this one for lunchtime tomorrow.