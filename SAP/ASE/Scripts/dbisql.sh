#!/bin/sh
if [ -e "$SYBASE" ]; then
	$SYBASE/DBISQL-16_0/bin/dbisql
fi
