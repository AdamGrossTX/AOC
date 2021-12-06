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

[int]$MaxX = ($Sets.x1 + $Sets.x2 | Measure-Object -Maximum).Maximum
[int]$MaxY = ($Sets.y1 + $Sets.y2 | Measure-Object -Maximum).Maximum

$grid = New-Object 'object[,]' ($MaxX+1),($MaxY+1)

foreach($set in $sets) {
    foreach($x in ($set.x1..$set.x2)) {
        foreach($y in ($set.y1..$set.y2)) {
            $grid[$x,$y] += 1
        }
    }
}
$Grid | where-Object {$_ -gt 1} | Measure-Object | Select-Object -ExpandProperty Count