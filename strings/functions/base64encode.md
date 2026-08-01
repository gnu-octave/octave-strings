---
layout: "default"
permalink: "/functions/12_base64encode/"
pkg_name: "strings"
pkg_version: "1.3.1"
pkg_description: "Additional functions for manipulation and analysis of strings."
title: "Strings Toolkit - base64encode"
category: "Conversion"
func_name: "base64encode"
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
<dt class="deftypefn def-line" id="index-base64encode"><span class="category-def">Function File: </span><span><code class="def-type"><var class="var">Y</var> =</code> <strong class="def-name">base64encode</strong> <code class="def-code-arguments">(<var class="var">X</var>)</code></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-base64encode-1"><span class="category-def">Function File: </span><span><code class="def-type"><var class="var">Y</var> =</code> <strong class="def-name">base64encode</strong> <code class="def-code-arguments">(<var class="var">X</var>, <var class="var">row_vector</var>)</code></span></dt>
<dd><p>Convert <var class="var">X</var> into string of printable characters according to RFC 2045.
</p>
<p>The input may be a string or a matrix of integers in the range 0..255.
</p>
<p>If want the output in the 1-row of strings format, pass the 
 <var class="var">row_vector</var> argument as <code class="code">true</code>.  Otherwise the output is a 4-row
 character matrix, which contains 4 encoded bytes in each column for each
 3 bytes from the input.
</p> 
<p>Example:
 </p><div class="example">
<pre class="example-preformatted"> </pre><div class="group"><pre class="example-preformatted"> base64encode ('Hakuna Matata', true) 
   &rArr; SGFrdW5hIE1hdGF0YQ==
 </pre></div><pre class="example-preformatted"> </pre></div>

<p><strong class="strong">See also:</strong> base64decode, base64_encode.
 </p></dd></dl>