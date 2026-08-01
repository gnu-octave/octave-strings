---
layout: "default"
permalink: "/functions/12_editdistance/"
pkg_name: "strings"
pkg_version: "1.3.1"
pkg_description: "Additional functions for manipulation and analysis of strings."
title: "Strings Toolkit - editdistance"
category: "Conversion"
func_name: "editdistance"
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
<dt class="deftypefn def-line" id="index-editdistance"><span class="category-def">Function File: </span><span><code class="def-type">[<var class="var">dist</var>, <var class="var">L</var>] =</code> <strong class="def-name">editdistance</strong> <code class="def-code-arguments">(<var class="var">str1</var>, <var class="var">str2</var>)</code></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-editdistance-1"><span class="category-def">Function File: </span><span><code class="def-type">[<var class="var">dist</var>, <var class="var">L</var>] =</code> <strong class="def-name">editdistance</strong> <code class="def-code-arguments">(<var class="var">str1</var>, <var class="var">str2</var>, <var class="var">weights</var>)</code></span></dt>
<dt class="deftypefnx def-cmd-deftypefn def-line" id="index-editdistance-2"><span class="category-def">Function File: </span><span><code class="def-type">[<var class="var">dist</var>, <var class="var">L</var>] =</code> <strong class="def-name">editdistance</strong> <code class="def-code-arguments">(<var class="var">str1</var>, <var class="var">str2</var>, <var class="var">weights</var>, <var class="var">modus</var>)</code></span></dt>
<dd><p>Compute the Levenshtein edit distance between the two strings.
</p>
<p>The optional argument <var class="var">weights</var> specifies weights for the deletion,
 matched, and insertion operations; by default it is set to +1, 0, +1
 respectively, so that a least editdistance means a closer match between the
 two strings. This function implements the Levenshtein edit distance as
 presented in Wikipedia article, accessed Nov 2006. Also the levenshtein edit
 distance of a string with the empty string is defined to be its length.
</p>
<p>For the special case that there are no weights given and the array L is not
 requested, an algorithm of Berghel and Roach, which improves an algorithm 
 introduced by Ukkonen in 1985, will be applied. This algorithm is
 significantly faster most of the times. Its main strength lies in cases with
 small edit distances, where huge speedups and memory savings are suspectible.
 The time (and space) complexity is O(((dist^2 - (n - m)^2)/2) + dist), where
 n and m denote the length of both strings.
</p> 
<p>The optional argument <var class="var">modus</var> specifies the algorithm to be used. For
 <var class="var">modus</var> = 0, Berghel and Roach&rsquo;s algorithm will be used whenever
 possible. For <var class="var">modus</var> = 1, the classic algorithm by Fisher and Wagner
 will be used. If <var class="var">L</var> is omitted, and <var class="var">modus</var> = 1, a variant of Fisher
 and Wagner&rsquo;s algorithm using only a linear amount of memory with respect to
 the input length, but O(m*n) runtime, will be used. Again, n and m denote the
 length of both strings.
</p>
<p>The default return value <var class="var">dist</var> is the edit distance, and
 the other return value <var class="var">L</var> is the distance matrix.
</p>
<div class="example">
<pre class="example-preformatted"> </pre><div class="group"><pre class="example-preformatted"> editdistance ('marry', 'marie') 
   &rArr;  2
 </pre></div><pre class="example-preformatted"> </pre></div>

</dd></dl>