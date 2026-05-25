[XML database - Wikipedia](https://en.wikipedia.org/wiki/XML_database)

XML engines sit between plain XML parsing and general-purpose databases. They preserve XML document structure, expose XML-aware query/indexing, and often care about round-tripping details such as document order, mixed content, comments, namespaces and CDATA.

## Storage Patterns

- **Text oriented**
	- XML files in a filesystem or object store.
	- XML stored as text/BLOB/CLOB in a relational DBMS.
	- Good for interchange and archiving, weak for XML-aware indexing.
- **Shredded relational**
	- XML is decomposed into relational tables.
	- Good for stable, regular schemas and SQL reporting.
	- Poor fit for mixed content, evolving schemas and round-tripping.
- **Model oriented**
	- Object-relational DOM mapping, where nodes become rows or objects.
	- Optimized node stores, path indexes and structural indexes.
	- Better for querying whole hierarchies and document collections.
- **Native XML database**
	- Stores XML as XML node structure.
	- Usually supports collections, XPath, XQuery, full-text search and XML-aware indexes.
- **Multi-model/document database**
	- Stores XML alongside JSON, RDF, text, search indexes or relational views.

## Engine Capabilities To Compare

- XML query support: [XPath](XPath.md), [XQuery](XQuery.md), SQL/XML, XSLT.
- Schema support: [DTD](DTD.md), [XSD](XSD.md), RELAX NG, Schematron.
- Indexes: element/attribute path indexes, value indexes, full-text indexes, namespace-aware indexes.
- Transactions: document-level or node-level locking, MVCC, collection-level operations.
- Collections: schema-flexible document sets, sometimes with metadata and permissions.
- Round-tripping: preservation of order, comments, processing instructions, whitespace, CDATA and namespaces.
- Referential integrity: ID/IDREF, XSD `key`/`keyref`, XLink or application-level links.
- Interfaces: HTTP/REST, XML:DB API, JDBC/ODBC via SQL/XML, language-specific clients.
- Security: external entity handling, schema resolution, permissions, encryption and auditability.

## Query And Transformation Engines

- [XPath](XPath.md) selects nodes and values; useful inside XSLT, XQuery, validators and programming APIs.
- [XQuery](XQuery.md) is designed for querying XML collections and constructing XML/HTML/text results.
- [XSLT](XSL.md) transforms XML into XML, HTML, text or other formats.
- Saxon is a major XSLT/XQuery processor.
- BaseX can be used both as a native XML database and as an XQuery processor.
- Xidel is a command-line extraction/query tool for HTML, XML and JSON.
- libxml2, Xerces and lxml are parser/validation libraries rather than databases.

## Native XML Databases

- [BaseX](https://basex.org/)
	- Native XML database and XQuery processor.
	- Supports XQuery, XPath, full-text search, REST, WebDAV and language clients.
	- [Clients | BaseX Documentation](https://docs.basex.org/main/Clients)
- [eXist-db](https://exist-db.org/exist/apps/homepage/index.html)
	- Open-source native XML database and application platform.
	- Strong XQuery/XPath orientation with REST and Java APIs.
	- [Writing Java Applications with the XML:DB API](https://exist-db.org/exist/apps/doc/devguide_xmldb)
- [Sedna XML Database](https://www.sedna.org/)
	- Native XML DBMS with XQuery support.
	- Historically important; check project status before new use.

## XML-Capable Database Engines

- MarkLogic
	- Multi-model document/search database with strong XML, XQuery and full-text capabilities.
	- Good fit for large document collections, publishing, search and metadata-heavy XML.
- Oracle XML DB
	- XMLType, XMLIndex, XQuery/XPath and schema-aware XML storage inside Oracle Database.
- Microsoft SQL Server XML
	- Native `xml` data type, XQuery methods and primary/secondary XML indexes.
- IBM Db2 pureXML
	- Native XML storage and indexing integrated with relational tables and SQL/XML.
- PostgreSQL XML
	- `xml` type and SQL/XML functions; less of a native XML database than Oracle/Db2/SQL Server.
- MySQL / MariaDB
	- XML extraction functions exist, but XML is not a central storage model.

## Native XML Database

[Nativní XML databáze - nástin teorie | Interval.cz](https://www.interval.cz/clanky/nativni-xml-databaze-nastin-teorie/)
[Nativní XML Databáze](https://www.fit.vut.cz/study/thesis/7006/.cs) | Digitální knihovna VUT v Brně 
