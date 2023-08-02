| Element	| Markdown Syntax | Notes |
| --------| ----------------|--------|
| Heading 1	| `# h1` | For compatibility, always put a space between the number signs and the heading name.| 
| Heading	2 | `## h2` | see above | 
| Heading	3 | `### h3` | see above |
| Paragraphs | use blank space or `<p>` | see above | unless paragraph is in list, do not indent with spaces or tabs | 
| Line Breaks | end a line with two or more spaces, then type return or `<br>`| hard to see whitespace, use `<br>` for compatibility |
| Bold | `**bold text**` <p> `__bold text__` | use `**` as markdown applications don't agree on how to handle underscores in the middle of a word |  
| Italic | `*italicized text*` or `italicized text_` |
| Bold and Italic | <p> `***important text***` <p> `___important text___` <p> `__*important text*__` <p> `**_important text_**` <p> `***important text***`| underscores not as compatible as just using `***text***`
| Blockquote | `> blockquote` | <p> Blockquotes can contain multiple paragraphs. Add a > on the blank lines between the paragraphs. <p> Blockquotes can be nested. Add a `>>` in front of the paragraph you want to nest. <p> blockquotes can contain other elements <p> for compatibilityp put blank lines before and after blockquotes |
| Ordered List | 	<p> 1. First item <p> 2. Second item <p> 3. Third item |
| Unordered List | 	<p> - First item <p> - Second item <p> - Third item | <p> You can also use `*` or `+`. <p> If you need to start an unordered list item with a number followed by a period, you can use `(\)` to escape the period, eg. `- 1968\. A great year!` <p > To add another element in a list while preserving the continuity of the list, indent the element four spaces or one tab, as shown in the following examples.| 
| Code | ``code``| |
| Code Blocks | ` ```code block ``` ` | There are supported languages, when the code block is tagged with it markdown block will have syntax highlighting | some common ones I've used are `python`, `sql`, `yaml`
| Horizontal Rule	| --- |
| Link | `[title](https://www.example.com)` | <p> You can also add titles for a link, which will appear as a tooltop when the user hovers over the link. `My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").` <p> You can emphasize links by adding `*` or other formatting <p> Markdown applications don’t agree on how to handle spaces in the middle of a URL. For compatibility, try to URL encode any spaces with %20. |
|URLs and Email Addresses|`<https://www.markdownguide.org>
<fake@example.com>`||
| Image |	![alt text](image.jpg) | |
| Linking Images | [![image description](url to image)](link) | |
| Horizontal Rules| `***` <p>  `---` <p>  `____` <p> | put blank lines before and after for compatibility |
| Table of Contents / Heading Links | [Custom foo description](#foo) | just one # for all heading sizes, no space between # and anchor name, anchor tag names must be lowercase |
| Table of Contents / Heading Links (multi-word) | [click on this link](#my-multi-word-header) | same rules as above, additionally need to delimit by dashes if multi-word. |




