/// Справочник ролей
Class fbt.Role Extends %Persistent
{
	Property roleName as %String;
	Index IRoleName on roleName [unique];
	
Storage Default
{
<Data name="RoleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>roleName</Value>
</Value>
</Data>
<DataLocation>^fbt.RoleD</DataLocation>
<DefaultData>RoleDefaultData</DefaultData>
<IdLocation>^fbt.RoleD</IdLocation>
<IndexLocation>^fbt.RoleI</IndexLocation>
<StreamLocation>^fbt.RoleS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}