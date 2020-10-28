$Folder = "C:\Users\crpm7\logs"

$date = Get-Date -format "yyyy-MM-dd"

#Delete files older than 1 month (not recuesive)
Get-ChildItem $Folder -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-30)} |
ForEach-Object {
   $_ | del -Force
   $linea = $date+" "+$_.FullName
   write-host $linea
   $linea | Out-File C:\Users\crpm7\deletedlog.txt -Append
}