/// Справочник ролей
Class fbt.Role Extends %Persistent
{
	Property roleName as %String;
	Index IRoleName on roleName [unique];
	
// Создание справочника ролей	
ClassMethod CreateRoles(){
	s sc = ..NewRole("Goalkeeper")
	s sc = ..NewRole("Defender")
	s sc = ..NewRole("Midfielder")
	s sc = ..NewRole("Forward")
}
ClassMethod NewRole(name As %String) as %Status{
	s sc = $$$OK
	s role = ##class(fbt.Role).%New()
	s role.roleName = name
	s sc = role.%Save()
	q sc
}
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