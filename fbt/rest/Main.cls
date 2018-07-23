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
	q st
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

}