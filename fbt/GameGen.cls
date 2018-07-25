Class fbt.GameGen Extends %Persistent
{
	Property field As fbt.Field;
	
	/// The method generates the game
	Method stepGen(rad As %Decimal = 50, pass As fbt.Pass, curGame As fbt.Game) As fbt.Pass{
		#dim curPass As fbt.Pass
		s curPass = ##class(fbt.Pass).%New()
		s curPass.match = curGame
		s curPass.startTime = pass.startTime + pass.duration
		if (pass.inField){
			s start = pass.vecEnd
			s curPass.vecStart = pass.vecEnd  
			s curPass.fromPlayer = pass.toPlayer
			s end = ..vecGen(rad, ..field, pass)
		} else {
			s start = pass.vecEnd
			s curPass.vecStart = pass.vecEnd  
			s curPass.fromPlayer = pass.toPlayer
			//zw pass.sector_" sec"
			s end =  $CASE(pass.sector,1: ##class(fbt.Point).Construct($R(10),$R(10) - 5),2:##class(fbt.Point).Construct(..field.widths - 10 + $R(10),$R(10)), 3: ##class(fbt.Point).Construct($R(10) - 5,..field.len - 10 + $R(10)), 4: ##class(fbt.Point).Construct($R(10) - 5,$R(10)),: ..vecGen(rad, ..field, pass))
		}
			//get end point [rand]
			//s end = vecGen(rad, ..field, pass)
			s curPass.vecEnd = end
			zw (end.lat < 0)_" x < 0"
			zw (end.lat >= ..field.len)_" x >max"
			zw (end.lon < 0)_" y < 0" 
			zw (end.lon >= ..field.widths)_" y > max"
			//zw "next"
			if (((start.lat < 0) || (start.lat >= ..field.len)) || ((start.lon < 0) || (start.lon >= ..field.widths))){
				s curPass.inField = 0
				//____________________________________
				//s curPass.toPlayer = ..GetPlayer(curPass)
				//____________________________________
				#dim imagePass As fbt.Pass
				s imagePass = ##class(fbt.Pass).%New()
				d curPass.genSpeedTime()
				s stat = curPass.%Save()
				//w stat_" spatus "_curPass.inField_" curinf " , !
				s imagePass.inField = 0
				s imagePass.vecStart = start
				s imagePass.vecEnd = ..field.center
				zw imagePass.vecEnd , "imVek"
				s imagePass.fromPlayer = curPass.toPlayer
				s imagePass.toPlayer = curPass.toPlayer
				s imagePass.startTime = curPass.startTime + curPass.duration
				s imagePass.duration = $R(8) + 5
				s imagePass.sector = 0
				return imagePass
			}
			if ((((end.lat < 0) || (end.lat >= ..field.widths)) || (end.lon < 0)) || (end.lon >= ..field.len)) {
				s curPass.inField = 0
				//___________________________________________
				s curPass.toPlayer = ..GetPlayer(curPass)
				//____________________________________-
				#dim imagePass As fbt.Pass
				s imagePass = ##class(fbt.Pass).%New()
				d curPass.genSpeedTime()
				s stat = curPass.%Save()
				w stat_" spatus "_curPass.inField_" curinf " , !
				s imagePass.inField = 0
				s imagePass.vecStart = curPass.vecEnd
				if end.lon < 0{
					if end.lat < 0 {
						//1
						s p1 = ..interCheck(start,end,..field.l0,..field.r0)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 1
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.l1,..field.l2)
						////zw p1
						////zw end 
						////zw start
						if p1.lat > -1 {
							s chance = $R(100)
							if chance > 50 {
								s pass.Scored = 1
								s imagePass.vecEnd = ..field.center
								zw imagePass.vecEnd , "imVek"
								
								s imagePass.fromPlayer = curPass.toPlayer
								
								//s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(8) + 5
								s imagePass.sector = 0
								return imagePass
							} else{
								s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
								s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(4) + 2
								s imagePass.sector = 1
								return imagePass
							}
						}
						s p1 = ..interCheck(start,end,..field.l0,..field.l1)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 4
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.l2,..field.l3) 
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 4
							return imagePass
						
						}
					} else {
						//2
						s p1 = ..interCheck(start,end,..field.l3,..field.r3)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 3
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.l1,..field.l2)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							s chance = $R(100)
							if chance > 50 {
								s pass.Scored = 1
								s imagePass.vecEnd = ..field.center
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(8) + 5
								s imagePass.sector = 0
								return imagePass
							} else{
								s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
								s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(4) + 2
								s imagePass.sector = 1
								return imagePass
							}
						}
						s p1 = ..interCheck(start,end,..field.l0,..field.l1)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 4
							return imagePass
						}
						s p1 = ..interCheck(start,end,..field.l2,..field.l3) 
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 4
							return imagePass
						}
					}
				} else {
					if end.lat < 0 {
						//3
						s p1 = ..interCheck(start,end,..field.l0,..field.r0)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 1
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.r1,..field.r2)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							s chance = $R(100)
							if chance > 50 {
								s pass.Scored = 1
								s imagePass.vecEnd = ..field.center
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(8) + 5
								s imagePass.sector = 0
								return imagePass
							} else{
								s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
								s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(4) + 2
								s imagePass.sector = 1
								return imagePass
							}
						}
						s p1 = ..interCheck(start,end,..field.r0,..field.r1)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 2
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.r2,..field.r3)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 2
							return imagePass
						}
					} else {
						//4
						s p1 = ..interCheck(start,end,..field.l3,..field.r3)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 3
							return imagePass
						
						}
						s p1 = ..interCheck(start,end,..field.r1,..field.r2)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							s chance = $R(100)
							if chance > 50 {
								s pass.Scored = 1
								s imagePass.vecEnd = ..field.center
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(8) + 5
								s imagePass.sector = 0
								return imagePass
							} else{
								s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
								s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
								zw imagePass.vecEnd , "imVek"
								s imagePass.fromPlayer = curPass.toPlayer
								s imagePass.toPlayer = curPass.toPlayer
								s imagePass.startTime = curPass.startTime + curPass.duration
								s imagePass.duration = $R(4) + 2
								s imagePass.sector = 1
								return imagePass
							}
						}
						s p1 = ..interCheck(start,end,..field.r0,..field.r1)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 2
							return imagePass
						}
						s p1 = ..interCheck(start,end,..field.r2,..field.r3)
						//zw p1
						//zw end 
						//zw start
						if p1.lat > -1 {
							//gen pl to
							s shftPnt = ##class(fbt.Point).Construct(.0,0.1)
							s imagePass.vecEnd = ##class(fbt.Point).vecSum(shftPnt,p1)
							zw imagePass.vecEnd , "imVek"
							s imagePass.fromPlayer = curPass.toPlayer
							s imagePass.toPlayer = curPass.toPlayer
							s imagePass.startTime = curPass.startTime + curPass.duration
							s imagePass.duration = $R(4) + 2
							s imagePass.sector = 2
							return imagePass
							
						}
					}
				}
			} else{
				s curPass.toPlayer = ..GetPlayer(curPass)
				//________________________________________________________
				s curPass.inField = 1
				d curPass.genSpeedTime()
				d curPass.%Save()
			}
			
		//get player to___________________________________________
		
		return curPass
		//get speed [rand]
		/// TO DO normal destributon
		/*s speed = $R(40)
		s pass.speed = speed
		// calc time
		s pass.duration = vecLen / speed + 1
		*/
	}
	
	/// check if in circle
	ClassMethod vecLen(cordX As %Decimal, cordY As %Decimal) As %Decimal
	{
		return (cordX * cordX + (cordY * cordY))
	}
	ClassMethod vecGen(rad As %Decimal, pass As fbt.Pass, Output len As %Decimal) As fbt.Point {
		s a = rad
		s b = rad
		s rd = rad * 1000
		while(..vecLen(a,b) >= (rad ** 2)) {
			s a = ($R(2 * rd) - rd) / 1000.0
			s b = ($R(2 * rd) - rd) / 1000.0
		}
		//s len = vecLen(a,b)
		s vec = ##class(fbt.Point).%New()
		s vec.lat = a
		s vec.lon = b
		//s ans = ##class(fbt.Point).vecSum(pass.vecStart, vec)*/
		//s ans = ##class(fbt.Point).vecSum(pass.vecStart,field.convMtoDeg(a,b))
		
		return vec
	}
	/// Check if vectors intersects
	Method interCheck(p1 As fbt.Point,p2 As fbt.Point,f1 As fbt.Point,f2 As fbt.Point) As fbt.Point 
	{
		#dim retVal As fbt.Point
		s a12 = .1 + f1.lat - f2.lat
		s x12 = p1.lat - p2.lat
		s ax2 =  .1 + f2.lat - p2.lat
		s y12 = p1.lon - p2.lon
		s b12 = .1 + f1.lon - f2.lon 
		s yb2 = p2.lon - f2.lon
		s c1 = ((((y12 * ax2) / b12) / x12) + (yb2 / b12))
		s c2 =(1 - (((y12 * a12) / b12) / x12))
		s m1 = c1 / c2
		s m2 = ((a12 * m1) / x12) + (ax2 / x12)
		s retVal = ##class(fbt.Point).%New()
		s retVal.lon = -1 
		s retVal.lat = -1
		if ((m1 >= 0) && (m2 >= 0) && (m1<= 1) && (m2 <=1))
		{
			s retVal.lon = f1.lon + (f2.lon * m1)
			s retVal.lat = f1.lat + (f2.lat * m1)
		}
		return retVal
	}
	
	/// start generation
	ClassMethod gameGen(startPoint As fbt.Point,len As %Integer,widths As %Integer )	 
	{	
		#dim game As fbt.GameGen
		s game = ##class(fbt.GameGen).%New()
		s curGame = ##class(fbt.Game).%New()
		//step 1 GF
		s game.field = ##class(fbt.Field).calcFeeld(startPoint,len,widths)
		d ##class(fbt.Game).Populate(1,,, .curGame)
		zw curGame(1)
		//GCT
		//d ##class(fbt.CurTeam).Populate(curGame.guestTeam)
		//d ##class(fbt.CurTeam).Populate(curGame.hostTeam)
			
		
		//loop
		#dim nextPass As fbt.Pass
		s nextPass = ##class(fbt.Pass).%New()
		s nextPass.vecStart = game.field.center
		s nextPass.vecEnd = game.field.center
		s nextPass.duration = 0
		s nextPass.startTime = 0
		s nextPass.speed = 0
		s nextPass.inField = 1
		s nextPass.fromPlayer = ##class(fbt.Player).%OpenId(1) // #############################################
		s nextPass.toPlayer = nextPass.fromPlayer 
		s i = 0
		while(i < 10000) {
			s i = i + 1
			s pass = nextPass
			s pass.match = curGame
			s rad = $R(20) + 5
			s nextPass = game.stepGen(rad,pass,curGame)
		}
		s curGame.field = game.field
		d curGame.%Save()
		d game.%Save()
	}
	
	/// Получение случайного игрока
	ClassMethod GetPlayer(pass as fbt.Pass){
		s gId = pass.match.%Id()
		s game = ##class("fbt.Game").%OpenId(gId)
		
		//s list = ##class(%ListOfObjects).%New()
		//s list = game.guestTeam 
		
		if (pass.inField = 1) { 
			s rand = $R(2)
			s team = $Case(rand, 0:game.guestTeam.Players,:game.hostTeam.Players)
		}
		else {
			if (pass.fromPlayer.Team.%Id() = game.hostTeam.Team.%Id()) { s team = game.guestTeam.Players }
			else { s team = game.hostTeam.Players } 
		}
		// случайный игрок случайной команды
		// TODO(!) телепортaция -> учёт зон
		s rand = $R(team.Count())
		s player = team.GetAt(rand+1)
		
		q player 		
	}

Storage Default
{
<Data name="GameGenDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>fieled</Value>
</Value>
<Value name="3">
<Value>field</Value>
</Value>
</Data>
<DataLocation>^fbt.GameGenD</DataLocation>
<DefaultData>GameGenDefaultData</DefaultData>
<IdLocation>^fbt.GameGenD</IdLocation>
<IndexLocation>^fbt.GameGenI</IndexLocation>
<StreamLocation>^fbt.GameGenS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}