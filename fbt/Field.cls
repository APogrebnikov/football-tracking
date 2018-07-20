Class fbt.Field Extends %Persistent
{

/// Zero point(lb)
	Property startPoint As fbt.Point [Required ];
	Property lt As fbt.Point;
	Property rb As fbt.Point;
	Property rt As fbt.Point;
	Property center As fbt.Point;
	Property len As %Integer [Required ];
	Property widths As %Integer [Required ];
	Property degOfLat As %Decimal;
	Property degOfLon As %Decimal;
	
	/// Convert m to deg
	Method convMtoDeg(distX As %Decimal, distY As %Decimal) As fbt.Point  
	{
		s cLatToM = 111319 * ($zcos(..startPoint.lat * $zpi / 180)) 
		s cLonToM = 111134
		s answ = ##class(fbt.Point).%New()
		s answ.lat = distX * (1 / cLatToM)
		s answ.lon = distY * (1 / cLonToM)
		return answ
	}
	
	/// calc magic consts for feeld
	Method calcFeeld() {
		s ..degOfLat = 111319 * ($zcos(..startPoint.lat * $zpi / 180)) 
		s ..degOfLon = 111134
		s ..lt = ..startPoint
		s ..rb = ..startPoint
		s ..rt = ..startPoint
		s ..lt.lat = ..len * (1 / ..degOfLat) + ..lt.lat
		s ..rt.lat = ..len * (1 / ..degOfLat) + ..rt.lat
		s ..rt.lon = ..widths * (1 / ..degOfLon) + ..rt.lon
		s ..rb.lon = ..widths * (1 / ..degOfLon) + ..rb.lon
	}
Storage Default
{
<Data name="FieldDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>startPoint</Value>
</Value>
<Value name="3">
<Value>lt</Value>
</Value>
<Value name="4">
<Value>rb</Value>
</Value>
<Value name="5">
<Value>rt</Value>
</Value>
<Value name="6">
<Value>center</Value>
</Value>
<Value name="7">
<Value>len</Value>
</Value>
<Value name="8">
<Value>widths</Value>
</Value>
<Value name="9">
<Value>degOfLat</Value>
</Value>
<Value name="10">
<Value>degOfLon</Value>
</Value>
</Data>
<DataLocation>^fbt.FieldD</DataLocation>
<DefaultData>FieldDefaultData</DefaultData>
<IdLocation>^fbt.FieldD</IdLocation>
<IndexLocation>^fbt.FieldI</IndexLocation>
<StreamLocation>^fbt.FieldS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}