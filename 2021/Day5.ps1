$PuzzleInput = Get-Content -Path .\Day5Input.txt
#Part 1 & Part 2
$Part1 = $True #Change to false for part 2
$Sets = foreach ($CoordSet in $PuzzleInput) {
    [int[]]$Coords = $CoordSet -split ' -> ' -split ","
    if(($Coords[0] -eq $Coords[2] -or $Coords[1] -eq $Coords[3]) -and $Part1) {
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
    $xrange = ($set.x1..$set.x2)
    $yRange = ($set.y1..$set.y2)
   
    if($xrange.Count -gt $yRange.Count) {
        for($i=0;$i -lt $xRange.Count; $i++) {
            $grid[$xrange[$i],$yRange[0]] += 1
       }
    }
    elseif($yRange.Count -gt $xRange.Count) {
        for($i=0;$i -lt $yRange.Count; $i++) {
            $grid[$xrange[0],$yRange[$i]] += 1
        }
    }
    else {
        for($i=0;$i -lt $xRange.Count; $i++) {
            $grid[$xrange[$i],$yRange[$i]] += 1
        }
    }
}

$Grid | where-Object {$_ -gt 1} | Measure-Object | Select-Object -ExpandProperty Count