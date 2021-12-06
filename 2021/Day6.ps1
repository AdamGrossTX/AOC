[string]$PuzzleInput = Get-Content -Path .\Day6Input.txt
#Part 1
[int[]]$Data = $PuzzleInput -split ","

$Days = 255
for($day = 0; $day -le $days; $day++) {
    $NewData = [System.Collections.ArrayList]@()
    foreach($value in $data) {
        switch($value) {
            0 {
                $NewData.Add(6) | Out-Null
                $NewData.Add(8) | Out-Null
                break;
            }
            default {$NewData.Add(($value - 1)) | Out-Null; break;}
        }
    }
    $Data = $NewData
}

$Data.Count

#Part 2
$Days = 255
$Fish = @{}
for([int]$i=0;$i -lt 8; $i++) {
    $fish[$i] = switch($i) {
        default {0}
    }
}

$Data | Group-Object | ForEach-Object {$Fish[[int]$_.Name] = [int]$_.Count}
for($day = 0; $day -le $days; $day++) {
    $NewFish = 0
    $NewFish = $Fish[0]
    for($i=0;$i -le 8; $i++) {
        $fish[$i] = switch($i) {
            6 {$Fish[7] + $NewFish; break;}
            8 {$NewFish; break;}
            default {$Fish[($i+1)]; break;}
        }
    }
}

$Fish.Values | Measure-Object -Sum
