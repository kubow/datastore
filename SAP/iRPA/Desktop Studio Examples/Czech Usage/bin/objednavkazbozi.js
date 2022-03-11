
// ----------------------------------------------------------------
//   Test menu for scenario objednavkaZbozi 
// ----------------------------------------------------------------
GLOBAL.events.START.on(function (ev) {
	if (ctx.options.isDebug) {
		// Add item in systray menu.
		systray.addMenu('', 'objednavkaZbozi', 'Test objednavkaZbozi', '', function (ev) {
			var rootData = ctx.dataManagers.rootData.create();
			
			// Initialize your data here.
			GLOBAL.scenarios.objednavkaZbozi.start(rootData);
		});
	}
});

//---------------------------------------------------
// Scenario objednavkaZbozi Starter ()
//---------------------------------------------------

// ----------------------------------------------------------------
//   Scenario: objednavkaZbozi
// ----------------------------------------------------------------
GLOBAL.scenario({ objednavkaZbozi: function(ev, sc) {
	var rootData = sc.data;

	sc.setMode(e.scenario.mode.clearIfRunning);
	sc.setScenarioTimeout(600000); // Default timeout for global scenario.
	sc.onError(function(sc, st, ex) { sc.endScenario(); }); // Default error handler.
	sc.onTimeout(30000, function(sc, st) { sc.endScenario(); }); // Default timeout handler for each step.
	sc.step(GLOBAL.steps.hledatProdukt_managem, GLOBAL.steps.Start_CZChledat);
	sc.step(GLOBAL.steps.Start_CZChledat, GLOBAL.steps.CZChledat_management);
	sc.step(GLOBAL.steps.CZChledat_management, GLOBAL.steps.CZCnalezeno_managemen);
	sc.step(GLOBAL.steps.CZCnalezeno_managemen, GLOBAL.steps.Start_AlzaHledat);
	sc.step(GLOBAL.steps.Start_AlzaHledat, GLOBAL.steps.AlzaHledat_management);
	sc.step(GLOBAL.steps.AlzaHledat_management, null);
}}, ctx.dataManagers.rootData).setId('7b01a9e1-6092-4e1b-8e99-e6a717166762') ;

// ----------------------------------------------------------------
//   Step: hledatProdukt_managem
// ----------------------------------------------------------------
GLOBAL.step({ hledatProdukt_managem: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', '26077a41-d476-4aa0-ab5f-2901d730b3e3') ;
	// Open the Popup
	POPUPS.hledatProdukt.open();
	// Wait until the Popup loads
	POPUPS.hledatProdukt.wait(function(ev) {
		// Wait until the end user clicks on the item.
		POPUPS.hledatProdukt.button1.events.CLICK.on(function(ev) {
			var data = ev.data;
			rootData.CZCData.CZChledatData.oFulltext = POPUPS.hledatProdukt.text1.get();
			sc.endStep(); // Start_CZChledat
			return;
		});
	});
}});

// ----------------------------------------------------------------
//   Step: Start_CZChledat
// ----------------------------------------------------------------
GLOBAL.step({ Start_CZChledat: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', '78b8fb45-6c4b-4c5c-bd39-ebee2a967b38') ;
	// Start 'CZChledat'
	CZC.CZChledat.start();
	sc.endStep(); // CZChledat_management
	return;
}});

// ----------------------------------------------------------------
//   Step: CZChledat_management
// ----------------------------------------------------------------
GLOBAL.step({ CZChledat_management: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', '90933070-06eb-4871-84fe-9f841b4feb84') ;
	// Wait until the Page loads
	CZC.CZChledat.wait(function(ev) {
		// Write log
		ctx.log("Hledam vyraz: " + rootData.CZCData.CZChledatData.oFulltext, e.logIconType.Info);
		CZC.CZChledat.oFulltext.click();
		CZC.CZChledat.oFulltext.set(rootData.CZCData.CZChledatData.oFulltext);
		CZC.CZChledat.oFulltext.keyStroke(e.key.Enter);
		sc.endStep(); // CZCnalezeno_managemen
		return;
	});
}});

// ----------------------------------------------------------------
//   Step: CZCnalezeno_managemen
// ----------------------------------------------------------------
GLOBAL.step({ CZCnalezeno_managemen: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', '433cf6c9-b036-4913-aee5-3ea45a98fd7b') ;
	// Wait until the Page loads
	CZC.CZCnalezeno.wait(function(ev) {
		CZC.CZCnalezeno.btNejprodavanejsi.click();
		// Wait until the item gets the focus.
		CZC.CZCnalezeno.btNejprodavanejsi.events.SETFOCUS.once(function(ev) {
			var data = ev.data;
			rootData.CZCData.CZCnalezenoData.oNazev = CZC.CZCnalezeno.oNazev.i(0).get();
			rootData.CZCData.CZCnalezenoData.oCena = CZC.CZCnalezeno.oCena.i(0).get();
			rootData.CZCData.CZCnalezenoData.oProdukty = CZC.CZCnalezeno.oProdukty.i(0).get();
			// Write log
			ctx.log(rootData.CZCData.CZCnalezenoData.oProdukty + "/" + rootData.CZCData.CZCnalezenoData.oCena, e.logIconType.Info);
			sc.endStep(); // Start_AlzaHledat
			return;
		});
	});
}});

// ----------------------------------------------------------------
//   Step: Start_AlzaHledat
// ----------------------------------------------------------------
GLOBAL.step({ Start_AlzaHledat: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', 'bac3a50c-cfe2-4d8e-b1fa-b9da0195a519') ;
	// Start 'AlzaHledat'
	AlzaCz.AlzaHledat.start();
	sc.endStep(); // AlzaHledat_management
	return;
}});

// ----------------------------------------------------------------
//   Step: AlzaHledat_management
// ----------------------------------------------------------------
GLOBAL.step({ AlzaHledat_management: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('objednavkaZbozi', '07db89b8-5b89-43f6-acaf-5dda0730ea12') ;
	// Wait until the Page loads
	AlzaCz.AlzaHledat.wait(function(ev) {
		sc.endStep(); // end Scenario
		return;
	});
}});
