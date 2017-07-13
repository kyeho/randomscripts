#List of service accounts to look for
$serviceaccounts = "DOMAIN\ACCOUNTNAMEGOESHERE"
write-host "This scan will attempt to locate any services, scheduled tasks, application pools and IIS virtual directories run under the following service accounts: `n $serviceaccounts `n `n"

#Get list of servers in domain
write-host "Gathering a list of Windows computers from AD `n"
$complist = (Get-ADComputer -filter 'operatingsystem -like "Windows*"' | select name ).name
write-host $complist `n

#Log file location
$log = "c:\ServiceAccounts.log"
write-host "Writing log file to $log `n"

#Clear Log
echo " " > $log
write-host "cleared log file `n"

#Set action on error
$ErrorActionPreference = "Stop"

#Cycle through computers in list and check for services, scheduled tasks, application pools and IIS shared vollume mounts using specified service accounts
foreach ($comp in $complist){
    write-output "================================================" "$comp"  >> $log

#Ensure computer is accesable via winrm before attempting lookups
    try{
        $winrmstatus = (Test-WSMan -ComputerName $comp -ErrorAction SilentlyContinue)
       }

    catch{}

    if ($winrmstatus) {

#Service account lookup
            try{
                $services = (Invoke-Command -ComputerName $comp -ScriptBlock {Get-WmiObject -Class Win32_Service} | where {$_.startname -in $serviceaccounts} | select name,startname,state | Format-table -AutoSize)
                if ($services) {
                                echo `n "Services:" >> $log
                                write-output $services  >> $log
                                write-host "Found services on $comp"
                               }
                }
            catch {
                    write-output "Application pool lookup failed on $comp (This shouldnt happen)" >> $log
                    write-host "Application pool lookup failed on $comp (This shouldnt happen)"
                  }

#Scheduled task lookup
            try{
                $tasks = (Invoke-Command -ComputerName $comp -ScriptBlock {schtasks.exe /query /V /FO CSV }  | ConvertFrom-Csv | where {$_."Run as user" -in $serviceaccounts} | Select-Object "taskname","run as user" | Format-table -AutoSize)
                if ($tasks) {
                             echo `n "Tasks:" `n >> $log
                             write-output $tasks `n >> $log
                             write-host "Found scheduled tasks on $comp"
                            }
               }
            catch{
                    write-output "Scheduled task lookup failed on $comp (This shouldnt happen)" >> $log
                    write-host "Scheduled task lookup failed on $comp (This shouldnt happen)"
                  }
                
#Application pool lookup

#Check if IIS is installed on system, if so run check for application pools and virtual directories
    try{
        $iisstatus = (Invoke-Command -computername $comp -ScriptBlock {get-wmiobject -query "select * from Win32_Service where name='W3svc'"} -ErrorAction SilentlyContinue)
       }

    catch{}

    if ($iisstatus) {
 #Application pool lookup                      
            try{
                $pools=(invoke-command -computername $comp -scriptblock {Import-Module WebAdministration; Get-ItemProperty 'IIS:\AppPools\*' "processModel.username" } | where {$_.value -in $serviceaccounts} | select PSChildName,value |  Format-table -AutoSize| Out-String)
                if ($pools) {
                             echo `n "Application Pools:" `n >> $log
                             write-output $pools `n >> $log
                             write-host "Found Application Pools on $comp"
                            }
               }
            catch{
                    write-output "Application pool lookup failed on $comp (This shouldnt happen)" >> $log
                    write-host "Application pool lookup failed on $comp (This shouldnt happen)"
                  }
#Virtual directory lookup                  
            try{
                $vdirs=(invoke-command -computername $comp -scriptblock {Import-Module WebAdministration; Get-WebVirtualDirectory } | where {$_.username -in $serviceaccounts} | select physicalpath,username |  Format-table -AutoSize| Out-String)
                if ($vdirs) {
                             echo `n "Virtual Directories:" `n >> $log
                             write-output $vdirs `n >> $log
                             write-host "Found Virtual Directories on $comp"
                            }
               }
            catch{
                    write-output "Virtual Directory lookup failed on $comp (This shouldnt happen)" >> $log
                    write-host "Virtual Directory lookup failed on $comp (This shouldnt happen)"
                  }       
                  
                  
                                   
                 }                
        }       

    else{
        write-output "Could not connect to $comp, make sure winrs is enabled on the remote machine and that winrm traffic is allowed to that network zone" >> $log
        write-host "Could not connect to $comp, make sure winrs is enabled on the remote machine and that winrm traffic is allowed to that network zone"
        }
}
