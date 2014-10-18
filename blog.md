---
layout: page
title: Blog
---

<section class="content">
  <ul class="listing">
    {% for post in site.posts %}
    <li>
      <span>{{ post.date | date: "%B %e, %Y" }}</span> <a href="{{site.baseurl}}{{ post.url }}">{{ post.title }}</a> - {{post.tags}}, {{post.author}}
    </li>
    {% endfor %}
  </ul>
</section>