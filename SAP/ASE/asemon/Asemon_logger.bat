@echo off

if "%JAVA_HOME%" == "" goto set_java

if "%ASEMON_LOGGER_HOME%" == "" ( 
  set ASEMON_LOGGER_HOME=.
)

set ASEMON_LOGGER_HOME
set JAVA_HOME

set JCONNECT_HOME=%ASEMON_LOGGER_HOME%\jConnect-7_0
set classpath=%ASEMON_LOGGER_HOME%\dist\asemon_logger_V3.jar;%ASEMON_LOGGER_HOME%\lib\jdom.jar;%ASEMON_LOGGER_HOME%\lib\xerces.jar;%ASEMON_LOGGER_HOME%\lib\java-getopt-1.0.9.jar;%JCONNECT_HOME%\classes\jconn4.jar;%JCONNECT_HOME%\classes\jTDS3.jar;



set param_string=

@echo off 
set All=%*
set N=0
:boucle 
for /F "tokens=1,*" %%A in ("%All%") do (set P=%%A & set All=%%B) 
set /A N=%N%+1 
rem echo Parametre %N%=%P% 
set param_string=%param_string% %P%
if "%All%" NEQ "" goto boucle 

rem The next formulation allow more than 9 parameters
rem "%JAVA_HOME%"\bin\java -Xmx512m -DSYBASE=%SYBASE% -DASEMON_LOGGER_HOME=%ASEMON_LOGGER_HOME% -Dsun.net.inetaddr.ttl=0 -Duser.language=en asemon_logger/Asemon_logger %param_string% 
"%JAVA_HOME%"\bin\java -Xmx512m -DSYBASE=%SYBASE% -DASEMON_LOGGER_HOME=%ASEMON_LOGGER_HOME% -Dsun.net.inetaddr.ttl=0 asemon_logger/Asemon_logger %param_string% 
goto end

:set_java
    echo You must set JAVA_HOME before starting asemon_logger
:end
