Class dc.data.rcc.GMbadge Extends %Persistent [ Final, SqlRowIdPrivate ]
{
    
/// Badges decteted from member load
Parameter DEFAULTGLOBAL = "^rcc.Bdg";

Property BadgeId As %Integer(MINVAL = 1);

Property Title As %String(COLLATION = "EXACT", MAXLEN = "");

/// pure ID of assigned members
Property Members As list Of %Integer;

Property MbCnt As %Integer [ Calculated, SqlComputeCode = { Set {*} = $ll({Members})  }, SqlComputed ];

Index idx On BadgeId [ IdKey ];

Index tit On Title;

Index mct On MbCnt [ Type = bitmap ];

ClassMethod maxId() As %Integer
{
	quit $O(@(..#DEFAULTGLOBAL_"D("""")"),-1)
}

Storage Default
{
<Data name="GMbadgeDefaultData">
<Value name="1">
<Value>Title</Value>
</Value>
<Value name="2">
<Value>Members</Value>
</Value>
</Data>
<DataLocation>^rcc.BdgD</DataLocation>
<DefaultData>GMbadgeDefaultData</DefaultData>
<IdLocation>^rcc.BdgD</IdLocation>
<IndexLocation>^rcc.BdgI</IndexLocation>
<StreamLocation>^rcc.BdgS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
}
