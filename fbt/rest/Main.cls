Class fbt.rest.Main Extends %CSP.REST
{
Parameter HandleCorsRequest = 1;

XData UrlMap
{ 
<Routes>
	<Route Url="/check/round/:idgame" Method="POST" Call="checkRound" />
	
	<Route Url="/get/games" Method="GET" Call="getAllGames" />
	<Route Url="/get/points/:idgame" Method="GET" Call="getAllPoints" />
	
	<Route Url="/test" Method="GET" Call="test" />
</Routes>
}

/// Получения списка всех игр
ClassMethod getAllGames(){
	set st=$$$OK
	try{
		set sql = "SELECT * FROM fbt.Game"	
   	 	set rs = ##class(%ResultSet).%New("%DynamicQuery:SQL")
   		$$$ThrowOnError(rs.Prepare(sql))
	    $$$ThrowOnError(rs.Execute())
	    #dim out As %DynamicArray = []
	    while (rs.%Next() '= 0) {
			#dim game As fbt.Game = rs.GetObject()
			set r =  {
			    "id": (game.%Id()),
			    "hostTeam":(game.hostTeam.name),
			    "guestTeam":(game.guestTeam.name),
			    "matchId":(game.matchId)
			}
	 		do out.%Push(r)
	    }
		
	    w out.%ToJSON()
	    
	}catch c{
		set st = c.AsStatus()
	}
    return st
}

/// Получение всех векторов для игры
ClassMethod getAllPoints(idgame As %String){
	set st=$$$OK
	q st
}

/// Проверка для круга - должен возвращать список векторов, с которыми было пересечение
ClassMethod checkRound(idgame As %String){
	set data = $ZCVT(%request.Content.Read($$$MaxStringLength), "I", "UTF8")
    $$$ThrowOnError(##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(data, , .obj, 1))
    
    //Разбираем пришедший круг на запчасти
    set cx=obj.cx
    set cy=obj.cy
    set r=obj.r
    
    q $$$OK
}

ClassMethod Test(){
	set st=$$$OK
	w {"test":"OK"}.%ToJSON()
	q st
}

}