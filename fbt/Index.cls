Class fbt.Index Extends %SerialObject
{
	Property part1 as %Integer;
	Property part2 as %Integer;
Storage Default
{
<Data name="IndexState">
<Value name="1">
<Value>part1</Value>
</Value>
<Value name="2">
<Value>part2</Value>
</Value>
</Data>
<State>IndexState</State>
<StreamLocation>^fbt.IndexS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
}

}