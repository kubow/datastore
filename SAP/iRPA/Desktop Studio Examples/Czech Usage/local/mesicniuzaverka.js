
// ----------------------------------------------------------------
//   Test menu for scenario mesicniUzaverka 
// ----------------------------------------------------------------
GLOBAL.events.START.on(function (ev) {
	if (ctx.options.isDebug) {
		// Add item in systray menu.
		systray.addMenu('', 'mesicniUzaverka', 'Test mesicniUzaverka', '', function (ev) {
			var rootData = ctx.dataManagers.rootData.create();
			
			// Initialize your data here.
			GLOBAL.scenarios.mesicniUzaverka.start(rootData);
		});
	}
});

//---------------------------------------------------
// Scenario mesicniUzaverka Starter ()
//---------------------------------------------------

// ----------------------------------------------------------------
//   Scenario: mesicniUzaverka
// ----------------------------------------------------------------
GLOBAL.scenario({ mesicniUzaverka: function(ev, sc) {
	var rootData = sc.data;

	sc.setMode(e.scenario.mode.clearIfRunning);
	sc.setScenarioTimeout(600000); // Default timeout for global scenario.
	sc.onError(function(sc, st, ex) { sc.endScenario(); }); // Default error handler.
	sc.onTimeout(30000, function(sc, st) { sc.endScenario(); }); // Default timeout handler for each step.
	// Initialize Loop counters
	sc.localData.StartLoop = 0;
	
	sc.step(GLOBAL.steps.Nacteni_dat_z_excelu, GLOBAL.steps.Write_log);
	sc.step(GLOBAL.steps.Write_log, GLOBAL.steps.StartLoop);
	sc.step(GLOBAL.steps.StartLoop, GLOBAL.steps.Ukoncit_blok);
	sc.step(GLOBAL.steps.Ukoncit_blok, GLOBAL.steps.Opakovat_blok, 'NEXT_LOOP');
	sc.step(GLOBAL.steps.Ukoncit_blok, GLOBAL.steps.Kontrola_ICO);
	sc.step(GLOBAL.steps.Kontrola_ICO, GLOBAL.steps.Opakovat_blok, 'NEXT_LOOP');
	sc.step(GLOBAL.steps.Kontrola_ICO, GLOBAL.steps.Opakovat_blok);
	sc.step(GLOBAL.steps.Opakovat_blok, GLOBAL.steps.StartLoop, 'NEXT_LOOP');
	sc.step(GLOBAL.steps.Opakovat_blok, GLOBAL.steps.Zaslání_emailu);
	sc.step(GLOBAL.steps.Zaslání_emailu, null);
}}, ctx.dataManagers.rootData).setId('549d0abd-bc54-4411-927c-412ee7b1f175') ;

// ----------------------------------------------------------------
//   Step: Nacteni_dat_z_excelu
// ----------------------------------------------------------------
GLOBAL.step({ Nacteni_dat_z_excelu: function(ev, sc, st) {
	var rootData = sc.data;
	// Initialize Excel
	ctx.options.excel.newXlsInstance = false;
	ctx.options.excel.visible = true;
	ctx.options.excel.displayAlerts = false;
	ctx.excel.initialize();
	// Open existing Excel file
	ctx.excel.file.open("C:\\_Run\\Project\\iRPA\\Provize.xlsx");
	// Activate worksheet
	ctx.excel.sheet.activate('Products');
	// Get values
	rootData.xlsZdroj.xProdukty = ctx.excel.sheet.getFullRangeValues('A',1,'B',6, undefined);
	// Set ProdCount
	sc.localData.prodCount = ctx.excel.sheet.getLastRow('A1')-1;
	// Activate worksheet
	ctx.excel.sheet.activate('PointOfSales');
	// Get values
	rootData.xlsZdroj.xPoS = ctx.excel.sheet.getFullRangeValues('A',1,'C',11, undefined);
	// Set PosCount
	sc.localData.posCount = ctx.excel.sheet.getLastRow('A1')-1;
	// Activate worksheet
	ctx.excel.sheet.activate('Provize');
	// Get values
	rootData.xlsZdroj.xProdej = ctx.excel.sheet.getFullRangeValues('A',1,'F',19, undefined);
	// Set ProvizeCount
	sc.localData.provizeLength = ctx.excel.sheet.getLastRow('A1')-1;
	// End Excel
	ctx.excel.end();
	sc.endStep(); // Write_log
	return;
}});

// ----------------------------------------------------------------
//   Step: Write_log
// ----------------------------------------------------------------
GLOBAL.step({ Write_log: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('mesicniUzaverka', '763afa04-7171-409b-86d2-a6ce2bdb3eae') ;
	// Write log
	ctx.log("nalezeno celkem " + sc.localData.provizeLength + " zaznamu" , e.logIconType.Info);
	sc.endStep(); // StartLoop
	return;
}});

