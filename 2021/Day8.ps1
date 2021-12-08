[string[]]$PuzzleInput = Get-Content -Path .\Day8Input.txt
#Part 1
<#
$unique = @(2,4,3,7)
$CountItems = foreach($row in $PuzzleInput) {
    [string]$usp,[string]$fdov = $row.split("|").trim()
    $fdov.split(" ").trim() | ForEach-Object {$_.Length} | Where-Object {$_ -in $unique}
}

$CountItems.count
#>
#Part 2

$CountUnique = @{
    2 = 1
    4 = 4
    3 = 7
    7 = 8
}

$results = foreach($row in $PuzzleInput) {
    [string]$usp,[string]$fdov = $row.split("|").trim()
    
    $f = @{}
    $t = [System.Collections.ArrayList]::new()
    $items = New-Object -TypeName System.Collections.ArrayList
    $items = $usp.split(" ").trim()

    foreach($item in $items) {
        $chars = $item.ToCharArray() | Sort-Object
        $obj = [PSCustomObject]@{
            Value  = $Chars -join ''
            CLen   = $Chars.Count
            Chars  = $Chars
        }
        if($chars.Count -in $CountUnique.keys) {
            $f[$CountUnique[($Chars.Count)]] = $obj           
        }
        else {
            $t.add($obj) | Out-Null
        }
    }

    $d = @{}
    $i = 1
    $digits = $fdov.split(" ").trim()
    foreach($digit in $digits) {
        $chars = $digit.ToCharArray() | Sort-Object
        $obj = [PSCustomObject]@{
            Value  = $Chars -join ''
            Chars  = $Chars
        }
        $d[$i++] = $obj
    }

    $f[6]  = $t | Where-Object {$_.CLen -eq 6 -and ($_.Chars | ForEach-Object {$_ | Where-Object {$f[1].Chars -Contains $_}}).Count -eq 1}
    $t.Remove($f[6])
    $f[9] = $t | Where-Object {$_.CLen -eq 6 -and ($_.Chars | ForEach-Object {$_ | Where-Object {$f[4].Chars -Contains $_}}).Count -eq 4}
    $t.Remove($f[9])
    $f[0] = $t | Where-Object {$_.CLen -eq 6}
    $t.Remove($f[0])
    $f[3]  = $t | Where-Object {$_.CLen -eq 5 -and ($_.Chars | ForEach-Object {$_ | Where-Object {$f[1].Chars -Contains $_}}).Count -eq 2}
    $t.Remove($f[3])
    $f[2]  = $t | Where-Object {$_.CLen -eq 5 -and ($_.Chars | ForEach-Object {$_ | Where-Object {$f[4].Chars -Contains $_}}).Count -eq 2}
    $t.Remove($f[2])
    $f[5]  = $t | Where-Object {$_.CLen -eq 5 -and ($_.Chars | ForEach-Object {$_ | Where-Object {$f[4].Chars -Contains $_}}).Count -eq 3}
    $t.Remove($f[5])

    $resultset = @{}

    for($i=1; $i -le $d.count+1; $i++) {
        foreach($key in $f.keys) {
            if($d[$i].Value -eq $f[$key].value) {
                $resultset[$i] = $key
            }
        }
    }

    $resultset.value = [int]::parse(@($resultset[1],$resultset[2],$resultset[3],$resultset[4])-join'')
    $resultset
}
$Results.Value | forEach-Object {$sum +=$_}
$sum