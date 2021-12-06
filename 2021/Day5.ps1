$PuzzleInput = Get-Content -Path .\Day5Input.txt
#Part 1
$Sets = foreach ($CoordSet in $PuzzleInput) {
    [int[]]$Coords = $CoordSet -split ' -> ' -split ","
    if($Coords[0] -eq $Coords[2] -or $Coords[1] -eq $Coords[3]) {
        [PSCustomObject]@{
            Set    = $Coords
            x1     = $Coords[0]
            y1     = $Coords[1]
            x2     = $Coords[2]
            y2     = $Coords[3]
        }
    }
}

$grid = New-Object -TypeName System.Collections.ArrayList

foreach($set in $sets) {
    foreach($x in ($set.x1..$set.x2)) {
        foreach($y in ($set.y1..$set.y2)) {
            $existing = $grid | where-object {$_.x -eq $x -and $_.y -eq $y}
            if($existing) {
                $grid[$grid.IndexOf($existing)].hits += 1
            }
            else {
                $grid.add([PSCustomObject]@{
                    x    = $x
                    y    = $y
                    hits = 1
                }) | Out-Null
            }
        }
    }
}
$Grid | where-Object hits -gt 1 | Measure-Object | Select-Object -ExpandProperty Count