// ----------------------------------------------------------------
//   Step: StartLoop
// ----------------------------------------------------------------
GLOBAL.step({ StartLoop: function(ev, sc, st) {
	var rootData = sc.data;
	
	ctx.workflow('mesicniUzaverka', '5b6328e8-25b7-4c26-b312-0aff2fc8aad1') ;
	// StartLoop
	if (sc.localData.StartLoop < 0) sc.localData.StartLoop = 0;
	sc.endStep(); // Ukoncit_blok
	return;
}});

// ----------------------------------------------------------------
//   Step: Ukoncit_blok
// ----------------------------------------------------------------
GLOBAL.step({ Ukoncit_blok: function(ev, sc, st) {
	var rootData = sc.data;
	
	ctx.workflow('mesicniUzaverka', '6484d62a-90e0-42c1-8628-af5709cbebd7') ;
	// Ukoncit blok
	if (sc.localData.StartLoop == (sc.localData.provizeLength-1))
	{
		sc.localData.StartLoop = -1 ;
		sc.endStep('NEXT_LOOP');
		return ;
	}
	sc.endStep(); // Kontrola_ICO
	return;
}});

// ----------------------------------------------------------------
//   Step: Kontrola_ICO
// ----------------------------------------------------------------
GLOBAL.step({ Kontrola_ICO: function(ev, sc, st) {
	var rootData = sc.data;
	// Vynulovani promenne ico
	rootData.kontrolaZRData.hledatZRData.oIco = "";
	// If (true)
	if (sc.localData.StartLoop > 0)
	{
		// Write log
		ctx.log("zaznam cislo "+sc.localData.StartLoop+" obsahuje tyto hodnoty: " + rootData.xlsZdroj.xProdej[sc.localData.StartLoop], e.logIconType.Info);
		// If (true)
		if (rootData.xlsZdroj.xProdej[sc.localData.StartLoop][4])
		{
			// Nalezeno ico
			rootData.kontrolaZRData.hledatZRData.oIco = rootData.xlsZdroj.xProdej[sc.localData.StartLoop][4];
			// Write log
			ctx.log("spoustim kontrolu subjektu cislo " + rootData.kontrolaZRData.hledatZRData.oIco, e.logIconType.Info);
		}
		sc.endStep(); // Opakovat_blok
		return;
	}
	// Delay (1000 ms)
	ctx.wait(function(ev) {
		sc.endStep(); // Opakovat_blok
		return;
	}, 1000);
}});

// ----------------------------------------------------------------
//   Step: Opakovat_blok
// ----------------------------------------------------------------
GLOBAL.step({ Opakovat_blok: function(ev, sc, st) {
	var rootData = sc.data;
	
	ctx.workflow('mesicniUzaverka', '91a18f12-5834-404c-8180-077b1ff1c1d7') ;
	// Opakovat blok
	if (sc.localData.StartLoop != -1)
	{
		sc.localData.StartLoop++ ;
		sc.endStep('NEXT_LOOP');
		return ;
	}
	sc.endStep(); // Zaslání_emailu
	return;
}});

// ----------------------------------------------------------------
//   Step: Zaslání_emailu
// ----------------------------------------------------------------
GLOBAL.step({ Zaslání_emailu: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('mesicniUzaverka', '6c38df65-084c-4dc1-b93e-669d75e2efbf') ;
	// functionality to be implemented in JavaScript later in the project.
	ctx.fso.init();
	ctx.outlook.init();
		ctx.outlook.reset();// This makes the current email index as 0
		// Path of your text file where you have written email body
		var emailContent = ctx.fso.file.read('C:\\_Run\\Project\\iRPA\\emailBody.txt');
		// Log statement. This will show email body content in desktop debugger
		ctx.log('Email body is' + emailContent);
		//Special characters will be replaced by name Baba
	  rootData.emailData.emailBody = emailContent.replace('@@@@', 'Name');
		// Enter email id you want to send an email
		ctx.outlook.mail.create({To: 'abc@def.com',
		Subject:'Excel To PDF'});
		ctx.outlook.mail.setBodyHtml(0, rootData.emailData.emailBody);
		// Give the path of your converted PDF file. So that it will attach and send an email
	  ctx.outlook.mail.attach(0, "C:\\_Run\\Project\\iRPA\\Provize.pdf");
	  ctx.outlook.mail.show(0); //It helps to test without sending the actual mail.
	  ctx.outlook.mail.send(0);
	sc.endStep(); // end Scenario
	return;
}});
