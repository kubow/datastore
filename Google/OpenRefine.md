[http://seowebmaster.cz/uvod-do-open-refine](http://seowebmaster.cz/uvod-do-open-refine)


  
Building from source [https://github.com/OpenRefine/OpenRefine/wiki/Building-OpenRefine-From-Source](https://github.com/OpenRefine/OpenRefine/wiki/Building-OpenRefine-From-Source)

[https://programminghistorian.org/en/lessons/fetch-and-parse-data-with-openrefine](https://programminghistorian.org/en/lessons/fetch-and-parse-data-with-openrefine)

Extensions list [http://openrefine.org/download.html#list-of-extensions](http://openrefine.org/download.html#list-of-extensions)  
  
RAM limit when loading CSV files [https://stackoverflow.com/questions/47925325/google-openrefine-dont-load-big-csv-file](https://stackoverflow.com/questions/47925325/google-openrefine-dont-load-big-csv-file)  
  
fetching URL [https://github.com/OpenRefine/OpenRefine/wiki/Fetching-URLs-From-Web-Services](https://github.com/OpenRefine/OpenRefine/wiki/Fetching-URLs-From-Web-Services)  
fetching & parsing data lesson [https://programminghistorian.org/en/lessons/fetch-and-parse-data-with-openrefine](https://programminghistorian.org/en/lessons/fetch-and-parse-data-with-openrefine)  
  
  
extract HTML attributes [https://github.com/OpenRefine/OpenRefine/wiki/StrippingHTML](https://github.com/OpenRefine/OpenRefine/wiki/StrippingHTML)  
css selector syntax [https://jsoup.org/cookbook/extracting-data/selector-syntax](https://jsoup.org/cookbook/extracting-data/selector-syntax)



```bash
value.parseHtml().select(".infobox")  
value.parseHtml().select("div#content")[0].select("tr").toString()  
  
forEach(value.parseHtml().select("a[href~=\\d+]"),e,e.htmlAttr("href")).join("SplitCharsGoHere")

```
