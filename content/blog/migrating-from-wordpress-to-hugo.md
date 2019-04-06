+++
title = "Migrating from WordPress to Hugo"
date = "Sun, 06 Apr 2019 12:39:17 BST"
tags = ["Web Development", "WordPress", "Hugo"]
+++

This guide will outline the process that I used when migrating this site from WordPress to Hugo.

To follow these instructions you are going to need:

* Hugo
* Git
* Node.js
* A Disqus account (if you want blog comments).

## Step 1 - Convert Pages & Posts

* Login to your WordPress site and export to XML. This contains all your textual content, hyperlinks, tags & categories, etc. **But it does not include images**.

* I used a tool called [blog2md](https://github.com/palaniraja/blog2md) to convert this XML files into a set of Markdown files. We have to clone it from Github and run it as a Node.js application:

    ```bash
    git clone https://github.com/palaniraja/blog2md.git ~/blog2md
    cd ~/blog2md
    npm install
    node index.js w /path/to/your/wordpress-export.xml ./output
    ```

    Note: On Windows replace `~/blog2md` with a proper Windows path such as `C:\Users\YourUserName\blog2md`

    The generated Markdown (.md) files will be found in the output folder: `~/blog2md/output`.

* Manually delete any unwanted .md files.

    The tool converts _every_ WordPress page into a corresponding Markdown file but in WordPress it is common for pages to also represent individual menus, headers, footers and other things. We don't need those for Hugo as they are configured separately (usually in the `config.toml` file but it depends on the theme).

* Go through the remaining files and fixup any missing paragraphs or other formatting issues.

    For some reason most of my converted posts lacked paragraphs entirely, but not all of them. I had to go through and manually insert the paragraph breaks. That wasn't too bad because this site isn't very big.

## Step 2 - Migrate Images

I did this step manually by downloading the images from the old WordPress site (via the browser) and editing the markdown files to reference the new URL that they will have under the new site.

I am using Hugo's new 'Page Bundles' feature to keep images organised relative to the .md file. The alternative (and classic) option is to store images in the `/static` folder.

Here's a comparison...

**Without page-bundles:**

* Your page: `/hugo/content/posts/mypost.md`
* Your images: `/hugo/static/img/lolcat.jpg`
* Your markdown: `![This is a lolcat](/img/lolcat.jpg)`

**With page-bundles:**

* Your page: `/hugo/content/posts/mypost/index.md`
* Your images: `/hugo/content/posts/mypost/lolcat.jpg`
* Your markdown: `![This is a lolcat](lolcat.jpg)`

Using page-bundles keeps everything pertaining to a single page neatly together in one folder.

If a post doesn't require images then I'll use a non-bundled page. [So I have a mix of bundled and non-bundled pages](https://github.com/daveagill/davegill.io-content/tree/master/content/blog). I personally don't mind that and opt for the simplest method that works, but if you would prefer to keep it consistent you need to decide which one to use.

While I was at it, I reviewed where images where inserted within their surround text. I particularly had issues anytime I originally had left or right aligned images with text flowing around them because my [Jörmungandr theme for Hugo](https://github.com/daveagill/jormungandr) does not support that.

I also replaced the standard markdown image codes for specialised Hugo shortcodes provided by the theme. The standard syntax inserts images at full-size whereas the shortcodes allow for setting image dimensions and take care of generating lower resolution thumnbails.

## Step 3 - Fixup the Frontmatter (optional)

The conversion tool had generated frontmatter for each .md file, but there were a few things I wanted to change about it:

1. It was formatted as JSON (indicated by the triple dashes: `---`) but I prefer it to be in TOML format. In fact the "JSON" wasn't even technically valid JSON although Hugo apparently had no problem with that.
2. All of my Categories and Tags from WordPress had been collapsed together into a single list of Hugo's 'tag' taxonomy.
3. I wanted to define URL aliases to redirect from their original WordPress URLs to their new URLs.

The first issue was easily to solve as Hugo has a way to convert frontmatter between formats:

```bash
hugo convert --toTOML
```

I had to manually resolve the tags and categories issue, but, I took it as an opportunity to review how I was using them and ended up making the decision not to use categories at all, just tags only. I also reduced the set of tags I was using to keep things simple.

Finally I added URL aliases to the frontmatter so that all of my old WordPress URLs would continue to work. Hugo will generate trivial redirect pages at the alias URLs which redirect browsers to the real page. For example:

```toml
aliases = ["/2017/08/fluid-rendering-with-box2d/"]
```

When you generate the site you can see all of these redirect pages in the `/public` folder.

## Step 4 - Migrate Comments to Disqus

Disqus is a popular embeddable comment system and it supports import from WordPress relatively simply.

First, sign up to Disqus and configure a new site (giving it a unique "Disqus shortname") and import your WordPress comments by uploading the same XML dump that we exported in step-1.

Disqus will have imported the page comments still assigned to their original WordPress URLs. So once the comments are imported (it can take a little while) you can manually edit the URLs one-by-one to reflect your new site's URLs. Alteratively you can do it in bulk using their [URL Mapper tool](https://help.disqus.com/import-export-and-syncing/url-mapper) tool. This tool requires that you upload a CSV that maps the old URLs to the new URLs:

```csv
oldURL1,newURL1
oldURL2,newURL2
oldURL3,newURL3
...
```

Here's an example from my CSV:

```csv
http://www.gilldave.co.uk/2014/08/my-new-dslr/,https://davegill.io/blog/my-new-dslr/
http://www.gilldave.co.uk/2014/04/installing-cyanogenmod-on-my-samsung-s3-mini/,https://davegill.io/blog/installing-cyanogenmod-on-my-samsung-s3-mini/
http://www.gilldave.co.uk/2013/09/the-wordpress-scheduler-wp-cron-php/,https://davegill.io/blog/the-wordpress-scheduler-wp-cron-php/
```

To embed the comments into your Hugo site your theme must support Disqus and may have specific instructions on how to achieve it. Usually you will at minimum need to set the Disqus shortname in the `config.toml` file:

```toml
disqusShortname = "my-disqus-id"
```

For the Jörmungandr theme this is all that is required! Other themes may require additional steps. I will probably write a separate post about how the comments integration with Disqus works under the hood.

## And That's It!

Your WordPress site should now be fully and cleanly migrated over to WordPress 😄

This process worked well for me but certainly there is room for improvement here; in particular a decent amount of manual work was involved in cleaning up the markdown and frontmatter of each post one-by-one.

Are you aware of any better tools that can simplify this process?  
Let me know in the comments...