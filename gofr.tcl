proc gof_ca { } {
set cell {129.00 129.00 129.00} 
set nframes [molinfo top get numframes] 
#set up the atom selections
set sel1 [atomselect top "protein and resid 166 and name CA"]
set sel2 [atomselect top "segname O1 and name C1"]
#calculate g(r)
set gr [measure gofr $sel1 $sel2 delta .1 rmax 60 usepbc 1 selupdate 0 first 0 last [expr {$nframes-1}] step 1] 
#set up the outfile and write out the data
set outfile [open gofr_1.dat w]
set r [lindex $gr 0]
set gr2 [lindex $gr 1]
#set igr [lindex $gr 2]
set i 0
foreach j $r k $gr2  {
puts $outfile "$j $k"
}
close $outfile
}

