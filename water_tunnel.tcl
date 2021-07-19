proc get_wat {{molid top} {start 0}} {

 set nf [molinfo $molid get numframes]

 set out [open "wat.dat" w]

 for {set i 0} {$i < $nf} {incr i} {

 set up [atomselect $molid "protein and resid 410 and noh" frame $i]
 set lw  [atomselect $molid "protein and resid 354 and noh" frame $i]
 set uz [lindex [lindex [measure minmax $up] 1] 2]
 set lz [lindex [lindex [measure minmax $lw] 0] 2]
 set all [atomselect $molid "protein and noh" frame $i]
set com [measure center $all weight mass]
set xc [lindex $com 0]
set yc [lindex $com 1]
set sel [atomselect $molid "name OH2 and (sqr (x-$xc)+ sqr (y-$yc)) < sqr (14) and z < $uz and z > $lz" frame $i]
puts $out "[expr $i + $start] [expr [$sel num]]"
}

close $out

}
