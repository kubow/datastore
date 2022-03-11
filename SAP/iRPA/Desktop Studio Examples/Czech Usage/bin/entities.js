
//---------------------------------------------------
// Data Structures
//---------------------------------------------------
// ----------- rootData -------------------
ctx.dataManager({
	rootData :
	{
		xlsZdroj : 
		{
			xProdej : ''
			, xPoS : ''
			, xProdukty : ''
		}
		, kontrolaZRData : 
		{
			hledatZRData : 
			{
				oIco : ''
			}
			, nalezenoFormularData : 
			{
				oSpolecnost : ''
				, oDatovaSchranka : ''
				, oTelefon : ''
				, oEmail : ''
				, oAggInfo : ''
			}
		}
		, CZCData : 
		{
			CZChledatData : 
			{
				oFulltext : ''
			}
			, CZCnalezenoData : 
			{
				oCena : ''
				, oProdukty : ''
				, oNazev : ''
			}
		}
		, emailData : 
		{
			emailBody : ''
		}
	}
});
var rootData = ctx.dataManagers.rootData.create() ;

// ----------- rootData_xlsZdroj -------------------
ctx.dataManager({
	rootData_xlsZdroj :
	{
		xProdej : ''
		, xPoS : ''
		, xProdukty : ''
	}
});
var rootData_xlsZdroj = ctx.dataManagers.rootData_xlsZdroj.create() ;

// ----------- rootData_kontrolaZRData -------------------
ctx.dataManager({
	rootData_kontrolaZRData :
	{
		hledatZRData : 
		{
			oIco : ''
		}
		, nalezenoFormularData : 
		{
			oSpolecnost : ''
			, oDatovaSchranka : ''
			, oTelefon : ''
			, oEmail : ''
			, oAggInfo : ''
		}
	}
});
var rootData_kontrolaZRData = ctx.dataManagers.rootData_kontrolaZRData.create() ;

// ----------- rootData_kontrolaZRData_hledatZRData -------------------
ctx.dataManager({
	rootData_kontrolaZRData_hledatZRData :
	{
		oIco : ''
	}
});
var rootData_kontrolaZRData_hledatZRData = ctx.dataManagers.rootData_kontrolaZRData_hledatZRData.create() ;

// ----------- rootData_kontrolaZRData_nalezenoFormularData -------------------
ctx.dataManager({
	rootData_kontrolaZRData_nalezenoFormularData :
	{
		oSpolecnost : ''
		, oDatovaSchranka : ''
		, oTelefon : ''
		, oEmail : ''
		, oAggInfo : ''
	}
});
var rootData_kontrolaZRData_nalezenoFormularData = ctx.dataManagers.rootData_kontrolaZRData_nalezenoFormularData.create() ;

// ----------- rootData_CZCData -------------------
ctx.dataManager({
	rootData_CZCData :
	{
		CZChledatData : 
		{
			oFulltext : ''
		}
		, CZCnalezenoData : 
		{
			oCena : ''
			, oProdukty : ''
			, oNazev : ''
		}
	}
});
var rootData_CZCData = ctx.dataManagers.rootData_CZCData.create() ;

// ----------- rootData_CZCData_CZChledatData -------------------
ctx.dataManager({
	rootData_CZCData_CZChledatData :
	{
		oFulltext : ''
	}
});
var rootData_CZCData_CZChledatData = ctx.dataManagers.rootData_CZCData_CZChledatData.create() ;

// ----------- rootData_CZCData_CZCnalezenoData -------------------
ctx.dataManager({
	rootData_CZCData_CZCnalezenoData :
	{
		oCena : ''
		, oProdukty : ''
		, oNazev : ''
	}
});
var rootData_CZCData_CZCnalezenoData = ctx.dataManagers.rootData_CZCData_CZCnalezenoData.create() ;

// ----------- rootData_emailData -------------------
ctx.dataManager({
	rootData_emailData :
	{
		emailBody : ''
	}
});
var rootData_emailData = ctx.dataManagers.rootData_emailData.create() ;


//---------------------------------------------------
// Settings Structure
//---------------------------------------------------

//---------------------------------------------------
// Functional Events Declaration
//---------------------------------------------------

//---------------------------------------------------
// 
//---------------------------------------------------
