Class fbt.Pass Extends %Persistent
{	
	Relationship match as fbt.Game [Cardinality = one, Inverse = passes];
	/// start pass
	Property vecStart As fbt.Point;
	Property vecEnd As fbt.Point;
	/// happend between players
	Property fromPlayer As fbt.Player;
	Property toPlayer As fbt.Player;
	/// Timing
	Property startTime As %Time;
	Property duration As %Integer;
	Property speed As %Decimal;
	
Storage Default
{
<Data name="PassDefaultData">
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
<Value>vecStart</Value>
</Value>
<Value name="10">
<Value>vecEnd</Value>
</Value>
<Value name="11">
<Value>fromPlayer</Value>
</Value>
<Value name="12">
<Value>toPlayer</Value>
</Value>
<Value name="13">
<Value>startTime</Value>
</Value>
<Value name="14">
<Value>duration</Value>
</Value>
<Value name="15">
<Value>speed</Value>
</Value>
<Value name="16">
<Value>match</Value>
</Value>
</Data>
<DataLocation>^fbt.PassD</DataLocation>
<DefaultData>PassDefaultData</DefaultData>
<IdLocation>^fbt.PassD</IdLocation>
<IndexLocation>^fbt.PassI</IndexLocation>
<StreamLocation>^fbt.PassS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}