[Simple API for XML - Wikipedia](https://en.wikipedia.org/wiki/Simple_API_for_XML)

SAX is an event-driven XML parsing API. The parser reads forward through the document and calls handlers for events such as start element, text, end element and processing instruction.

## Use When

- XML input is large.
- Only a subset of the document is needed.
- Low memory usage matters.
- The processing can be done in document order.

## Tradeoffs

- Very memory-efficient.
- Harder to program than DOM because the application owns parsing state.
- Not suitable for random access or backward navigation.

[SAX](https://sax.sourceforge.net/)