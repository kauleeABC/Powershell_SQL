#using DBATOOLS to migrate database to new server 
Copy-DbaDatabase -Source "ServerName" -Destination "ServerName" -Database "DBName" -BackupRestore -SharedPath "shared file location"
