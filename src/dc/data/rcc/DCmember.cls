/// Users found in developer community
/// includes number of badges in Global Masters
Class dc.data.rcc.DCmember Extends %Persistent [ Final, SqlRowIdPrivate ]
{

Parameter DEFAULTGLOBAL = "^rcc.Mbr";

Property MbrId As %Integer(MINVAL = 1);

Property Name As %String(MAXLEN = "");

Property Level As %String [ SqlFieldName = LEVL ];

/// pure ID of awarded GM badges
Property Badges As list Of %Integer;

Property BadgeCount As %Integer [ Calculated, SqlComputeCode = { Set {*} = $ll({Badges}) }, SqlComputed ];

Index idkey On MbrId [ IdKey ];

Index bct On BadgeCount [ Type = bitmap ];

ClassMethod maxId() As %Integer
{
	quit $O(@(..#DEFAULTGLOBAL_"D("""")"),-1)
}

ClassMethod nextId(id = 0) As %Integer
{
	quit $O(@(..#DEFAULTGLOBAL_"D("_+id_")"))
}

Storage Default
{
<Data name="DCmemberDefaultData">
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Level</Value>
</Value>
<Value name="3">
<Value>Badges</Value>
</Value>
</Data>
<DataLocation>^rcc.MbrD</DataLocation>
<DefaultData>DCmemberDefaultData</DefaultData>
<IdLocation>^rcc.MbrD</IdLocation>
<IndexLocation>^rcc.MbrI</IndexLocation>
<StreamLocation>^rcc.MbrS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

                                
}
