$existing = 'srv1','srv2','srv3','srv4','srv5','srv6','srv7'

$cand = 0
do {
        $cand++
        $poss = "srv$cand"
   } while ($existing.Contains($poss))
   $poss
