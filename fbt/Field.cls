Class fbt.Field Extends %Persistent
{

/// Zero point(lb)
	Property startPoint As fbt.Point;
	Property lt As fbt.Point;
	Property rb As fbt.Point;
	Property rt As fbt.Point;
	Property center As fbt.Point;
	Property len As %Integer;
	Property widths As %Integer;
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
</Data>
<DataLocation>^fbt.FieldD</DataLocation>
<DefaultData>FieldDefaultData</DefaultData>
<IdLocation>^fbt.FieldD</IdLocation>
<IndexLocation>^fbt.FieldI</IndexLocation>
<StreamLocation>^fbt.FieldS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}