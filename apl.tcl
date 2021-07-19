set mol [mol new step6.18.gro type gro]
mol addfile step6.18.xtc type xtc waitfor all
set outfile [open Analysis_CL1.dat w];
puts $outfile "Frame Area per lipid Thickness (N) Thickness (P)"
set nf [molinfo top get numframes]
set sel [atomselect top "resname CL1"]
#set sel1 [atomselect top "resname CAR and name P1"]
#set sel5 [atomselect top "resname CAR and name P2"]
 
for {set i 0 } {$i < $nf } { incr i } {
$sel frame $i
 ## Area per lipid
 set min [lindex [measure minmax $sel] 0]
 set max [lindex [measure minmax $sel] 1]
 set minx "[lindex $min 0]"
 set miny "[lindex $min 1]"
 set maxx "[lindex $max 0]"
 set maxy "[lindex $max 1]"
 set lenght_x [expr $maxx - $minx]
 set lenght_y [expr $maxy - $miny]
 set area_por_lipido [expr ($lenght_x * $lenght_x) / 64]
 puts $outfile "$i $area_por_lipido"
 }
 close $outfile
