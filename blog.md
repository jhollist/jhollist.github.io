---
layout: page
title: Blog
---
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a> ({{ post.date | date: "%e %B, %Y" }})
    </li>
  {% endfor %}
</ul>
