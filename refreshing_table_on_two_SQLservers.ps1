<#
author: Kau Lee
Date:4/1/2021
#>

#SQL server and query
$server="source_server_name"
$server2="Destination_server_name"
$database="DB_name"
$tableName="table_name"
$query="SELECT * FROM sourcetable1" #,"SELECT * FROM sourcetable2" 
#$queryValicate=" SELECT COUNT(*)  FROM Test_DB.dbo.xaction"
$query_trucate="TRUNCATE TABLE destination_table"

#stored data set on $data veriable 
     
        #truncate destination table before insert now data
          Invoke-Sqlcmd -Query "$query_trucate" -ServerInstance "$server2"

          #query data from source table
          Invoke-Sqlcmd -Query "$query" -ServerInstance "$server" | #|  Export-Csv -Path "$filename.csv" -NoTypeInformation
           
        #write data to destination table
          Write-SQLTableData -ServerInstance $server2 -DatabaseName $database -SchemaName "dbo" -TableName $tableName
