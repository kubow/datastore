# XML

XML is a text-based markup family for structured, hierarchical, self-describing documents. It is both a serialization syntax and a foundation for standards such as SOAP, RSS/Atom, SVG, XBRL, Office Open XML, AIXM and many industry exchange formats.

## Core Concepts

- **Well-formed XML**: follows XML syntax rules: one root element, matching tags, quoted attributes, legal nesting, escaped reserved characters.
- **Valid XML**: well-formed XML that also conforms to a schema such as [DTD](DTD.md), [XSD](XSD.md), RELAX NG or Schematron.
- **Elements and attributes**: elements model hierarchy and repeated structures; attributes model metadata or compact scalar properties.
- **Text, CDATA and entities**: text is parsed content; CDATA avoids escaping markup-like text; entities substitute predefined or declared values.
- **Namespaces**: qualify names with URIs so vocabularies can be mixed without name collisions, for example SOAP + domain payloads.
- **Infoset**: the abstract information model exposed after parsing, separate from the exact source text. See [XML Infoset](XML.Infoset.md).
- **Document order**: node order is significant for many XML workloads, unlike ordinary relational rows.
- **Canonical XML**: normalized byte representation used for signatures, comparison and repeatable hashing.

## Main Standards And Tools

- [DOM](DOM.md) - in-memory tree API.
- [SAX](SAX.md) - event streaming parser API.
- StAX - pull-based streaming parser API, common in Java.
- [XPath](XPath.md) - path language for selecting nodes.
- [XQuery](XQuery.md) - query language for XML collections and XML databases.
- [XSL / XSLT](XSL.md) - transformation and presentation-oriented processing.
- [XML databases and engines](XML.DB.md) - native XML databases, XML-enabled relational databases and XML query processors.
- [XML Programming Interfaces](XML.Programming.md)
- [AIXM](AIXM.md) - aviation XML exchange model.

## Schema And Validation

- [DTD](DTD.md) - older grammar-based validation, supports entities and document structure, but weak typing and namespace support.
- [XSD](XSD.md) - W3C XML Schema, strong datatypes, namespaces, keys and cardinality.
- RELAX NG - compact schema language often used when structure is more important than strong typing.
- Schematron - rule/assertion validation, useful for business rules that structural schemas cannot express well.
- XSD data types: [XML Schema Part 2: Datatypes Second Edition](https://www.w3.org/TR/xmlschema-2/#built-in-datatypes)

## Processing Models

- **Tree model**: DOM-style parsing loads a full document and is convenient for random access and mutation.
- **Event streaming**: SAX-style parsing is memory-efficient for large files but harder to program.
- **Pull streaming**: StAX-style parsing lets code request the next event and is easier to compose than SAX.
- **Query/transformation**: XPath, XQuery and XSLT operate on XML node models and are better than ad hoc string processing.
- **Binding/shredding**: XML can be mapped to objects or relational tables, but round-tripping may lose order, comments, whitespace or mixed content.

## Storage And Engines

XML workloads usually fall into these storage patterns:

- **Store as files or object storage**: simple archival and exchange; indexing and transactions come from the surrounding platform.
- **Store as text/BLOB/CLOB in a relational DB**: easy persistence, weak XML-aware querying unless the DB has XML features.
- **Shred to relational tables**: useful for stable, regular schemas; expensive when the XML shape changes often.
- **Native XML database**: stores XML node structure directly and usually supports XPath/XQuery indexes.
- **Multi-model/document database**: stores XML alongside JSON, text or semantic data.

See [XML.DB](XML.DB.md) for concrete engines such as BaseX, eXist-db, Sedna, MarkLogic, Oracle XML DB, SQL Server XML, Db2 pureXML and XML query processors.

## Security And Operations

- Disable external entity resolution by default to avoid XXE attacks.
- Protect parsers from entity expansion attacks such as "billion laughs".
- Prefer streaming parsers for untrusted or very large files.
- Use XML catalogs when schemas or DTDs need stable local resolution.
- Validate inputs at trust boundaries, but avoid network schema lookups during normal processing.

  
Standardy rodiny XML [https://www.fi.muni.cz/~tomp/slides/pb138/1std-terminology/standards/toc.html](https://www.fi.muni.cz/~tomp/slides/pb138/1std-terminology/standards/toc.html)  

XML examples[http://www.w3schools.com/xml/xml_examples.asp](http://www.w3schools.com/xml/xml_examples.asp)  
[DrugBank Release Version 5.1.12 | DrugBank Online](https://go.drugbank.com/releases/latest#full)

[Journey to the Center of the DrugBank XML Database - part 1 - DataScienceCentral.com](https://www.datasciencecentral.com/journey-to-the-center-of-the-drugbank-xml-database-part-1/)

XML Code Project [https://www.codeproject.com/KB/XML/](https://www.codeproject.com/KB/XML/)  
XML Archives [https://listserv.heanet.ie/cgi-bin/wa?A0=XML-L](https://listserv.heanet.ie/cgi-bin/wa?A0=XML-L)  

## XML Editors

[XML Parser Error Codes - IBM Documentation](https://www.ibm.com/docs/en/i/7.5?topic=documents-xml-parser-error-codes)
[Comparison of XML editors - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_XML_editors)

[XML command-line tools for manipulating structured text data](https://github.com/dbohdan/structured-text-tools?tab=readme-ov-file#xml)

[Xidel - HTML/XML/JSON data extraction tool](https://videlibri.sourceforge.net/xidel.html)
  
[XML Editor/Viewer Online - xmlGrid.net](https://xmlgrid.net/)


  

How-TO PDF publishing [http://cocoon.apache.org/2.0/howto/howto-html-pdf-publishing.html](http://cocoon.apache.org/2.0/howto/howto-html-pdf-publishing.html)  

