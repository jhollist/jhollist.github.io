---
layout: post
title: "Getting a Category Feed Up and Running with Jekyll on Github"
tags: ['jekyll','github','RSS','categories']
categories: ['R']
---

Now that I have the site up and running, I am now trying to add a few category specific RSS feeds.  I will say that for someone who is new to RSS (i.e. me) the feeds on [Wordpress](http://wordpress.com) are really easy.  But, since I now fancy myself somewhat of hacker, I suppose figuring out how to get a Jekyll site hosted on Github to spit these out is something I should do.

This site is built on the [Hyde theme](http://andhyde.com/) which includes an `atom.xml` file. This is great and provides a feed for the entire blog but, often a category specific feed is required.  For instance, my (poorly named) old blog [Landscape Ecology 2.0](http://landeco2point0.wordpress.com/) has been referenced by a couple of aggregators, most notably [R-bloggers](http://www.r-bloggers.com/).  Since I do blog about topics other than R, I need to be able to submit a feed that is specific to R.  Wordpress does this automatically with Categories.  You can also do this in Jekyll with a little work.

As it turns out many others have had this same need and there are a few options for getting it set up.  Since my blog already has a site wide RSS feed built with Liquid templating all I needed was a category specifc one.  So I simpl ammended the template from  @snaptortoise [jekyll-rss-feeds](https://github.com/snaptortoise/jekyll-rss-feeds).  For my blog, the template looks like:

{% highlight xml %}
{% raw %}
---
layout: none
---
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
  	<title>{{ site.title | xml_escape }} - r</title>
		<description>Posts categorized as 'r'</description>
		<link>{{ site.url }}</link>
		<atom:link href="{{ site.url }}/feed.r.xml" rel="self" type="application/rss+xml" />
    {% for post in site.categories.r limit:20 %}
      <item>
        <title>{{ post.title | xml_escape }}</title>
        <description>{{ post.content | xml_escape }}</description>
        <pubDate>{{ post.date | date: "%a, %d %b %Y %H:%M:%S %z" }}</pubDate>
        <link>{{ site.url }}{{ post.url }}</link>
        <guid isPermaLink="true">{{ site.url }}{{ post.url }}</guid>
      </item>
    {% endfor %}
	</channel>
</rss>
{% endraw %}
{% endhighlight %}

I have saved this in the source of my website as `feed.r.xml`.  One gotcha is that Jekyll appears to convert all categories to lower case.  I had it site to loop on `site.categories.R` and it wasn't working.  Switching to `site.categories.r` fixed the problem.  

Since `feed.r.xml` has the `layout: null` in the YAML, everytime the site builds on Github (i.e. everytime a change is made), this feed will get updated.  In theory, I should be able to submit this feed to [R-bloggers](http://www.r-bloggers.com/add-your-blog/) and everytime I have a new post with the R category, it will also get picked up by R-bloggers.  Only downside to this is that a new category template will be required for each category that I want to build the RSS feed for.  

**NOTE:** Getting the Liquid templating to be highlighted in this post also took some work as the the Liquid was getting interpreted, not highlighted.  Turns out it is as easy as wrapping the code with:
<p>
  <code>&#123;% raw %}</code>
  <br>
  <code>&#123;% endraw %}</code>
</p> 

This answer courtesy of [StackOverflow](http://stackoverflow.com/questions/20568396/how-to-use-jekyll-code-in-inline-code-highlighting)

**ANOTHER NOTE:**
And now to get even more into the weeds, getting <code>&#123;% raw %}</code> to render took another approach, raw HTML.  So that looks like

{% highlight html %}
<p>
  <code>&#123;% raw %}</code>
  <br>
  <code>&#123;% endraw %}</code>
</p> 
{% endhighlight %}

That answer provided by
[SLaks.Blog](http://blog.slaks.net/2013-06-09/writing-about-jekyll-in-jekyll/).

