[XML Information Set (Second Edition)](https://www.w3.org/TR/xml-infoset/)

[XML Information Set - Wikipedia](https://en.wikipedia.org/wiki/XML_Information_Set)

XML Infoset is the abstract data model produced by parsing XML. It describes information items such as document, element, attribute, namespace, character, processing instruction and comment items.

Important distinction: the infoset is not the same as the exact source bytes. Attribute order, choice of quote style, entity boundaries and some whitespace details can disappear after parsing. This matters for round-tripping, digital signatures and canonicalization.