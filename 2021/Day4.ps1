$PuzzleInput = Get-Content -Path .\Day4Input.txt

#Part 1
$letters = ("B","I","N","G","O")

$b = 0
$Balls = @{}
$PuzzleInput[0] -split ',' | ForEach-Object {$Balls[$b] = $_; $b++}

$cardNum = 0

$cards = @{}
for($c = 2; $c -lt $PuzzleInput.Count;$c++) {
    $r=0
    $Cards[$CardNum] = do {
        foreach($row in $PuzzleInput[$c]) {
            [int]$B,[int]$I,[int]$N,[int]$G,[int]$O = ($row.trim() -replace "  ", " " -split (" ","  "))
            $r++
            [PSCustomObject]@{
                #card = $CardNum
                #row = $r
                B = $B
                I = $I
                N = $N
                G = $G
                O = $O
            }
        }
        $c++
    } until ($PuzzleInput[$c] -eq "" -or $c -eq $PuzzleInput.count)
    $CardNum++
}
<#
foreach($key in $Cards.keys) {
    "Card: $Key"
    $Cards[$key] | Format-Table -AutoSize
}
#>
$WinningCard = $null
$LastBall = $null

$Winner = $False
    for($i=0; -not $Winner -and $i -lt $Balls.Count; $i++) {
        $LastBall = $Balls[$i]
        Write-Output "                Called : $($LastBall)"

        foreach($key in $Cards.keys) {
            if($Cards[$key] -match "\b$($Balls[$i])\b") {
                foreach($letter in $letters) {
                    $cards[$key] | Where-Object {$_.$letter -eq $Balls[$i]} | ForEach-Object {$_.$Letter = "X"}
                }
            }
        }

        foreach($key in $Cards.keys) {
            foreach($letter in $letters) {
                if(($cards[$key] | Where-Object {$_.$letter -eq "X"} | Measure-Object).Count -eq 5) {
                    $Winner = $True
                    $WinningCard = $Cards[$key]
                    $WinningCardNum = $Key
                }
            }

            foreach($row in $cards[$key]){
                $count=0
                foreach($letter in $letters) {
                    if($row | Where-Object {$_.$letter -eq "X"}) {
                        $count++
                    }      
                }
                if($count -eq 5) {
                    $Winner = $True
                    $WinningCard = $Cards[$key]
                    $WinningCardNum = $Key
                }

            }
        }
    }


if($WinningCard) {
    $Total = 0
    Foreach ($Letter in $Letters) {
        $WinningCard.$Letter | Where-Object {$_ -ne "X"} | ForEach-Object {$Total += $_}
    }
    $Total 
    $LastBall
    $Total * $LastBall

    Write-Host "Winning Card: $($WinningCardNum)"
    $WinningCard | Format-Table -AutoSize
    
}




#$Cards | Format-Table -AutoSize -GroupBy Card

#>