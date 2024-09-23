[XML database - Wikipedia](https://en.wikipedia.org/wiki/XML_database)

- Different types:
	- **Text oriented**
		- file in file system
		- BLOB/CLOB in Relational DBMS
	- **Model oriented**
		- object-relational DOM mapping (each child node has own SQL query, faster when XML > DOM loading)
		- optimised models (query over whole hierarchy)
- Data Model tools for XML:  [DOM](DOM.md), [DTD](DTD.md), [SAX](SAX.md), [XPath](XPath.md) or [XSL-T](http://www.w3.org/TR/xslt)
- Support **Transactions**
	- locks on document level
- Support queries
	- [XPath](XPath.md) (cannot cover use cases: GROUP BY, ORDER BY, JOIN, various data types)
	- XSLT offers broader functionality
	- [XQuery](XQuery.md) constructed specifically for DB use
- **Document Collection**, can be even without schema (schema independent). XML stored as a whole object, model (XML infoset/DOM) aside - multiple levels
- Programming Interfaces (ODBC-like interace)
	- [XML:DB Initiative: Enterprise Technologies for XML Databases](https://xmldb-org.sourceforge.net/)
	- [Writing Java Applications with the XML:DB API](https://exist-db.org/exist/apps/doc/devguide_xmldb)
	- HTTP server available
- Round-Tripping (work over same copy) for document order, elements, attributes and CDATA.
- Referential Integrity (key to a part of document, mostly internal links)
	- ID/IDREF attribute, key/keyref attribute (defined in XML schema) or XLink

## Native XML Database

[Nativní XML databáze - nástin teorie | Interval.cz](https://www.interval.cz/clanky/nativni-xml-databaze-nastin-teorie/)
[Nativní XML Databáze](https://www.fit.vut.cz/study/thesis/7006/.cs) | Digitální knihovna VUT v Brně 

- BaseX
	- [Clients | BaseX Documentation](https://docs.basex.org/main/Clients)
- [eXist-db - The Open Source Native XML Database](https://exist-db.org/exist/apps/homepage/index.html)
- [Sedna XML Database](https://www.sedna.org/)


