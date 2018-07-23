Class fbt.Team Extends (%Persistent, %Populate)
{
Property name As %String(MAXLEN = "", POPSPEC = "Company()");
Relationship Players As fbt.Player [Cardinality = many, Inverse = Team];
Relationship CurTeams As fbt.CurTeam [Cardinality = many, Inverse = Team];
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
<IdLocation>^fbt.TeamD</IdLocation>
<IndexLocation>^fbt.TeamI</IndexLocation>
<StreamLocation>^fbt.TeamS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}