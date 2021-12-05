[string[]]$PuzzleInput = Get-Content -Path .\Day3Input.txt
#Part 1

$TotalRecords = $PuzzleInput.Length
$Columns = @{}
foreach ($number in $PuzzleInput) {
    $Bytes = $number -Split('') | Where-Object {$_ -ne ""}
    for($i=0;$i -lt $number.Length;$i++) {
        $Columns[$i+1] += @($Bytes[$i])
    }
}

[string]$Gamma = $null
[string]$Epsilon = $null
foreach($Key in ($Columns.Keys | Sort-Object $_)) {
    $Gamma += ($Columns[$Key] | Group-Object | Sort-Object Count -Descending | Select-Object -First 1 -ExpandProperty Name)
    $Epsilon += ($Columns[$Key] | Group-Object | Sort-Object Count | Select-Object -First 1 -ExpandProperty Name)
}

$Part1Result = [Convert]::ToInt32($Gamma,2) * [Convert]::ToInt32($Epsilon,2)
$Part1Result

<#
Part 1 Alternate

$Records = 
    foreach ($number in $PuzzleInput) {
        $Bytes = $number -Split('') | Where-Object {$_ -ne ""}
        $Obj = [PSCustomObject]@{
            BinaryValue = $Number
        }
        for($i=0;$i -lt $number.Length;$i++) {
            $obj | Add-Member -MemberType NoteProperty -Name ($i+1) -Value $Bytes[$i]
        }
        $obj
    }

[string]$Gamma = $null
[string]$Epsilon = $null


for($i=1;$i -le $PuzzleInput.Length;$i++) {
    $Gamma += ($Records.$i | Group-Object | Sort-Object Count -Descending | Select-Object -First 1 -ExpandProperty Name)
    $Epsilon += ($Records.$i | Group-Object | Sort-Object Count | Select-Object -First 1 -ExpandProperty Name)
}

$Part1Result = [Convert]::ToInt32($Gamma,2) * [Convert]::ToInt32($Epsilon,2)
$Part1Result
#>

#Part 2
$Records = 
    foreach ($number in $PuzzleInput) {
        $Bytes = $number -Split('') | Where-Object {$_ -ne ""}
        $Obj = [PSCustomObject]@{
            BinaryValue = $Number
        }
        for($i=0;$i -lt $number.Length;$i++) {
            $obj | Add-Member -MemberType NoteProperty -Name $i -Value $Bytes[$i]
        }
        $obj
    }

[string]$Gamma = $null
[string]$Epsilon = $null


for($i=0;$i -le 12;$i++) {
    if($i -eq 0) {
        $Gamma   += ($Records.$i | Group-Object | Sort-Object Count,Name -Descending | Select-Object -First 1 -ExpandProperty Name)
        $Epsilon += ($Records.$i | Group-Object | Sort-Object Count,Name | Select-Object -First 1 -ExpandProperty Name)
    }
    else {
        $Gamma   += ($Records | Where-Object {$_.BinaryValue -like "$($Gamma)*"}).$i | Group-Object | Sort-Object Count,Name -Descending | Select-Object -First 1 -ExpandProperty Name
        $Epsilon += ($Records | Where-Object {$_.BinaryValue -like "$($Epsilon)*"}).$i | Group-Object | Sort-Object Count,Name | Select-Object -First 1 -ExpandProperty Name
    }
}
$Part2Result = [Convert]::ToInt32($Gamma,2) * [Convert]::ToInt32($Epsilon,2)
$Part2Result