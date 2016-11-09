---
layout: default
---
# Download

{% assign all = site.data.downloads | sort:'sort' %}

{% assign stable = all | where:'state','stable' %}

## Latest official version: {{ stable.last.version }}

<ul>
{% for file in stable.last.files %}
<li> {% include download-link file=file %} </li>
{% endfor %}
</ul>

{% assign beta = all | where:'state','beta' %}

{% if beta.last.sort > stable.last.sort %}

## Latest beta version: {{ beta.last.version }}

<ul>
{% for file in beta.last.files %}
<li> {% include download-link file=file %} </li>
{% endfor %}
</ul>

{% endif %}

{% assign nightly = all | where:'state','nightly' %}

{% if nightly.size > 0 %}

## Latest nightly build

<ul>
{% for file in nightly.last.files %}
<li> {% include download-link file=file %} </li>
{% endfor %}
</ul>

{% endif %}

{% assign previous = stable | reverse | shift %}

{% if previous.size > 0 %}

## Previous versions

{% for item in previous %}

### Verion {{ item.version }}

<ul>
{% for file in item.files %}
<li> {% include download-link file=file %} </li>
{% endfor %}
</ul>

{% endfor %}

{% endif %}
