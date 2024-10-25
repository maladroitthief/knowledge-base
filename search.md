---
title: Results
layout: default
---

<ul id="search-results"></ul>

<script>
  window.store = {
    {% for post in site.pages %}
      "{{ post.url | slugify }}": {
        "url": "{{ post.url | xml_escape }}",
        "title": "{{ post.title | xml_escape }}",
        "tags": "{{ post.tags | xml_escape }}",
        "content": {{ post.content | strip_html | strip_newlines | jsonify }}
      }
      {% unless forloop.last %},{% endunless %}
    {% endfor %}
  };
</script>

<script src="https://unpkg.com/lunr/lunr.js"></script>
<script src="/assets/search.js"></script>
