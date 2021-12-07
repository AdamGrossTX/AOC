[string]$PuzzleInput = Get-Content -Path .\Day7Input.txt
#Part 1
[int[]]$Data = $PuzzleInput -split ","
# sort array
$Data = $Data | Sort-Object
if ($Data.count%2) {
    # if odd
    $medianvalue = $NumberArray[[math]::Floor($Data.count/2)]
}
else {
    # if even
    $MedianValue = ($Data[$Data.Count/2],$Data[$Data.count/2-1] | Measure-Object -Average).average
}

$Fuel = foreach($num in $Data) {
    ([Math]::abs($MedianValue - $Num))
}

$Fuel | Measure-Object -Sum | Select-Object -ExpandProperty Sum

#Part 2
[int[]]$fuelUsed = @()

$Avg = [Math]::Floor(($Data | Measure-Object -AllStats).Average)
foreach($num in $Data) {
    $steps = [Math]::abs($avg-$num)
    $fuelUsed += $steps*($steps+1)/2
}
$fuelUsed | Measure-Object -AllStats

[int[]]$fuelUsed = @()
$Avg = [Math]::Ceiling(($Data | Measure-Object -AllStats).Average)
foreach($num in $Data) {
    $steps = [Math]::abs($avg-$num)
    $fuelUsed += $steps*($steps+1)/2
}
$fuelUsed | Measure-Object -AllStats