proc center {molid} {
set sel1 [atomselect top "protein and resid 410"]
set sel2 [atomselect top "protein and resid 307"]
set nf [molinfo top get numframes]
set outfile [open dist_410nd307.dat w]
  for {set i 0} {$i<$nf} {incr i} {
puts "frame $i of $nf"
$sel1 frame $i
$sel2 frame $i
set com1 [measure center $sel1 weight mass]
set com2 [measure center $sel2 weight mass]
set simdata($i.r) [veclength [vecsub $com1 $com2]]
puts $outfile "$i $simdata($i.r)"
} 
            set N_d 42
            set r_min $simdata(0.r)
            set r_max $simdata(0.r)
          for {set i 0} {$i < $nf} {incr i} {
            set r_tmp $simdata($i.r)
            if {$r_tmp < $r_min} {set r_min $r_tmp}
           if {$r_tmp > $r_max} {set r_max $r_tmp}
           }
            set dr [expr ($r_max - $r_min)/($N_d - 1)]
            for {set k 0} {$k < $N_d} {incr k} {
            set distribution($k) 0
               }
            for {set i 0} {$i < $nf} {incr i} {
            set k [expr int(($simdata($i.r) - $r_min) / $dr)]
            incr distribution($k)
               }
             set outfile [open out307nd410.dat w]
             for {set k 0} {$k < $N_d} {incr k} {
             puts $outfile "[expr $r_min + $k * $dr] $distribution($k)"
             }

close $outfile
}
 
