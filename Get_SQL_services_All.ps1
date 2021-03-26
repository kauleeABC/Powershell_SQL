<#
create by: Kau Lee
get SQL server services log on as account from multiple servers
this can be automate with txt file with list of servers or services
by 
$servers = Get-Content .\Serverlist.txt
$services = Get-Content .\Serviceslist.txt
#> 

#replace your server's name
$servers= 'server1' , 'server2'
$services='MSSQLSERVER', 'SQLSERVERAGENT','MSSQLServerOLAPService'
 ## (Get-WmiObject Win32_Service -Filter "Name='$serviceName'" -ComputerName T79TDW171SDB013).StartName 
foreach ($s in $servers)
{
    foreach ($sv in $services)
    {
        Get-CimInstance -ClassName CIM_Service  -ComputerName $s -Filter "Name='$sv'"| 
        Select-Object PSComputerName, Name, StartName, state, StartMode, status
    }
}
