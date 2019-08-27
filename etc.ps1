for ($i=0; $i -gt -1; $i++){
    if($i % 2 -eq 0){
        write-host "Task Failed Successfully" -foregroundcolor Red
    }else{
        write-host "Task Succeeded in Failure" -foregroundcolor Green
    }
}

for ($i=0; $i -gt -1; $i++){
    if($i % 2 -eq 0){
        write-host "Task Failed Successfully" -foregroundcolor Blue
    }else{
        write-host "Task Succeeded in Failure" -foregroundcolor Yellow
    }
}

while($true){
    $limit = Get-Random -Minimum 5 -Maximum 100
    $outString = ""
    for($i=0; $i -lt $limit; $i++){
        $randChar = Get-Random -Minimum 33 -Maximum 126
        $outString = $outString + [char]$randChar
    }
    write-host $outString -foregroundcolor ($limit % 16)
    $randSleep = Get-Random -Maximum 100
    start-sleep -Milliseconds $randSleep
}


while($true){
    $limit = Get-Random -Minimum 5 -Maximum 100
    $outString = ""
    for($i=0; $i -lt $limit; $i++){
        $randChar = Get-Random -Minimum 33 -Maximum 126
        $outString = $outString + [char]$randChar
    }
    write-host $outString -foregroundcolor (($limit % 8) + 8) -backgroundcolor (Get-Random -Maximum 8)
    $randSleep = Get-Random -Maximum 100
    start-sleep -Milliseconds $randSleep
}

#1337 H4X0R
function pause {
    param($l)
    Start-Sleep -Milliseconds $l 
}

function print-hack {
    write-host ""
    write-host "HACKING IN PROGRESS" -ForegroundColor Red
    write-host "[" -NoNewline
    for($i=0; $i -lt 50; $i++){
        write-host -NoNewline "-"
        pause -l 100
    }
    write-host "]"
    start-sleep 1
    write-host "YOU HAVE BEEN HAXED BY THE L33T H@X0R!"
    start-sleep 1
    write-host "ALL YOUR BASE ARE BELONG TO US!"
    write-host ""
    
    start-sleep 2
}

while($true){
    $limit = Get-Random -Minimum 5 -Maximum 100
    $outString = ""
    for($i=0; $i -lt $limit; $i++){
        $randChar = Get-Random -Minimum 33 -Maximum 126
        $outString = $outString + [char]$randChar
    }
    write-host $outString -foregroundcolor (($limit % 8) + 8) -backgroundcolor (Get-Random -Minimum 0 -Maximum 8)
    pause -l (Get-Random -Maximum 100)

    if((Get-Random -Minimum 0 -Maximum 1001) -lt 10){
        print-hack
    }

    
}

#==========================================
#I can't belive its not butter!!
while($true){
    cls
    Write-Host "I can't believe its not butter"
    Start-Sleep -Milliseconds 10
}

#input?
while($true){
    $key = [console]::ReadKey()
    Write-Host $key.KeyChar
}

