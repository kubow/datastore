// Desktop Studio
// Auto-generated declaration file : do not modify !



var POPUPS = POPUPS || ctx.addApplication('POPUPS');



var kontrolaRejstrik = ctx.addApplication('kontrolaRejstrik', {"nature":"WEB3","path":"https://or.justice.cz/ias/ui/rejstrik-$firma"});

kontrolaRejstrik.hledatFormular = kontrolaRejstrik.addPage('hledatFormular', {"comment":"Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky","path":"https://or.justice.cz/ias/ui/rejstrik-$firma"});
kontrolaRejstrik.hledatFormular.oIco = kontrolaRejstrik.hledatFormular.addItem('oIco', {"trackEvents":{"SETFOCUS":true,"CLICK":true}});
kontrolaRejstrik.hledatFormular.oHledat = kontrolaRejstrik.hledatFormular.addItem('oHledat', {"trackEvents":{"CLICK":true}});

kontrolaRejstrik.nalezenoFormular = kontrolaRejstrik.addPage('nalezenoFormular', {"comment":"Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky","path":"https://or.justice.cz/ias/ui/rejstrik-$firma?p%3A%3Asubmit=x\u0026.%2Frejstrik-%24firma=\u0026nazev=\u0026ico=25974947\u0026obec=\u0026ulice=\u0026forma=\u0026oddil=\u0026vlozka=\u0026soud=\u0026polozek=50\u0026typHledani=STARTS_WITH\u0026jenPlatne=PLATNE"});
kontrolaRejstrik.nalezenoFormular.oSearchResults = kontrolaRejstrik.nalezenoFormular.addItem('oSearchResults');


var kontrolaZR = ctx.addApplication('kontrolaZR', {"nature":"WEB3","path":"https://rejstrik-firem.kurzy.cz/zivnostensky-rejstrik/"});

kontrolaZR.hledatZR = kontrolaZR.addPage('hledatZR', {"comment":"Živnostenský rejstřík - rejstřík živnostníků | Kurzy.cz","path":"https://rejstrik-firem.kurzy.cz/zivnostensky-rejstrik/"});
kontrolaZR.hledatZR.oIco = kontrolaZR.hledatZR.addItem('oIco', {"trackEvents":{"CLICK":true}});
kontrolaZR.hledatZR.oHledat = kontrolaZR.hledatZR.addItem('oHledat');

kontrolaZR.nalezenoFormular = kontrolaZR.addPage('nalezenoFormular', {"comment":"METAL PUZZLE, s.r.o. , Libošovice IČO 25974947 - Obchodní rejstřík firem | Kurzy.cz","path":"https://rejstrik-firem.kurzy.cz/hledej/?s=25974947\u0026r=True"});
kontrolaZR.nalezenoFormular.oAggInfo = kontrolaZR.nalezenoFormular.addItem('oAggInfo');
kontrolaZR.nalezenoFormular.oSpolecnost = kontrolaZR.nalezenoFormular.addItem('oSpolecnost');
kontrolaZR.nalezenoFormular.oDatovaSchranka = kontrolaZR.nalezenoFormular.addItem('oDatovaSchranka');
kontrolaZR.nalezenoFormular.oTelefon = kontrolaZR.nalezenoFormular.addItem('oTelefon');
kontrolaZR.nalezenoFormular.oEmail = kontrolaZR.nalezenoFormular.addItem('oEmail');


var CZC = ctx.addApplication('CZC', {"nature":"WEB3","path":"https://www.czc.cz/"});

CZC.CZChledat = CZC.addPage('CZChledat', {"comment":"CZC.cz - rozumíme vám i elektronice","path":"https://www.czc.cz/"});
CZC.CZChledat.oFulltext = CZC.CZChledat.addItem('oFulltext');

CZC.CZCnalezeno = CZC.addPage('CZCnalezeno', {"comment":"Vyhledávání  myš microsoft  | CZC.cz","path":"https://www.czc.cz/my%C5%A1%20microsoft/hledat"});
CZC.CZCnalezeno.btNejlevnejsi = CZC.CZCnalezeno.addItem('btNejlevnejsi');
CZC.CZCnalezeno.btNejprodavanejsi = CZC.CZCnalezeno.addItem('btNejprodavanejsi', {"trackEvents":{"CHANGE":true,"SETFOCUS":true}});
CZC.CZCnalezeno.btDoporucene = CZC.CZCnalezeno.addItem('btDoporucene');
CZC.CZCnalezeno.oProdukty = CZC.CZCnalezeno.addItem('oProdukty', {"occurs":1,"trackEvents":{"CHANGE":true}});
CZC.CZCnalezeno.oNazev = CZC.CZCnalezeno.addItem('oNazev', {"occurs":1});
CZC.CZCnalezeno.oCena = CZC.CZCnalezeno.addItem('oCena', {"occurs":1});
CZC.CZCnalezeno.btKoupit = CZC.CZCnalezeno.addItem('btKoupit');


var AlzaCz = ctx.addApplication('AlzaCz', {"nature":"WEB3","path":"https://www.alza.cz/"});

AlzaCz.AlzaHledat = AlzaCz.addPage('AlzaHledat', {"comment":"Alza.cz - největší obchod s počítači a elektronikou | Alza.cz","path":"https://www.alza.cz/"});
AlzaCz.AlzaHledat.oInputHledat = AlzaCz.AlzaHledat.addItem('oInputHledat');
AlzaCz.AlzaHledat.oBtnHledat = AlzaCz.AlzaHledat.addItem('oBtnHledat');


var NahledKN = ctx.addApplication('NahledKN', {"nature":"WEB3","path":"https://nahlizenidokn.cuzk.cz/"});

NahledKN.pUvod = NahledKN.addPage('pUvod', {"comment":"Nahlížení do katastru nemovitostí | Nahlížení do katastru nemovitostí","path":"https://nahlizenidokn.cuzk.cz/"});
