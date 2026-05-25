- [java read JDBC connection from XML file - Stack Overflow](https://stackoverflow.com/questions/3674422/java-read-jdbc-connection-from-xml-file)
- [How to parse XML in Bash? - Stack Overflow](https://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash)
- [bash - Edit xml file using shell script / command - Super User](https://superuser.com/questions/916665/edit-xml-file-using-shell-script-command)

## Parsing Models

- [DOM](DOM.md): loads the full tree; easiest for random access and mutation, expensive for very large documents.
- [SAX](SAX.md): event callback parser; low memory, harder control flow.
- StAX: pull parser; low memory and easier composition than SAX.
- XPath APIs: convenient for extracting values from moderate-sized documents.
- XSLT/XQuery processors: better for declarative transformation and complex XML querying.

## Practical Rules

- Do not parse XML with regular expressions.
- Disable external entities for untrusted XML.
- Use namespace-aware parsers.
- Use streaming parsers for large or unbounded input.
- Prefer XSD/RELAX NG/Schematron validation at boundaries, not inside every internal step.

# PHP
[Cutting Edge Data Processing with PHP & XQuery | PPT](https://www.slideshare.net/slideshow/cutting-edge-data-processing-with-php-xquery/10320507)

[Execute a XQuery with PHP - Stack Overflow](https://stackoverflow.com/questions/2211743/execute-a-xquery-with-php)

[PHP XML Parser Functions](https://www.w3schools.com/php/php_ref_xml.asp)
[PHP XML Classes](https://phpxmlclasses.sourceforge.net/)

# Python

- [Zpracování XML v Pythonu s využitím knihovny lxml - Root.cz](https://www.root.cz/clanky/zpracovani-xml-v-pythonu-s-vyuzitim-knihovny-lxml)
- [Zpracování XML a HTML v Pythonu s využitím knihoven lxml a Beautiful Soup - Root.cz](https://www.root.cz/clanky/zpracovani-xml-a-html-v-pythonu-s-vyuzitim-knihoven-lxml-a-beautiful-soup)
[python - How to parse XML and get instances of a particular node attribute? - Stack Overflow](https://stackoverflow.com/questions/1912434/how-to-parse-xml-and-get-instances-of-a-particular-node-attribute)

[python - Get contents of div by id with BeautifulSoup - Stack Overflow](https://stackoverflow.com/questions/25614702/get-contents-of-div-by-id-with-beautifulsoup#25614774)

