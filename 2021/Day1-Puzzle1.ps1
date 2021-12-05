$PuzzleInput = Get-Content -Path .\Day1Input.txt

$Result = for($i = 0; $i -le $PuzzleInput.Length-1; $i++) {
    [PSCustomObject]@{
        Number = $PuzzleInput[$i]
        Change = if($PuzzleInput[$i] -gt $PuzzleInput[$i-1]) {"Increased"} elseif($PuzzleInput[$i] -lt $PuzzleInput[$i-1]){"Decreased"} elseif($PuzzleInput[$i] -eq $PuzzleInput[$i-1]) {"No Change"} else {"Unknown"}
        Order = $i+1
    }
}

$Result | Group-Object -Property Change
