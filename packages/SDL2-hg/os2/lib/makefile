all: pmgre.lib

pmgre.lib: pmgre.exp
	wlib -q -b -n -c -pa -s -t -zld -ii -io pmgre.lib @pmgre.exp

pmgre.exp: pmgre.def def2lbc.sed
	sed -f def2lbc.sed pmgre.def > pmgre.exp

clean: .symbolic
	rm -f pmgre.exp pmgre.lib
