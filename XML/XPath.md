[xpath | W3C standards and drafts | W3C](https://www.w3.org/TR/xpath/)
[XPath - Wikipedia](https://en.wikipedia.org/wiki/XPath)

XML Path Language

XPath selects nodes, attributes and scalar values from an XML tree. It is the common addressing language underneath XSLT, XQuery, XML validators, browser/XML tooling and many programming APIs.

## Core Ideas

- Location paths: `/catalog/book/title`, `//book`, `@id`.
- Axes: child, parent, ancestor, descendant, following-sibling.
- Predicates: `book[@id='b1']`, `book[position() = 1]`.
- Functions: string, numeric, boolean, date and node functions depending on XPath version.
- Namespaces: prefixed names must be resolved through namespace bindings, not by raw text matching.

## Versions

- XPath 1.0 is still common in older APIs and browsers.
- XPath 2.0 and 3.x add stronger typing, sequences and richer functions.

[XPath Tutorial](https://www.w3schools.com/xml/xpath_intro.asp)

