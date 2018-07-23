Class fbt.Point Extends %Persistent
{
Property lat As %Decimal(SCALE = 8) [Required ];
Property lon As %Decimal(SCALE = 8) [Required ];


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
<DataLocation>^fbt.PointD</DataLocation>
<DefaultData>PointDefaultData</DefaultData>
<IdLocation>^fbt.PointD</IdLocation>
<IndexLocation>^fbt.PointI</IndexLocation>
<StreamLocation>^fbt.PointS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}