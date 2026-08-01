---
layout: "default"
permalink: "/functions/12_base64decode/"
pkg_name: "strings"
pkg_version: "1.3.1"
pkg_description: "Additional functions for manipulation and analysis of strings."
title: "Strings Toolkit - base64decode"
category: "Conversion"
func_name: "base64decode"
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
<dt class="deftypefn def-line" id="index-base64decode"><span class="category-def">Function File: </span><span><code class="def-type"><var class="var">rval</var> =</code> <strong class="def-name">base64decode</strong> <code class="def-code-arguments">(<var class="var">code</var>)</code></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-base64decode-1"><span class="category-def">Function File: </span><span><code class="def-type"><var class="var">rval</var> =</code> <strong class="def-name">base64decode</strong> <code class="def-code-arguments">(<var class="var">code</var>, <var class="var">as_string</var>)</code></span></dt>
<dd><p>Convert a base64 <var class="var">code</var>  (a string of printable characters according to RFC 2045) 
 into the original ASCII data set of range 0-255. If option <var class="var">as_string</var> is 
 passed, the return value is converted into a string. Otherwise, the return
 value is a uint8 row vector.
</p>
<div class="example">
<pre class="example-preformatted"> </pre><div class="group"><pre class="example-preformatted"> base64decode ('SGFrdW5hIE1hdGF0YQ==', true)
   &rArr; Hakuna Matata
 </pre></div><pre class="example-preformatted"> </pre></div>

<p>See: http://www.ietf.org/rfc/rfc2045.txt
</p>
</dd></dl>