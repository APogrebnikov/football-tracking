Class fbt.Game Extends (%Persistent, %Populate)
{
	Relationship passes as fbt.Pass [Cardinality = many, Inverse = match];
	Property matchId As %String [Required ];
	/// Time from start in sec
	Property duration As %Integer [Required ];
	Property startTime As %Time [Required ];
	/// Teams playing
	Property guestTeam As fbt.Team [Required ];
	Property hostTeam As fbt.Team [Required ];
	//Property Score As %String;                                       ###################
	
	/// get all passes near the point
	Method allPasses(point As fbt.Point, rad As %Decimal) 
	{
		//get vectors
		//
	}
	
	/// check interseptions
	ClassMethod circleIntersepts(point As fbt.Point, rad As %Decimal, vs As fbt.Point, ve As fbt.Point) As %Bolean 
	{
		#dim isInter As %Bolean
		s isInter = 0
		s x1 = vs.lat
		s x2 = ve.lat
		s x3 = point.lat
		s y1 = vs.lon
		s y2 = ve.lon
		s y3 = point.lon
		s x12 = vs.lat - ve.lat
		s y12 = vs.lon - ve.lon
		s a = (x12**2) + (y12 ** 2)
		s b = 2 * ((x12 * x2) - (x12 * x3) + (y12 * y2) - (y12 * y3))
		s c = (x2**2) + (x3**2) + (y2**2) + (y3**2) - (rad**2) - (2 * x2 * x3) - (2 * y2 * y3)
		s D = (b**2) - (4 * a * c)
		if D>= 0{
			s t1 = (0 - b) + (D**0.5) / (2*a)
			s t2 = (0 - b) - (D**0.5) / (2*a)
			if ((t1 > 0) && (t1 < 1)){
				s isInter = 1
				return isInter
			}
			if ((t2 > 0) && (t1 < 1)){
				s isInter = 1
				return isInter
			} 
		}
		return isInter
	}
	ClassMethod inCirc(point As fbt.Point, rad As %Decimal, vp As fbt.Point) As %Bolean
	{
		return (rad**2) >= (((vp.lat - point.lat)**2) + ((vp.lon - point.lon)**2))  
	}
Storage Default
{
<Data name="GameDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>matchId</Value>
</Value>
<Value name="3">
<Value>duration</Value>
</Value>
<Value name="4">
<Value>startTime</Value>
</Value>
<Value name="5">
<Value>guestTeam</Value>
</Value>
<Value name="6">
<Value>hostTeam</Value>
</Value>
</Data>
<DataLocation>^fbt.GameD</DataLocation>
<DefaultData>GameDefaultData</DefaultData>
<IdLocation>^fbt.GameD</IdLocation>
<IndexLocation>^fbt.GameI</IndexLocation>
<StreamLocation>^fbt.GameS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}