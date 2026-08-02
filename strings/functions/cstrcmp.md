---
layout: "default"
permalink: "/functions/7_cstrcmp/"
pkg_name: "strings"
pkg_version: "1.3.2"
pkg_description: "Additional functions for manipulation and analysis of strings."
title: "Strings Toolkit - cstrcmp"
category: "Conversion"
func_name: "cstrcmp"
navigation:
- id: "overview"
  name: "Overview"
  url: "/index"
- id: "Functions"
  name: "Function Reference"
  url: "/functions"
- id: "18_Searchandreplace"
  name: "&nbsp;&nbsp;Search and replace"
  url: "/functions/#18_Searchandreplace"
  subitems:
- id: "10_Operations"
  name: "&nbsp;&nbsp;Operations"
  url: "/functions/#10_Operations"
  subitems:
- id: "10_Conversion"
  name: "&nbsp;&nbsp;Conversion"
  url: "/functions/#10_Conversion"
  subitems:
- id: "news"
  name: "News"
  url: "/news"
---
<dl class="first-deftypefn def-block">
<dt class="deftypefn def-line" id="index-cstrcmp"><span class="category-def">Function File: </span><span><code class="def-type"><var class="var">rval</var> =</code> <strong class="def-name">cstrcmp</strong> <code class="def-code-arguments">(<var class="var">s1</var>, <var class="var">s2</var>)</code></span></dt>
<dd><p>Compare strings <var class="var">s1</var> and <var class="var">s2</var> like the C function.
</p>
<p>Aside the difference to the return values, this function API is exactly the
 same as Octave&rsquo;s <code class="code">strcmp</code> and will accept cell arrays as well.
</p>
<p><var class="var">rval</var> indicates the relationship between the strings:
 </p><ul class="itemize mark-bullet">
<li>A value of 0 indicates that both strings are equal;
 </li><li>A value of +1 indicates that the first character that does not match has a
 greater value in <var class="var">s1</var> than in <var class="var">s2</var>.
 </li><li>A value of -1 indicates that the first character that does not match has a
 match has a smaller value in <var class="var">s1</var> than in <var class="var">s2</var>.
 </li></ul>

<div class="example">
<pre class="example-preformatted"> </pre><div class="group"><pre class="example-preformatted"> cstrcmp (&quot;marry&quot;, &quot;marry&quot;)
   &rArr;  0
 cstrcmp (&quot;marry&quot;, &quot;marri&quot;)
   &rArr;  1
 cstrcmp (&quot;marri&quot;, &quot;marry&quot;)
   &rArr; -1
 </pre></div><pre class="example-preformatted"> </pre></div>

</dd></dl>