[int[]]$PuzzleInput = Get-Content -Path .\Day1Input.txt

#Part 1
$Part1Result = for($i = 0; $i -lt $PuzzleInput.Length; $i++) {
    $Change = 
        if($PuzzleInput[$i] -gt $PuzzleInput[$i-1]) {
            "Increased"
        } 
        elseif($PuzzleInput[$i] -lt $PuzzleInput[$i-1]) {
            "Decreased"
        } 
        elseif($PuzzleInput[$i] -eq $PuzzleInput[$i-1]) {
            "No Change"
        } 
        else {
            "Unknown"
        }
    [PSCustomObject]@{
        Number = $PuzzleInput[$i]
        Change = $Change 
        Order = $i+1
    }
}
$Part1Result | Group-Object -Property Change | Where-Object {$_.Name -eq "Increased"} | Select-Object -ExpandProperty Count

#Part 2
$Part2Result = @()
for($i = 0; $i -lt $PuzzleInput.Length-2; $i++) {
    $CurrentGroupTotal = $PuzzleInput[$i] + $PuzzleInput[$i+1] + $PuzzleInput[$i+2]
    $Change = 
        if($CurrentGroupTotal -gt $Part2Result[$i-1].Total) {
            "Increased"
        } 
        elseif($CurrentGroupTotal -lt $Part2Result[$i-1].Total) {
            "Decreased"
        } 
        elseif($CurrentGroupTotal -eq $Part2Result[$i-1].Total) {
            "No Change"
        } 
        else {
            "Unknown"
        }
        $Part2Result +=
            [PSCustomObject]@{
                Group = $i
                Total = $CurrentGroupTotal
                Change = $Change
            }
}

$Part2Result[1..$i] | Group-Object -Property Change | Where-Object {$_.Name -eq "Increased"} | Select-Object -ExpandProperty Count