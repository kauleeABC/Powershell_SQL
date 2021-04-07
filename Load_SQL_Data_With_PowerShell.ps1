<#
Author: Kuu Lee
Date: 4/6/2021

this task is to preform data load from server to other server
Note: make sure to install sqlserver module.

Instuction:
replace variable as require
#>


Import-Module sqlserver
#SQL server and query
$source_srv="SRV_Name" 
$destination_srv="SRV_Name"
#database name on destination server
$database="DB"
$tableName1="Table1"
$tableName2="Table2"
$query1="SELECT * FROM DB.dbo.Table1"
$query2="SELECT * FROM DB.dbo.Table2" 
#$queryValicate=" SELECT COUNT(*)  FROM Test_DB.dbo.xaction"
#this can be broken down to table veriables
#Trucate tables on destination server
$query_trucate="TRUNCATE TABLE DB.dbo.table1", "TRUNCATE TABLE DB.dbo.table2"

#stored data set on $data veriable 
     #$check = Invoke-Sqlcmd -Query "$queryValicate" -ServerInstance "$$destination_srv"

     # Staging
     #query connection function

     Function conn ($source_srv, $query)

     {

     Invoke-Sqlcmd -Query "$query" -ServerInstance "$source_srv"

     }

        #function writing data to destination server
      Function writeData ($source_srv, $destination_srv, $query, $database, $tableName)
      {
      $data=conn -server $source_srv -query $query 
      $data | Write-SQLTableData -ServerInstance "$destination_srv" -DatabaseName "$database" -SchemaName "dbo" -TableName "$tableName"

      }

      <# Preforming data load process#>
       
      #call conn function to trucate tables
      foreach ($q in $query_trucate)
      {      
      conn -server $destination_srv -query $query_trucate
      }

      writeData -server $source_srv -server2 $destination_srv -query $query1 -database $database -tableName $tableName1
      writeData -server $source_srv -server2 $destination_srv -query $query2 -database $database -tableName $tableName2

      #export to csv file
      #Invoke-Sqlcmd -Query "$query" -ServerInstance "$source_srv" | #|  Export-Csv -Path "$filename.csv" -NoTypeInformation
