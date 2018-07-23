Class fbt.Game Extends %Persistent
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