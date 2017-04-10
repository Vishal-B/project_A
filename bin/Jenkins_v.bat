:: FILE NAME : jenkins_build.bat
::#########################################################
:: Batch File to run regression Test Suite on latest build.
::
:: Author : Vishal  Bhopal
:: Dated : 05,April,2017
::#########################################################
::
::
@echo off

set SOAPUI_HOME=%~dp0
if exist "%SOAPUI_HOME%..\jre\bin" goto SET_BUNDLED_JAVA

set PROJECT_NAME=Pearson-vishal-soapui-project.xml

if exist "%JAVA_HOME%" goto SET_SYSTEM_JAVA
echo JAVA_HOME is not set, unexpected results may occur.
goto SET_SYSTEM_JAVA

:SET_BUNDLED_JAVA
set JAVA=%SOAPUI_HOME%..\jre\bin\java
goto END_SETTING_JAVA

:SET_SYSTEM_JAVA
set JAVA=java

:END_SETTING_JAVA
echo  SOAPUI Setting 

set CLASSPATH=%SOAPUI_HOME%soapui-5.3.0.jar;%SOAPUI_HOME%..\lib\*
"%JAVA%" -cp "%CLASSPATH%" com.eviware.soapui.tools.JfxrtLocator > %TEMP%\jfxrtpath
set /P JFXRTPATH= < %TEMP%\jfxrtpath
del %TEMP%\jfxrtpath
set CLASSPATH=%CLASSPATH%;%JFXRTPATH%

set JAVA_OPTS=-Xms128m -Xmx1024m -Dsoapui.properties=soapui.properties "-Dsoapui.home=%SOAPUI_HOME%\"

if "%SOAPUI_HOME%\" == "" goto START
set JAVA_OPTS=%JAVA_OPTS% -Dsoapui.ext.libraries="%SOAPUI_HOME%ext"
echo run soapui testcase runner 


echo running project
"%JAVA%" %JAVA_OPTS% com.eviware.soapui.tools.SoapUITestCaseRunner -r %WORKSPACE%\%PROJECT_NAME%