Class dc.rcc.ePYvsISOS
{

ClassMethod do()
{
	set ^run=0
	kill ^ePy,^ISOS
	job ..setISOS()::5 
	write !,"JobStart ISOS "_$s($t:"#"_$ZC,1:"failed")
	job ..jobPy()::5
	write !,"JobStart  ePy "_$s($t:"#"_$ZC,1:"failed")

	for  {
		write !,"Job Control [0=stop,1=view,2=go]: "
		read ctrl#1:15
		if '$t||("012"'[ctrl) {
			if $i(f)<4 continue
			else  set ctrl=1
			}	
		set ^run=ctrl-1,f=0 continue:^run>0
		hang 1 
		if $d(^ePy),$d(^ePy(^ePy),s),$d(^ePy(^ePy,s),v) write !,$zr,"=",v,!
		if $d(^ISOS),$d(^ISOS(^ISOS),s),$d(^ISOS(^ISOS,s),v) write $zr,"=",v,!
		quit:'ctrl 
	}
}

ClassMethod jobPy()
{
	do ..setPy()
}

ClassMethod setPy() [ Language = python ]
{
import iris, datetime, time

grun = iris.gref("^run")
gePy = iris.gref("^ePy")

def wait():
	while True:
		run=grun[None]
		if run==0:
			time.sleep(1)
			continue
		else:
			break
	return run

sub1=0
while True:
	if wait()<0:
		break

	sub1 += 1
	gePy[None]=sub1
	sub2 = 0
	while True:
		sub2 += 1
		gePy[sub1]=sub2
		zdt3=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')
		gePy[sub1,sub2]=zdt3
#		time.sleep(0.5)		
		if grun[None]<1:
			break
}

ClassMethod setISOS()
{
	for  {
		quit:$$wait()<0
		set sub1=$I(^ISOS)
		for {
			set ^ISOS(sub1,$I(^ISOS(sub1)))=$ZDT($NOW(),3,,6)
			quit:$g(^run)<1
#;			hang 0.5
			}
		}	

wait()
	for  set run=$g(^run) quit:run  hang 1 
	quit run
}

}

