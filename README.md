# XSLT Line-Break Template

#### Series of XSLT templates to create Line Breaks from a plain text for different layout languages.

### Content

* XSL-FO LineBraker Template - [Text.LineBreak.xsl](https://github.com/it3xl/xslt-line-break-template/blob/master/__.Structure/Func/Text/Text.LineBreak.xsl)
* XSL-FO Line Delimiter Template - [Text.InsertDelimiters.xsl](https://github.com/it3xl/xslt-line-break-template/blob/master/__.Structure/Func/Text/Text.InsertDelimiters.xsl)

### For XSL-FO it supports

 - Line breaks
 - Line delimiters (vs Line breaks)
 - Series of pointers in a row
 - Ignore Pointer Repetitions (disable the Series of pointers in a row)
 - Any string as a pointer to insert a break or a delimiter ("\n" is default)
 - Line delimiters' height
 - Default Line delimiter height from a current font size.
 - Auto ignoring of the "\r" char when searching a break place.
 - XSLT 1.0/2.0
