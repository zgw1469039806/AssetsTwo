@echo off

setlocal EnableDelayedExpansion 
::set jarpth=..\classes
::for /F %%a in ('dir ..\lib\*.jar/b') do set jarpth=!jarpth!;..\lib\%%a

set jarpth=..\classes;..\lib\*

java -Xms512m -Xmx1024m -XX:PermSize=256M -XX:MaxPermSize=512m -cp %jarpth%  avicit.platform6.core.rest.NettyStart