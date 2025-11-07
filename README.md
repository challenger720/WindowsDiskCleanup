Readme for Disk Clean Up

1. Copy cleanup.ps1 to C:\Temp on target computer using Admin share

2. On Endpoint Command Prompt, run 
	powershell.exe -ExecutionPolicy Bypass -File "C:\Temp\cleanup.ps1"
	
3. Admin can also download PSExec and run the PowerShell remotely from admin's Command Prompt using
"C:\Tools\PSTools\PsExec.exe" \\JC0XXXX -s -d powershell.exe -ExecutionPolicy Bypass -File "C:\Temp\cleanup.ps1"
	- Assuming your PsExec.exe is downloaded into C:\Tools\PSTools folder
	- Run cmd as admin in admin's computer
	- \\JC0XXXX is the target computer's hostname
