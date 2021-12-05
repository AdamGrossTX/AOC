$PuzzleInput = Get-Content -Path .\Day1Input.txt
$Result = for($i = 0; $i -lt $PuzzleInput.Length; $i++) {
    [PSCustomObject]@{
        Number = $PuzzleInput[$i]
        Change = if([int]$PuzzleInput[$i-1] -lt [int]$PuzzleInput[$i]) {"Increased"} elseif([int]$PuzzleInput[$i] -lt [int]$PuzzleInput[$i-1]){"Decreased"} elseif([int]$PuzzleInput[$i] -eq [int]$PuzzleInput[$i-1]) {"No Change"} else {"Unknown"}
        Order = $i+1
    }
}

$Result | Group-Object -Property Change