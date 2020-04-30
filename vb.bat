@echo off
if /I "%1"=="stop" (VBoxManage controlvm FreeDDos poweroff)
if /I "%1"=="reset" (VBoxManage controlvm FreeDDos reset)
if /I "%1"=="sexit" (VBoxManage controlvm FreeDDos savestate)
if /I "%1"=="run" (VBoxManage startvm  FreeDDos)
