Class fbt.Team Extends (%Persistent, %Populate)
{

	Property name As %String(MAXLEN = "", POPSPEC = "Company()");
	
	Relationship Players As fbt.Player [ Cardinality = many, Inverse = Team ];
	
	Relationship CurTeams As fbt.CurTeam [ Cardinality = many, Inverse = Team ];

Storage Default
{
<Data name="TeamDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^fbt.TeamD</DataLocation>
<DefaultData>TeamDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^fbt.TeamD</IdLocation>
<IndexLocation>^fbt.TeamI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.1</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="name">
<AverageFieldSize>16</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^fbt.TeamS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
