
// ----------------------------------------------------------------
//   Test menu for scenario kontrolaICO 
// ----------------------------------------------------------------
GLOBAL.events.START.on(function (ev) {
	if (ctx.options.isDebug) {
		// Add item in systray menu.
		systray.addMenu('', 'kontrolaICO', 'Test kontrolaICO', '', function (ev) {
			var rootData = ctx.dataManagers.rootData.create();
			
			// Initialize your data here.
			GLOBAL.scenarios.kontrolaICO.start(rootData);
		});
	}
});

//---------------------------------------------------
// Scenario kontrolaICO Starter ()
//---------------------------------------------------

// ----------------------------------------------------------------
//   Scenario: kontrolaICO
// ----------------------------------------------------------------
GLOBAL.scenario({ kontrolaICO: function(ev, sc) {
	var rootData = sc.data;

	sc.setMode(e.scenario.mode.clearIfRunning);
	sc.setScenarioTimeout(600000); // Default timeout for global scenario.
	sc.onError(function(sc, st, ex) { sc.endScenario(); }); // Default error handler.
	sc.onTimeout(30000, function(sc, st) { sc.endScenario(); }); // Default timeout handler for each step.
	sc.step(GLOBAL.steps.Write_log_1, GLOBAL.steps.Start_hledatZR);
	sc.step(GLOBAL.steps.Start_hledatZR, GLOBAL.steps.hledatZR_management);
	sc.step(GLOBAL.steps.hledatZR_management, GLOBAL.steps.nalezenoFormular_mana);
	sc.step(GLOBAL.steps.nalezenoFormular_mana, GLOBAL.steps.Write_log_1_1);
	sc.step(GLOBAL.steps.Write_log_1_1, null);
}}, ctx.dataManagers.rootData).setId('a5929c38-fd2a-45c3-8bed-5beaddc42ed6') ;

// ----------------------------------------------------------------
//   Step: Write_log_1
// ----------------------------------------------------------------
GLOBAL.step({ Write_log_1: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('kontrolaICOtest', '43419acf-9de5-49ec-a1fb-5ce9de2f12f8') ;
	// Write log
	ctx.log(rootData.kontrolaZRData.hledatZRData.oIco, e.logIconType.Info);
	sc.endStep(); // Start_hledatZR
	return;
}});

// ----------------------------------------------------------------
//   Step: Start_hledatZR
// ----------------------------------------------------------------
GLOBAL.step({ Start_hledatZR: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('kontrolaICOtest', '130e55f5-b2ba-4bcf-94bd-1c0c2d3a1e1d') ;
	// Start 'hledatZR'
	kontrolaZR.hledatZR.start();
	sc.endStep(); // hledatZR_management
	return;
}});

// ----------------------------------------------------------------
//   Step: hledatZR_management
// ----------------------------------------------------------------
GLOBAL.step({ hledatZR_management: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('kontrolaICOtest', '39c1f9d7-f728-4afc-b6ce-d326e3e16328') ;
	// Wait until the Page loads
	kontrolaZR.hledatZR.wait(function(ev) {
		kontrolaZR.hledatZR.oIco.wait(function(ev) {
			kontrolaZR.hledatZR.oIco.click();
			kontrolaZR.hledatZR.oIco.set(rootData.kontrolaZRData.hledatZRData.oIco);
			sc.endStep(); // nalezenoFormular_mana
			return;
		}, 0, 10000);
		kontrolaZR.hledatZR.oHledat.click();
	});
}});

// ----------------------------------------------------------------
//   Step: nalezenoFormular_mana
// ----------------------------------------------------------------
GLOBAL.step({ nalezenoFormular_mana: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('kontrolaICOtest', '71b03a47-ac0b-4a43-b1ba-c6ee816f0694') ;
	// Wait until the Page loads
	kontrolaZR.nalezenoFormular.wait(function(ev) {
		// Write log
		ctx.log('loguje to?:', e.logIconType.Info);
		sc.endStep(); // Write_log_1_1
		return;
	});
}});

// ----------------------------------------------------------------
//   Step: Write_log_1_1
// ----------------------------------------------------------------
GLOBAL.step({ Write_log_1_1: function(ev, sc, st) {
	var rootData = sc.data;
	ctx.workflow('kontrolaICOtest', '09993b46-18b4-4947-b453-f6a4263cdcde') ;
	// Write log
	ctx.log('co se tu deje?:' + rootData.kontrolaZR.nalezenoFormular.oAggInfo, ev.logIconType.Info);
	sc.endStep(); // end Scenario
	return;
}});
