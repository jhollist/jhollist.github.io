---
layout: page
title: Blog
---

<ul class="listing">
  {% for post in site.posts %}
  <li>
    {{ post.date | date: "%B %e, %Y" }} <a href="{{site.baseurl}}{{ post.url }}">{{ post.title }}</a> - {{post.tags}}, {{post.author}}
  </li>
  {% endfor %}
</ul>
