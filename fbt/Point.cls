Class fbt.Point Extends %SerialObject
{
Property lat As %Decimal(SCALE = 8) [Required ];
Property lon As %Decimal(SCALE = 8) [Required ];


 /// constructor
 ClassMethod Construct(x As %Decimal, y As %Decimal) As fbt.Point 
 {
 	#dim retVal As fbt.Point
 	s retVal = ##class(fbt.Point).%New()
 	s retVal.lat = x
 	s retVal.lon = y
 	return retVal
 }
 ClassMethod vecSum(a As fbt.Point, b As fbt.Point) As fbt.Point{
 	s ret = a
 	s ret.lat = a.lat + b.lat
 	s ret.lon = a.lon + b.lon
 	return ret
 }
 
 ClassMethod vecDif(a As fbt.Point, b As fbt.Point) As fbt.Point{
 	s ret = ##class(fbt.Point).%New()
 	s ret.lat = a.lat - b.lat
 	s ret.lon = a.lon - b.lon
 	return ret
 }




Storage Default
{
<Data name="PointDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>lat</Value>
</Value>
<Value name="3">
<Value>lon</Value>
</Value>
</Data>
<Data name="PointState">
<Value name="1">
<Value>lat</Value>
</Value>
<Value name="2">
<Value>lon</Value>
</Value>
</Data>
<DataLocation>^fbt.PointD</DataLocation>
<DefaultData>PointDefaultData</DefaultData>
<IdLocation>^fbt.PointD</IdLocation>
<IndexLocation>^fbt.PointI</IndexLocation>
<State>PointState</State>
<StreamLocation>^fbt.PointS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}