#$JSONData = Get-Content -Raw -Path C:\Users\nsdc\Documents\test.json 
#| ConvertFrom-Json

#ForEach-Object $JSONData.amount {
#    New-Item -Name $JSONData.result -Path C:\Work\Temp\ -ItemType File
#}

#$JSONData | ForEach-Object {(",")}

#$JSONData | ForEach-Object -Process {Out-File -FilePath C:\Users\nsdc\test.json -Append -InputObject $_.Amount}

#$CsvData = Import-Csv C:\Users\nsdc\Downloads\election.CSV

#$CsvData | ? { $_.column1 -eq "1" } | Export-Csv -NoTypeInformation file1.csv

#$CsvData.result$csvdata.result 

$csvFile = "C:\Work\ESElection\election.csv"
$folderPath = Split-Path -Parent $csvFile

### filter out blank records and delete dashes from SSN ###
#(Get-Content $csvFile |
#    Select-Object |
#    Where-Object {$_.LastName -ne ""}) | #Rows with non-blank last name
#    Foreach-Object {$_ -Replace '(\d{3})-(\d{2})-(\d{4})','$1$2$3'} |
#    Set-Content $csvFile

### import csv data and export file for each row ###
$csv = Import-Csv -Path $csvFile -Delimiter ","

#Get-Content $csvFile | Select-Object 

foreach ($row in $csv) {
    $outPath = Join-Path -Path $folderPath\BulkCSV -ChildPath $($row.result + ".csv");
    $row | Select-Object | `
        ConvertTo-Csv -Delimiter "," | 
        #Foreach-Object {$_.Replace('"','')} | #Delete quotes around each "cell"
        Out-File $outPath
        #(Get-Content $outPath |
        #Set-Content $outPath)
        #Select-Object -Skip 1) | #Delete header
}

#Get-Date | Select-Object -Property DateTime, Day, DayOfWeek, DayOfYear | Export-Csv -Path Date.csv -NoTypeInformation
#Get-Content -Path "Date.csv"

$inputFeederFile = Get-ChildItem -Path "C:\Work\ESElection\BulkCSV\"

foreach ($file in $inputFeederFile) {
    $file | Select-Object -Property name
    $outputFile = New-Item -name "$file.json" -ItemType File -Path C:\Work\ESElection\BulkJSON\
    Get-Content -path C:\Work\ESElection\BulkCSV\$file | ConvertFrom-Csv -Delimiter ',' | ConvertTo-Json | Out-File $outputFile
}

$JSONFiles = Get-ChildItem -Path "C:\Work\ESElection\BulkJSON"

foreach ($JSONFile in $JSONFiles) {

    $JSONps = Get-Content -Raw [%1].csv.json | ConvertFrom-Json
} 

{"index":{"_id":"$csv.result"}}
{"result":"$csv.result","date":"$csv.date","transaction_type":"$csv."transaction type"","payment_type":"$csv."payment type"","payemnt_detail":"$csv."payment detail"","amount":"$csv.amount","last/business_name":"$csv."last/business_name"","report_type":"$csv."report type"","election_name":"$csv."election name"","election_type":"$csv."election type"","municipality":"$csv.municipality","office":"$csv.office","filer_type":"$csv."filer type"","name":"$csv.name","report_year":"$csv."report year"","submitted":"$csv.submitted"}