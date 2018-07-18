Class fbt.Player Extends %Persistent
{
Property name As %String(MAXLEN = "");
Storage Default
{
<Data name="PlayerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^fbt.PlayerD</DataLocation>
<DefaultData>PlayerDefaultData</DefaultData>
<IdLocation>^fbt.PlayerD</IdLocation>
<IndexLocation>^fbt.PlayerI</IndexLocation>
<StreamLocation>^fbt.PlayerS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}