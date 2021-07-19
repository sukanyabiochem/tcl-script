package require pbctools
if {$::argc>0} {
    set psfnm [lindex $::argv 0]
    set fname [lindex $::argv 1]
	set rep   [lindex $::argv 2]
    }
mol new $psfnm
mol addfile $fname waitfor all
set totlfr [molinfo 0 get numframes]

translate by 0 -0.5 0   
rotate z by -45
rotate x by 180
rotate x by -55
scale by 3
color change rgb 0 0 0.25 0.9

display ambientocclusion on
display aoambient 0.8
display aodirect 0.4
display shadows on
display cuedensity 0.1
display projection orthographic
display resize 704 480

mol modselect 0 0 segname MEMB and resid 1 to 340 and noh
mol modstyle 0 0  "Licorice"
mol modcolor 0 0 "ColorID" 2

mol addrep 0
mol modselect 1 0 segname MEMB and resid 341 to 670 and noh and resname POPC
mol modstyle  1 0 "Licorice"
mol modcolor  1 0 "ColorID" 2


mol addrep 0
mol modselect 2 0 segname MEMB and resid 341 to 670 and noh and resname POPG
mol modstyle  2 0 "Licorice"
mol modcolor  2 0 "ColorID" 3

mol addrep 0 
mol modselect 3 0 protein 
mol modstyle  3 0 "NewCartoon"
mol modcolor  3 0 "ColorID" 8


mol addrep 0 
mol modselect 4 0 protein and resname ARG LYS ASP GLU and not backbone and noh
mol modstyle  4 0 "VDW"
mol modcolor  4 0 "Name" 

mol modmaterial 0 0 "Transparent"
mol modmaterial 1 0 "AOChalky"
mol modmaterial 2 0 "AOChalky"
mol modmaterial 3 0 "AOChalky"
mol modmaterial 4 0 "AOChalky"

mol smoothrep 0 0 2
mol smoothrep 0 1 2
mol smoothrep 0 2 2
mol smoothrep 0 3 2
mol smoothrep 0 4 2

for {set i 0 } {$i<$totlfr} {incr i } {
	animate goto $i
	render TachyonInternal $i.ppm

	}
