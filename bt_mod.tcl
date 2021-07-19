#measure bilayer thickness

mol new step6.18.gro type gro
mol addfile step6.18.xtc first 0 last 200 waitfor all


set nf [molinfo top get numframes]


set sum_ibt 0
set out [open "bilayer.dat" w+]

for { set i 0 } { $i < $nf } { incr i } {
set all [atomselect top "all" frame $i]
set lip [atomselect top "resname CL1" frame $i]
$all moveby [vecinvert [measure center $lip]]
set ptop [atomselect top "name P1 and z > 0" frame $i]
set pbot [atomselect top "name P1 and z < 0" frame $i]
set sumztop 0
set sumzbot 0

#for upper monolayer
set count 0
foreach ztop [$ptop get z] {
set sumztop [expr $ztop + $sumztop]
incr count
}
set avgztop [expr $sumztop / $count ]
#done

#for bottom layer
set count 0
foreach zbot [$pbot get z] {
set sumzbot [expr $zbot + $sumzbot]
incr count
}
set avgzbot [expr $sumzbot / $count ]
#done

set ibt [expr abs($avgztop) + abs($avgzbot)]
set sum_ibt [expr $ibt + $sum_ibt]


puts $out "$i $ibt"

$ptop delete
$pbot delete

}
close $out
exit
