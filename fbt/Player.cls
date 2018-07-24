Class fbt.Player Extends (%Persistent, %Populate)
{

Relationship Team As fbt.Team [ Cardinality = one, Inverse = Players ];

Property name As %String(MAXLEN = "");

Property role As fbt.Role (POPSPEC = ".PopRole()");

// ..

ClassMethod Compare(number As %Integer, min As %Integer, max As %Integer) As %Boolean
{
 	q:((number >= min) && (number <= max)) 1
 	q:0
}

ClassMethod PopRole() As fbt.Role
{
  	s rand = $R(1100)
  	q role = $CASE(1,..Compare(rand,0,99):##class(fbt.Role).%IRoleNameOpen("Goalkeeper"),..Compare(rand,100,599):##class(fbt.Role).%IRoleNameOpen("Defender"),..Compare(rand,600,799):##class(fbt.Role).%IRoleNameOpen("Midfielder"),:##class(fbt.Role).%IRoleNameOpen("Forward"))
}

Storage Default
{
<Data name="PlayerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>Team</Value>
</Value>
<Value name="4">
<Value>role</Value>
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
