Class dc.data.rcc.Util [ Abstract ]
{

/// Load & Update  M:N example from Web
/// load user page from Developer Community
ClassMethod Req() As %Net.HttpRequest
{
	set req=##class(%Net.HttpRequest).%New()
		,req.SSLConfiguration="community"
		,req.Https=1
		,req.Port=443
		,req.Server="community.intersystems.com"
		,req.Timeout=90
	quit req
}

/// look for new members
ClassMethod New(
	max = 0,
	from = 0)
{
	if 'from set from=##class(DCmember).maxId()+1
	set to=$s(max:max,1:from+1000)
	if from<to {
		for id=from:1:to {
			set sc=..Load(id)
		    if 'sc zw  s id=id-2 h 3 
		}
	}
	quit
}

/// update existing members
ClassMethod Upd(limit = 0) As %Integer
{
	set id=0
		,upd=0
	for  {
		set id=##class(DCmember).nextId(id)
		quit:'id
		if limit,upd'<limit quit
		set sc=..Load(id)
		if sc,$i(upd) continue
		zw  b
		}	
	quit upd
}

/// load a specific member by ID
ClassMethod Load(id) As %Status
{
		set zh=$zh
			,sc=$$$OK
			,req=..Req()
			,member=##class(DCmember).%OpenId(id)
		if 'member set member=##class(DCmember).%New()
		for retry=1:1:5 {	
			set sc=req.Get("/user/"_id_"/badges")
			quit:sc 
			do $system.OBJ.DisplayError(sc)
			if req.HttpResponse="" {
 				write !,"Timeout! Retry #",retry,!
				continue
			} 
			b  return sc
		}
	
#dim res as %Net.HttpResponse		
		set res=req.HttpResponse
		if 'res do $system.OBJ.DisplayError(sc) quit sc  
		if res.StatusCode-200  {
			write:$x>0 !
			write $zh-zh,?12,"--> memberid: "_id_" --> status: "_res.StatusCode,!
			quit res.StatusCode=404
			}
#dim data as %Stream.FileCharacterGzip		
		set data=res.Data
			,data.LineTerminator=$c(10)
			,(n,b,l)=1
			,ct=0
		for  {
			set lin=data.ReadLine()
			if data.AtEnd quit
			if n,lin["<title>" {
				set name=$p($p(lin,">",2)," badges")
					,member.Name=name
					,member.MbrId=id
					,n=0
				continue	
				}
			if b,lin[">Global Masters badges " {
				set ct=+$p(lin,">Global Masters badges (",2) 
					,b=0
				continue	
				}
			if l,lin["title-level" {
				set lev=$p($p(lin,"span> ",2),"<")
					,member.Level=lev
					,l=0
				
				continue
				}
			if 'ct continue
			if lin["user-badge-block" {
				do badges quit:'sc
				set ct=0 
				}
			}
		set sc=member.%Save()
		if 'sc write !,$system.OBJ.DisplayError(),! b  quit sc
		write " >"_id 
	quit sc

badges
	set sep="<div class=""user-badge-block""><div class=""user-badge-name""  id=""name-user-badge-"
		,blist=$LFS(lin,sep)
		
	for bpos=2:1:ct+1 {
		set bid=+$li(blist,bpos)
			,bname=$p($p($li(blist,bpos),">",2),"<")
			,exbid=member.Badges.Find(bid)
	    if 'exbid do member.Badges.Insert(bid)
		do setbadge
		}
	quit

setbadge
	set badge=##class(GMbadge).%OpenId(bid)
		,sc=$$$OK
	if 'badge {
		set badge=##class(GMbadge).%New()
			,badge.BadgeId=bid
			,badge.Title=bname
		}
	set exmbr=badge.Members.Find(member.MbrId)	
	if 'exmbr set sc=badge.Members.Insert(member.MbrId)
	set sc=badge.%Save()
	if 'sc write $system.OBJ.DisplayError(sc) b 
	quit sc
}

}
