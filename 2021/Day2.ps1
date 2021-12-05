[string[]]$PuzzleInput = Get-Content -Path .\Day2Input.txt

#Part 1
[int]$Depth      = 0
[int]$Horizontal = 0

foreach($Direction in $PuzzleInput) {
    $Parts = $Direction.Trim().Split(" ")
    switch($Parts[0]) {
        "down"    {$Depth      += $Parts[1];break;}
        "up"      {$Depth      -= $Parts[1];break;}
        "forward" {$Horizontal += $Parts[1];break;}
    }
}
$Part1Result = $Depth * $Horizontal
$Part1Result

#Part 2
[int]$Aim        = 0
[int]$Horizontal = 0
[int]$Depth      = 0

foreach($Direction in $PuzzleInput) {
    $Parts = $Direction.Trim().Split(" ")
    switch($Parts[0]) {
        "down"    {$Aim         += $Parts[1];break;}
        "up"      {$Aim         -= $Parts[1];break;}
        "forward" {
                    $Horizontal += $Parts[1]
                    $Depth      += $Aim * $Parts[1]
                    break
                    }
    }
}

$Part2Result = $Depth * $Horizontal
$Part2Result