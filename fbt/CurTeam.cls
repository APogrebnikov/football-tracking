Class fbt.CurTeam Extends (%Persistent, %Populate)
{
	Relationship Team as fbt.Team [Cardinality = one, Inverse = CurTeams];
	Property Players as list of fbt.Player;
		
	// (POPSPEC = ".PopCTeam()")
	ClassMethod PopCTeam(team as fbt.Team )
	{
		s sc = $$$OK
		s curTeam =  ##class(fbt.CurTeam).%New()
		s curTeam.Team = team
		s teamList = ##class(%ListOfObjects).%New()
		s sc = ..SetPlayers(1,"Goalkeeper", team.%Id(), .teamList)
		w "next"
		s sc = ..SetPlayers(5,"Defender", team.%Id(), .teamList)
		s sc = ..SetPlayers(3,"Midfielder", team.%Id(), .teamList)
		s sc = ..SetPlayers(2,"Forward", team.%Id(), .teamList)
		
		s curTeam.Players = teamList
		s sc = curTeam.%Save()
		q curTeam.%Id()
	}
	
	ClassMethod SetPlayers(
		count as %Integer, 
		role as %String,
		team as %String,
		Output teamList as %ListOfObjects
	) As %Status {
		s sc = $$$OK
		q:('$IsObject(##class(fbt.Role).IRoleNameOpen(role))) $$$ERROR($$$GeneralError,"роль не найдена")
		// поиск доступных дл€ выбора игроков
		s sql = "SELECT ID FROM fbt.Player WHERE (Team -> ID = ?) AND (""role""->roleName = ?)" 
		kill sqlp
		s sqlp($I(sqlp))= team
		s sqlp($I(sqlp))= role
		s statement = ##class(%SQL.Statement).%New()
		s sc = statement.%Prepare(sql)
		s rset=statement.%Execute(sqlp...)
		// q:стаус (?)
		s pCount = 0	
		s playersList = ##class(%ListOfObjects).%New()
		while (rset.%Next())
		{
			do playersList.Insert(##class("fbt.Player").%OpenId(rset.%Get("ID")))
			s pCount = pCount +1
		}
		q:(pCount < count) $$$ERROR($$$GeneralError,"¬ сборной недостаточно игроков с ролью "_role_" дл€ составлени€ команды на игру.")
		for i = 1:1:count {
			s rand = 0
			do {
				s rand = $R(pCount) +1
			} while ('$IsObject(playersList.GetAt(rand)))
			s sc = teamList.Insert(playersList.GetAt(rand))
			s sc = playersList.RemoveAt(rand)
	
		}
	
		q sc
	}
	
	// ћетоды дл€ пасов
	/// ¬ычисление индекса дл€ паса
	ClassMethod PassIndex(pass as fbt.Pass, field as fbt.Field) 
	{			
		// x1 As %Decimal , y1 As %Decimal, x2 As %Decimal, y2 As %Decimal
		
		s x0 = field.center.lat
		s y0 = field.center.lon
		s lsx = field.segLenX
		s lsy = field.segLenY
		
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
	/// ¬ычисление индекса дл€ окружности
	ClassMethod CircleIndex(radius, centerX,centerY, field as fbt.Field) {
		s minX = $Double($Piece((centerX - radius) / field.segLenX,".",1))
		s maxX = $Double($Piece((centerX + radius) / field.segLenX,".",1))
		s minY = $Double($Piece((centerY - radius) / field.segLenY,".",1))
		s minX = $Double($Piece((centerY + radius) / field.segLenY,".",1))
			 
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
	/// ѕолучение списка пасов, с учЄтом индекса
	ClassMethod GetPassList(radius, centerX,centerY) {
		s circleIndex = ..CircleIndex(radius, centerX,centerY)
		
		////////////////////////
		s sql = "SELECT ID FROM fbt.Pass WHERE "
		
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
	ClassMethod GetIndexMask(index) {
		s index = ##class(fbt.Index).%New()
		s index.part1 = ..BinToDec(1,index)
		s index.part2 = ..BinToDec(2,index)
		q index
	}
	
	ClassMethod BinToDec(part, index){
		s len = 50
		s start = 1 + (len * (part-1))
		s end = len + (len * (part-1))
		
		s int = 0
		for i = start:1:end {
			s int = int + ($Bit(index,i) * $ZPOWER(2,( i-(len*(part-1)) ) ))
		}
		q int
	}
	
	

	
	
	/// ѕолучение сектора м€ча
	ClassMethod GetSector(field as fbt.Field, pass)
	{	
		s z = $Case(1,	((x > field.center.lat) && ((y > field.r4.lon)||(y > field.r5.lon))):"right_0", // в зоне ворот
						(x > field.center.lat):"right_1",
						((x <= field.center.lat) && ((y > field.l4.lon)||(y > field.l5.lon))):"left_0", // в зоне ворот 
						(x <= Field.center.lat):"left_1",
						:"center")
		// left - host
		// right - guest
		
		
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