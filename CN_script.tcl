proc gof_ca { } {
set cell {108.00 108.00 108.00} 
set nframes [molinfo top get numframes] 
#set up the atom selections
set sel1 [atomselect top "protein and resid 166 and name OE1"]
set sel2 [atomselect top "resname TIP3 and name OH2"]
#calculate g(r)
set gr [measure gofr $sel1 $sel2 delta .1 rmax 20 usepbc 1 selupdate 1 first 0 last [expr {$nframes-1}] step 1] 
#set up the outfile and write out the data
set outfile [open CN_active_site_166_water.dat w]
set r [lindex $gr 0]
set gr2 [lindex $gr 1]
set igr [lindex $gr 2]
set i 0
foreach j $r l $igr {
puts $outfile "$j $l"
}
close $outfile
}

