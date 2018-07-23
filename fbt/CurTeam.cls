Class fbt.CurTeam Extends (%Persistent, %Populate)
{
	Relationship Team as fbt.Team [Cardinality = one, Inverse = CurTeam];
	Property Players as list of fbt.Player (POPSPEC = ".PopCTeam()");
		
	
	Method PopCTeam()
	{
		s sc = $$$OK
		
		s teamList = ##class(%ListOfObjects).%New()
		s sc = ..SetPlayers(1,"Goalkeeper", ..Team,teamList)
		s sc = ..SetPlayers(5,"Defender", ..Team,teamList)
		s sc = ..SetPlayers(3,"Midfielder", ..Team,teamList)
		s sc = ..SetPlayers(2,"Forward", ..Team,teamList)
		
		r teamList
	}
	
	ClassMethod SetPlayers(
		count as %Integer, 
		role as %String,
		team as %String,
		Output teamList as %ListOfObjects
	) As %Status {
		s sc = $$$OK
		q:($IsObject(##class(fbt.Role).IRoleNameOpen(role)))
		// поиск доступных для выбора игроков
		s sql = "SELECT ID FROM fbt.Player WHERE Team = ? AND Role -> Name = ?" 
		
		kill sqlp
		s sqlp($I(sqlp))= team
		s sqlp($I(sqlp))= role
		s rset=##class(%SQL.Statement).%ExecDirect(,sql,sqlp...)
		
		// q:стаус (?)
		s pCount = rset.%ROWCOUNT
		q:(pCount<count) "В сборной недостаточно игроков с ролью "_role_" для составления команды на игру."
		
		s playersList = ##class(%ListOfObject).%New()
		
		while (rset.%Next())
		{
			do playersList.Insert(##class("fbt.Player").%OpenId(rset.%Get("ID")))
		}
		for i = 1:1:count {
			s rand = $R(pCount)+1
			s sc = teamList.Insert(playersList.GetAt(rand))
			s sc = playersList.RemoveAt(rand)
		}
	
		r sc
	}
	
		ClassMethod PassIndex(x1 As %Decimal , y1 As %Decimal, x2 As %Decimal, y2 As %Decimal) 
	{			
		
		
		///////////////////
		s x0 = 0
		s y0 = 0
		s lsx = 10
		s lsy = 10
		///////////////////
		
		s x1 = $Double($Piece((x1 - x0) / lsx,".",1))
		s x2 = $Double($Piece((x2 - x0) / lsx,".",1))
		s y1 = $Double($Piece((y1 - y0) / lsy,".",1))
		s y2 = $Double($Piece((y2 - y0) / lsy,".",1))
		
		if (x1 < x2) {	s minX = x1	s maxX = x2}
		else {			s minX = x2	s maxX = x1}
		
		if (y1 < y2) { 	s minX = y1	s maxX = y2}
		else { 			s minX = y2	s maxX = y1}
		
		q ..GetIndex(minX, maxX, minY, maxY)
	}
	
	ClassMethod CircleIndex(radius, centerX,centerY) {
		s minX = $Double($Piece((centerX - radius) / lsx,".",1))
		s maxX = $Double($Piece((centerX + radius) / lsx,".",1))
		s minY = $Double($Piece((centerY - radius) / lsy,".",1))
		s minX = $Double($Piece((centerY + radius) / lsy,".",1))
			 
		q ..GetIndex(minX, maxX, minY, maxY)
	}

	ClassMethod GetIndex(minX, maxX, minY, maxY) {
		s index = $ZBitStr(100,0)
		s index = $SYSTEM.Bit.ZBitToBit(index)
		
		for i = minY,1,maxY {
			for j = minX,1,maxX {
				s $BIT(index,((i*10)+j+1)) = 1
			}
		}
		q index
	}	
	
	ClassMethod GetPassList(radius, centerX,centerY) {
		s circleIndex = ..CircleIndex(radius, centerX,centerY)
		////////////////////////
		s sql = "SELECT ID FROM ..."
		
		kill sqlp
		s sqlp($I(sqlp))= ""
		
		s rset=##class(%SQL.Statement).%ExecDirect(,sql,sqlp...)
		
		// q:стаус (?)
		s passList = ##class(%ListOfObject).%New()
		
		while (rset.%Next())
		{
			do passList.Insert(##class("fbt.Pass").%OpenId(rset.%Get("ID")))
		}
		
	
	}
Storage Default
{
<Data name="CurTeamDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Team</Value>
</Value>
<Value name="3">
<Value>Players</Value>
</Value>
</Data>
<DataLocation>^fbt.CurTeamD</DataLocation>
<DefaultData>CurTeamDefaultData</DefaultData>
<IdLocation>^fbt.CurTeamD</IdLocation>
<IndexLocation>^fbt.CurTeamI</IndexLocation>
<StreamLocation>^fbt.CurTeamS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}