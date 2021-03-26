<#
create by: Kau Lee
get SQL server services from multiple servers
this can be automate with txt file with list of servers or services
by 

$servers = Get-Content .\Serverlist.txt
$services = Get-Content .\Serviceslist.txt
#>

$servers= 't79tdw171sdb003', 't79tdw171sdb013'
$services='MSSQLSERVER', 'SQLSERVERAGENT','MSSQLServerOLAPService'
##$services

foreach ($s in $servers)
{
    foreach ($sv in $services)
    {
        Get-WmiObject -Query "select * from win32_service where name = '$sv'" -ComputerName $s |
        Format-List -Property PSComputerName, Name, ExitCode, Name, ProcessID, StartMode, State, Status
    }
}
