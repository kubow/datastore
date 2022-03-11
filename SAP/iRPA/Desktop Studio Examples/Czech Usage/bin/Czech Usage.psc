<?xml version="1.0" encoding="utf-8"?>
<ConteXtorStudio Version="Desktop Studio 1.0.5.57" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" noNamespaceSchemaLocation="XsdStudio.xsd">
	<UpdatePackages />
	<Evolutions>
		<Evolution Version="1.0" Date="8/25/2020"><![CDATA[Project creation]]></Evolution>
		<Evolution Version="..." Date="..."><![CDATA[...]]></Evolution>
	</Evolutions>
	<PROCESSUS>
		<PROCESS Name="GLOBAL" Key="NoKey" Comment="Global Processus" CtxtId="d264cb4b-0c74-4647-8064-4fdb029bb732">
			<_DECLAREVAR>
				<STRUCTUREDON Name="GLOBAL">
					<OBJDON Name="PrjVersion">1.0</OBJDON>
					<OBJDON Name="PrjClient"><![CDATA[SCZ-J-VAJDA1]]></OBJDON>
					<OBJDON Name="PrjName">Czech Usage</OBJDON>
					<OBJDON Name="PrjDate">25/08/2020</OBJDON>
					<OBJDON Name="PrjLabel"><![CDATA[Use cases for Czech companies]]></OBJDON>
					<OBJDON Name="PrjComment"><![CDATA[Ares check
Exekuceinfo
]]></OBJDON>
					<OBJDON Name="LicenceURL" />
					<STRUCTUREDON Name="Xc_MessBoxHtml">
						<OBJDON Name="Style">style="font-size:12pt;font-family:'Arial'"</OBJDON>
						<OBJDON Name="ErrColor">white</OBJDON>
						<OBJDON Name="InfoColor">white</OBJDON>
						<OBJDON Name="ChoiceColor">white</OBJDON>
						<OBJDON Name="WarningColor">white</OBJDON>
						<OBJDON Name="ErrIcon">Critical.gif</OBJDON>
						<OBJDON Name="InfoIcon">Info.gif</OBJDON>
						<OBJDON Name="ChoiceIcon">Pencil.gif</OBJDON>
						<OBJDON Name="WarningIcon">Warning.gif</OBJDON>
						<OBJDON Name="StyleButton">style="font-size:12px;font-family:'Arial';width:80px"</OBJDON>
						<OBJDON Name="StyleText">style="font-size=11pt;font-family='Arial'"</OBJDON>
						<OBJDON Name="IconSize">32</OBJDON>
					</STRUCTUREDON>
				</STRUCTUREDON>
			</_DECLAREVAR>
			<SCRIPTS>
				<SCRIPT Name="Constants" Src="Czech Usage.min.js" Folder="Framework" />
			</SCRIPTS>
			<RESOURCES>
				<RESOURCE Name="popup" Src="%sdk%\templates\resources\popup\" Dest="popup" />
				<RESOURCE Name="agent16px" Src="%sdk%\templates\resources\bmp\agent.png" Dest="bmp" />
				<RESOURCE Name="accept16px" Src="%sdk%\templates\resources\bmp\accept.png" Dest="bmp" />
				<RESOURCE Name="cancel16px" Src="%sdk%\templates\resources\bmp\cancel.png" Dest="bmp" />
				<RESOURCE Name="help16px" Src="%sdk%\templates\resources\bmp\help.png" Dest="bmp" />
				<RESOURCE Name="information16px" Src="%sdk%\templates\resources\bmp\information.png" Dest="bmp" />
				<RESOURCE Name="repeat16px" Src="%sdk%\templates\resources\bmp\repeat.png" Dest="bmp" />
				<RESOURCE Name="stop16px" Src="%sdk%\templates\resources\bmp\stop.png" Dest="bmp" />
				<RESOURCE Name="warning16px" Src="%sdk%\templates\resources\bmp\warning.png" Dest="bmp" />
				<RESOURCE Name="record16px" Src="%sdk%\templates\resources\bmp\record.png" Dest="bmp" />
				<RESOURCE Name="agent32px" Src="%sdk%\templates\resources\bmp32\agent.png" Dest="bmp32" />
				<RESOURCE Name="accept32px" Src="%sdk%\templates\resources\bmp32\accept.png" Dest="bmp32" />
				<RESOURCE Name="cancel32px" Src="%sdk%\templates\resources\bmp32\cancel.png" Dest="bmp32" />
				<RESOURCE Name="help32px" Src="%sdk%\templates\resources\bmp32\help.png" Dest="bmp32" />
				<RESOURCE Name="information32px" Src="%sdk%\templates\resources\bmp32\information.png" Dest="bmp32" />
				<RESOURCE Name="user32px" Src="%sdk%\templates\resources\bmp32\user.png" Dest="bmp32" />
				<RESOURCE Name="warning32px" Src="%sdk%\templates\resources\bmp32\warning.png" Dest="bmp32" />
				<RESOURCE Name="agent64px" Src="%sdk%\templates\resources\bmp64\agent.png" Dest="bmp64" />
				<RESOURCE Name="hello64px" Src="%sdk%\templates\resources\bmp64\hello.png" Dest="bmp64" />
				<RESOURCE Name="hello128px" Src="%sdk%\templates\resources\bmp64\hello128.png" Dest="bmp64" />
				<RESOURCE Name="gif" Src="%sdk%\templates\resources\gif\" Dest="gif" />
			</RESOURCES>
			<_ECRANS />
			<WORKFLOWS>
				<WORKFLOW Name="mesicniUzaverka" Src="%workflows%\mesicniuzaverka.xaml" CtxtId="549d0abd-bc54-4411-927c-412ee7b1f175" DisplayName="mesicniUzaverka" StepTimeout="30" ScenarioTimeout="600" GeneratedScenarioName="mesicniUzaverka" />
				<WORKFLOW Name="kontrolaICOtest" Src="%workflows%\kontrolaicotest.xaml" CtxtId="a5929c38-fd2a-45c3-8bed-5beaddc42ed6" DisplayName="kontrolaICO" StepTimeout="30" ScenarioTimeout="600" GeneratedScenarioName="kontrolaICO" />
				<WORKFLOW Name="objednavkaZbozi" Src="%workflows%\objednavkaZbozi.xaml" CtxtId="7b01a9e1-6092-4e1b-8e99-e6a717166762" DisplayName="objednavkaZbozi" StepTimeout="30" ScenarioTimeout="600" GeneratedScenarioName="objednavkaZbozi" />
			</WORKFLOWS>
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</PROCESS>
		<PROCESS Name="POPUPS" CtxtId="0ce1de06-0d50-4d24-806a-eaaf5e2c0be7" Nature="POPUP">
			<_DECLAREVAR>
				<STRUCTUREDON Name="POPUPS" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="hledatProdukt" CtxtId="62b84799-893f-4863-94a2-6bce32447117" Template="popup.pscm" Type="POPUP" Comment="file://C:\Users\j.vajda\Documents\SAP\Intelligent RPA\Desktop Studio\Czech Usage\bin\hledatProdukt\popup.html?DesignMode=true TestMode=true">
					<OBJETS>
						<OBJET Name="text1" CtxtId="3dc94565-7423-41d3-a9a7-d14fedd17bfd" SpecIndex="1" ImagePath="fa/terminal.png" OrderBy="1">
							<CRITERE>
								<TAG Name="INPUT" Scope="All">
									<ATT Name="id">
										<VALUE Scan="Full"><![CDATA[text1]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="button1" CtxtId="9e43a9dc-4b10-4f3b-981f-7cd0ea430dc0" ImagePath="fa/hand-o-up.png" OrderBy="2" SpecIndex="3">
							<CRITERE>
								<TAG Name="BUTTON" Scope="All">
									<ATT Name="id">
										<VALUE Scan="Full"><![CDATA[button1]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="CLICK" />
							</TRACK_EVENTS>
						</OBJET>
					</OBJETS>
				</PAGE>
			</_ECRANS>
			<SCRIPTS />
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</PROCESS>
	</PROCESSUS>
	<APPLICATIONS>
		<APPLI Name="kontrolaRejstrik" CtxtId="adab6692-a5ff-4b37-838b-b3755c5299b0" Nature="WEB3" TechnoSDK="V3" Sync="250">
			<SCRIPTS />
			<CRITERE>
				<TITLE Scan="Full"><![CDATA[Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky]]></TITLE>
			</CRITERE>
			<_DECLAREVAR>
				<STRUCTUREDON Name="kontrolaRejstrik" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="hledatFormular" Comment="Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky" CtxtId="609f2faa-9d3a-4d4b-b7b8-d337b6dca7ce">
					<CRITERE>
						<TITLE Scan="Full"><![CDATA[Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky]]></TITLE>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oIco" CtxtId="65a5a051-f65a-440b-82e6-078e0b735b19" SpecIndex="1">
							<CRITERE>
								<TAG Name="INPUT" Scope="All" CapturedPos="10.R0R1R0R1R0R0R1R0R0R0R1R0R0R1R1R1R0R0">
									<ATT Name="name">
										<VALUE Scan="Full"><![CDATA[ico]]></VALUE>
									</ATT>
									<ATT Name="title">
										<VALUE Scan="Full"><![CDATA[Identifikační číslo]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="SETFOCUS" />
								<TRACK_EVENT Name="CLICK" />
							</TRACK_EVENTS>
						</OBJET>
						<OBJET Name="oHledat" CtxtId="ab9e75f6-c6e0-4393-912c-98023db10754" SpecIndex="2">
							<CRITERE>
								<TAG Name="BUTTON" Scope="All" CapturedPos="10.R0R1R0R1R0R0R1R0R0R0R3R0">
									<ATT Name="Text">
										<VALUE Scan="Full"><![CDATA[ Vyhledat ]]></VALUE>
									</ATT>
									<ATT Name="type">
										<VALUE Scan="Full"><![CDATA[submit]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="CLICK" />
							</TRACK_EVENTS>
						</OBJET>
					</OBJETS>
				</PAGE>
				<PAGE Name="nalezenoFormular" Comment="Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky" CtxtId="2c3dea4f-4433-472b-8fab-22a228f37b01">
					<CRITERE>
						<TITLE Scan="Full"><![CDATA[Veřejný rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky]]></TITLE>
						<REFERRER Scan="Full"><![CDATA[https://or.justice.cz/ias/ui/rejstrik-$firma]]></REFERRER>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oSearchResults" CtxtId="2e0420bd-7133-42bf-99f1-a065aaa2acac">
							<CRITERE>
								<TAG Name="DIV" Scope="All" CapturedPos="13.R0R1R0R1R0R1">
									<ATT Name="id">
										<VALUE Scan="Full"><![CDATA[SearchResults]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
			</_ECRANS>
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</APPLI>
		<APPLI Name="kontrolaZR" CtxtId="cc70e027-a4ea-4ccd-a1bf-b2572fa2556e" Nature="WEB3" TechnoSDK="V3" Sync="250">
			<SCRIPTS />
			<CRITERE>
				<DOMAIN Scan="Full"><![CDATA[rejstrik-firem.kurzy.cz]]></DOMAIN>
				<TITLE Scan="Full"><![CDATA[Živnostenský rejstřík - rejstřík živnostníků | Kurzy.cz]]></TITLE>
			</CRITERE>
			<_DECLAREVAR>
				<STRUCTUREDON Name="kontrolaZR" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="hledatZR" Comment="Živnostenský rejstřík - rejstřík živnostníků | Kurzy.cz" CtxtId="7e32ba35-5f89-4e54-a342-3b57f0b89f53">
					<CRITERE>
						<DOMAIN Scan="Full"><![CDATA[rejstrik-firem.kurzy.cz]]></DOMAIN>
						<TITLE Scan="Full"><![CDATA[Živnostenský rejstřík - rejstřík živnostníků | Kurzy.cz]]></TITLE>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oIco" CtxtId="bdcfc2a1-9e32-4962-849c-e8ba6f341ade" SpecIndex="1">
							<CRITERE>
								<TAG Name="INPUT" Scope="All" CapturedPos="15.R0R1R2R1R0R1R0R3R2R0R0R2R0R0">
									<ATT Name="name">
										<VALUE Scan="Full"><![CDATA[s]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="CLICK" />
							</TRACK_EVENTS>
						</OBJET>
						<OBJET Name="oHledat" CtxtId="b43ad6f3-60aa-469f-923c-4d6a7cd7f1e4" SpecIndex="2">
							<CRITERE>
								<TAG Name="INPUT" Scope="All" CapturedPos="15.R0R1R2R1R0R1R0R3R2R0R0R4R0R0">
									<ATT Name="value">
										<VALUE Scan="Full"><![CDATA[Vyhledat firmu nebo osobu]]></VALUE>
									</ATT>
									<ATT Name="type">
										<VALUE Scan="Full"><![CDATA[submit]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
				<PAGE Name="nalezenoFormular" Comment="METAL PUZZLE, s.r.o. , Libošovice IČO 25974947 - Obchodní rejstřík firem | Kurzy.cz" CtxtId="b5c322ea-3004-4ba1-968d-86100e71589b">
					<CRITERE>
						<DOMAIN Scan="Full"><![CDATA[rejstrik-firem.kurzy.cz]]></DOMAIN>
						<TITLE Scan="Full"><![CDATA[METAL PUZZLE, s.r.o. , Libošovice IČO 25974947 - Obchodní rejstřík firem | Kurzy.cz]]></TITLE>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oAggInfo" CtxtId="da8640cf-2c90-4791-9373-c0597d4bf1c7" SpecIndex="5">
							<CRITERE>
								<TAG Name="H1" Scope="All" CapturedPos="16.R0R1R1R1R0R1R0R1" />
							</CRITERE>
						</OBJET>
						<OBJET Name="oSpolecnost" CtxtId="2b23cc94-3a8c-49c0-a6cd-f15619e1767c" SpecIndex="1">
							<CRITERE>
								<TAG Name="SPAN" Scope="All" CapturedPos="16.R0R1R1R1R0R1R0R5R1R0R0R0R1R0">
									<ATT Name="itemprop">
										<VALUE Scan="Full"><![CDATA[legalName]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="oDatovaSchranka" CtxtId="82530830-5cc0-4784-ade0-0fdafa96f9a0" SpecIndex="2">
							<CRITERE>
								<TAG Name="A" Scope="All" CapturedPos="16.R0R1R1R1R0R1R0R5R1R0R0R3R1R0">
									<ATT Name="title">
										<VALUE Scan="Full"><![CDATA[Kontakty: Datová schránka]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="oTelefon" CtxtId="6296b2ce-1fa6-486b-bb95-12b67f149ce2" SpecIndex="3">
							<CRITERE>
								<TAG Name="TD" Scope="All" CapturedPos="16.R0R1R1R1R0R1R0R5R6R5R0R0R1">
									<ATT Name="itemprop">
										<VALUE Scan="Full"><![CDATA[telephone]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="oEmail" CtxtId="0451a0c9-d3f8-4a7b-ab2d-1d5708de274f" SpecIndex="4">
							<CRITERE>
								<TAG Name="A" Scope="All" CapturedPos="16.R0R1R1R1R0R1R0R5R6R5R0R1R1R0">
									<ATT Name="itemprop">
										<VALUE Scan="Full"><![CDATA[email]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
			</_ECRANS>
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</APPLI>
		<APPLI Name="CZC" CtxtId="246fcf34-4b95-4632-8721-517ffbf9c6d4" Nature="WEB3" TechnoSDK="V3" Sync="250">
			<CRITERE>
				<DOMAIN Scan="Full"><![CDATA[www.czc.cz]]></DOMAIN>
			</CRITERE>
			<_DECLAREVAR>
				<STRUCTUREDON Name="CZC" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="CZChledat" Comment="CZC.cz - rozumíme vám i elektronice" CtxtId="ca0546e6-09e6-401f-b42a-ebf06e6819f5">
					<CRITERE>
						<DOMAIN Scan="Full"><![CDATA[www.czc.cz]]></DOMAIN>
						<URL Scan="Full"><![CDATA[https://www.czc.cz/]]></URL>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oFulltext" CtxtId="669258b6-6d61-4b21-b51b-9dc993c80953" SpecIndex="3">
							<CRITERE>
								<TAG Name="INPUT" Scope="All" CapturedPos="24.R0R1R3R6R2R0R0R1R0R1">
									<ATT Name="name">
										<VALUE Scan="Full"><![CDATA[fulltext]]></VALUE>
									</ATT>
									<ATT Name="type">
										<VALUE Scan="Full"><![CDATA[search]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
				<PAGE Name="CZCnalezeno" Comment="Vyhledávání  myš microsoft  | CZC.cz" CtxtId="229be4aa-c248-4ba0-a97c-24b66d95a703">
					<CRITERE>
						<DOMAIN Scan="Full"><![CDATA[www.czc.cz]]></DOMAIN>
					</CRITERE>
					<OBJETS>
						<OBJET Name="btNejlevnejsi" CtxtId="139b9c42-0efd-4aa2-b363-94f2353e0b68">
							<CRITERE>
								<TAG Name="A" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R4R0R0R2R0">
									<ATT Name="Text">
										<VALUE Scan="Full"><![CDATA[Nejlevnější]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="btNejprodavanejsi" CtxtId="a30abadf-d2e1-4704-8ae8-4bbc5d0f0ec4" SpecIndex="5">
							<CRITERE>
								<TAG Name="A" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R4R0R0R4R0">
									<ATT Name="Text">
										<VALUE Scan="Full"><![CDATA[Nejprodávanější]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="CHANGE" />
								<TRACK_EVENT Name="SETFOCUS" />
							</TRACK_EVENTS>
						</OBJET>
						<OBJET Name="btDoporucene" CtxtId="32d45b60-7566-4c13-8502-198c130c4dd6" SpecIndex="3">
							<CRITERE>
								<TAG Name="A" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R4R0R0R1R0">
									<ATT Name="Text">
										<VALUE Scan="Full"><![CDATA[Doporučené]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="oProdukty" CtxtId="8d52ff06-85de-4d53-84b8-7c99a6f3f67c" SpecIndex="2">
							<CRITERE>
								<TAG Name="DIV" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R7R0R0" Occurs="Y">
									<ATT Name="class">
										<VALUE Scan="Full"><![CDATA[new-tile]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
							<TRACK_EVENTS>
								<TRACK_EVENT Name="CHANGE" />
							</TRACK_EVENTS>
						</OBJET>
						<OBJET Name="oNazev" CtxtId="0028578f-15ce-418a-9a65-d6c548691065" SpecIndex="6">
							<CRITERE>
								<TAG Name="H5" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R7R0R0R1R1R0" Occurs="Y" />
							</CRITERE>
						</OBJET>
						<OBJET Name="oCena" CtxtId="b45c953b-2032-4810-9623-ed553ced3337" SpecIndex="1">
							<CRITERE>
								<TAG Name="DIV" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R7R0R0R1R2R0" Occurs="Y">
									<ATT Name="class">
										<VALUE Scan="Full"><![CDATA[total-price]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="btKoupit" CtxtId="2179249b-498d-4fdd-8c95-3432dfc4a1dc">
							<CRITERE>
								<TAG Name="BUTTON" Scope="All" CapturedPos="21.R0R1R3R8R0R1R1R7R0R0R1R2R1">
									<ATT Name="Text">
										<VALUE Scan="Full"><![CDATA[
Do košíku  
V košíku  ]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
			</_ECRANS>
			<SCRIPTS />
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</APPLI>
		<APPLI Name="AlzaCz" CtxtId="ef62f1b6-0240-4853-b936-b70108859bdc" Nature="WEB3" TechnoSDK="V3" Sync="250">
			<SCRIPTS />
			<CRITERE>
				<DOMAIN Scan="Full"><![CDATA[www.alza.cz]]></DOMAIN>
			</CRITERE>
			<_DECLAREVAR>
				<STRUCTUREDON Name="AlzaCz" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="AlzaHledat" Comment="Alza.cz - největší obchod s počítači a elektronikou | Alza.cz" CtxtId="5a0d86e7-342f-47f0-aeb4-589d8a2f2c68">
					<CRITERE>
						<DOMAIN Scan="end-with"><![CDATA[alza.cz]]></DOMAIN>
					</CRITERE>
					<OBJETS>
						<OBJET Name="oInputHledat" CtxtId="409cc205-bec0-4c77-882f-b4848f57512a">
							<CRITERE>
								<TAG Name="INPUT" Scope="All" CapturedPos="25.R0R1R4R0R0R1R3R3R0R0R0">
									<ATT Name="id">
										<VALUE Scan="Full"><![CDATA[edtSearch]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
						<OBJET Name="oBtnHledat" CtxtId="cb916627-9f03-481f-a6c9-d5e83bb7497e">
							<CRITERE>
								<TAG Name="DIV" Scope="All" CapturedPos="25.R0R1R4R0R0R1R3R3R0R1">
									<ATT Name="id">
										<VALUE Scan="Full"><![CDATA[btnSearch]]></VALUE>
									</ATT>
								</TAG>
							</CRITERE>
						</OBJET>
					</OBJETS>
				</PAGE>
			</_ECRANS>
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</APPLI>
		<APPLI Name="NahledKN" CtxtId="c1d43e96-e02f-451c-9345-62bf0a8dfea3" Nature="WEB3" TechnoSDK="V3" Sync="250">
			<CRITERE>
				<DOMAIN Scan="Full"><![CDATA[nahlizenidokn.cuzk.cz]]></DOMAIN>
			</CRITERE>
			<_DECLAREVAR>
				<STRUCTUREDON Name="NahledKN" />
			</_DECLAREVAR>
			<_ECRANS>
				<PAGE Name="pUvod" Comment="Nahlížení do katastru nemovitostí | Nahlížení do katastru nemovitostí" CtxtId="5d38c304-5cb7-4f9a-9007-d74cbffadf30">
					<CRITERE>
						<DOMAIN Scan="Full"><![CDATA[nahlizenidokn.cuzk.cz]]></DOMAIN>
					</CRITERE>
					<OBJETS />
				</PAGE>
			</_ECRANS>
			<SCRIPTS />
			<ACTIONS />
			<EVENTS />
			<SCENARII>
				<Steps />
			</SCENARII>
		</APPLI>
	</APPLICATIONS>
	<CONTEXT Id="6ded0ab9-31db-4342-a200-5eb70b88d432" />
</ConteXtorStudio>