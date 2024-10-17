#Requires Autohotkey v1.1
#SingleInstance, force

::deoe::
SendRaw, docker exec -it standard_openemr_1 /bin/sh
return