# example of CSS inside Rmarkdown from DC course

---
title: "The reduction in weekly working hours in Europe" 
subtitle: "Looking at the development between 1996 and 2006"
author: "Insert your name here"
output: 
  html_document:
    theme: cosmo
    highlight: monochrome
    toc: true
    toc_float: false
    toc_depth: 4
    code_folding: hide
---

<style>
body, h1, h2, h3, h4 {
    font-family: "Bookman", serif;
}

body {
    color: #333333;
}
a, a:hover {
    color: red;
}
pre {
    font-size: 10px;
}
</style>

## Summary 

Then start the actual Rmd.


Notes
a, a:hover refers to the a teg, and therefore all links

On line 27, reduce the font of the R code elements, which are wrapped in pre HTML tags, to 10px. 



## references
https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors
