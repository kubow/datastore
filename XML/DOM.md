[DOM Standard](https://dom.spec.whatwg.org/)
[Document Object Model - Wikipedia](https://en.wikipedia.org/wiki/Document_Object_Model)

DOM is a language-independent interface that represents XML or HTML as an in-memory tree.

## Use When

- The document is small or moderate in size.
- Code needs random access to many parts of the tree.
- Code needs to modify nodes and serialize the result.

## Tradeoffs

- Simple mental model: document, element, attribute, text and comment nodes.
- Preserves hierarchy and document order.
- Can be memory-heavy because the complete tree is loaded.
- Namespace handling must be explicit; do not compare prefixed names as plain text.

[Persistent DOM: An Architecture for XML Repositories in Relational Databases.](https://www.researchgate.net/publication/221253481_Persistent_DOM_An_Architecture_for_XML_Repositories_in_Relational_Databases)

## Extra

[Using shadow DOM - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_shadow_DOM)