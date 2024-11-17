#streaming 
## System

Log based replication (transactions from log read native db way) - no shadow tables, no triggers  
  
1st to create - ID server (1st server in domain)  
  
RSSD - system database contains (whole metadata, operational data, security information)  
  
Automatic materialization - create subscription  
  
From ASE side use sp_who to identify rep agent  
  
Gateway - connection between RS and another RS  
  
Stable device - Rep server prepares queue  
  
Rep definition - can be more over one table.  
  
Drop can be only if there is no subscription.


## Install

Replication Server 15.7.1 SP100 [http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc36924.1571100/doc/html/jer1331895047201.html](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc36924.1571100/doc/html/jer1331895047201.html)  
Replication Server 15.7.1 SP200 [http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc36924.1571200/doc/html/jer1331895047201.html](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc36924.1571200/doc/html/jer1331895047201.html)  
  
  
RS - 15.7.1 News  
• podporuje replikovanou kompresi  
• schopen fungovat s Large Object  
• rs_users / rs_maintusers  
• lze vypínat encryption  
• heterogenní multi-path replikace (libovolně Orace/ASE/SQL server)  
• auto-start replication agenta  
• truncation point


## Maintain

