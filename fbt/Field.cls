Class fbt.Field Extends %Persistent
{

	/// Zero point(lb)
	Property startPoint As fbt.Point [Required ];
	Property lt As fbt.Point;
	Property rb As fbt.Point;
	Property rt As fbt.Point;
	Property center As fbt.Point;
	Property len As %Integer [Required ];
	Property widths As %Integer [Required ];
	Property degOfLat As %Decimal;
	Property degOfLon As %Decimal;
	Property segLenX As %Decimal;
	Property segLenY As %Decimal;
	// vector op vectors of lines
	Property l0 As fbt.Point;
	Property l1 As fbt.Point;
	Property l2 As fbt.Point;
	Property l3 As fbt.Point;
	Property r0 As fbt.Point;
	Property r1 As fbt.Point;
	Property r2 As fbt.Point;
	Property r3 As fbt.Point;
	
	Property l5 As fbt.Point;
	Property l4 As fbt.Point;
	Property lgt As fbt.Point;
	Property lgb As fbt.Point;
	Property r4 As fbt.Point;
	Property r5 As fbt.Point;
	Property rgb As fbt.Point;
	Property rgt As fbt.Point;
	
	/// Convert m to deg
	Method convMtoDeg(distX As %Decimal, distY As %Decimal) As fbt.Point  
	{
		s cLatToM = 111319 * ($zcos(..startPoint.lat * $zpi / 180)) 
		s cLonToM = 111134
		s answ = ##class(fbt.Point).%New()
		s answ.lat = distX * (1 / cLatToM)
		s answ.lon = distY * (1 / cLonToM)
		return answ
	}
	
	
	
	/// calc magic consts for feeld
	ClassMethod calcFeeld(startPoint As fbt.Point,len As %Integer,widths As %Integer ) As fbt.Field{
		s field = ##class(fbt.Field).%New()
		s field.startPoint = startPoint
		s field.len = len
		s field.widths = widths
		
		s field.degOfLat = 111319 * ($zcos(field.startPoint.lat * $zpi / 180)) 
		s field.degOfLon = 111134
		s field.lt = ##class(fbt.Point).Construct(0,field.len)
		s field.rb = ##class(fbt.Point).Construct(field.widths,0)
		s field.rt = ##class(fbt.Point).Construct(field.widths,field.len)
		s field.center = ##class(fbt.Point).Construct(field.widths / 2,field.len / 2)
		
		
		s field.l0 = ##class(fbt.Point).Construct(0,0)
		s field.l1 = ##class(fbt.Point).Construct(0,field.center - 2.6)
		s field.l2 = ##class(fbt.Point).Construct(0,field.center + 2.6)
		s field.l3 = ##class(fbt.Point).Construct(0,field.len)
		s field.r0 = ##class(fbt.Point).Construct(field.widths,0)
		s field.r1 = ##class(fbt.Point).Construct(field.widths,field.center - 2.6)
		s field.r2 = ##class(fbt.Point).Construct(field.widths,field.center + 2.6)
		s field.r3 = ##class(fbt.Point).Construct(field.widths,field.len)
		//Goal keeper zone
		s field.l4 = ##class(fbt.Point).Construct(0,field.l1 - 5.5)
		s field.l5 = ##class(fbt.Point).Construct(0,field.l2 + 5.5)
		s field.lgb = ##class(fbt.Point).Construct(5.5,field.l1 - 5.5)
		s field.lgt = ##class(fbt.Point).Construct(5.5,field.l2 + 5.5)
		s field.r4 = ##class(fbt.Point).Construct(field.widths,field.r1 - 5.5)
		s field.r5 = ##class(fbt.Point).Construct(field.widths,field.r2 + 5.5)
		s field.rgb = ##class(fbt.Point).Construct(field.widths - 5.5,field.r1 - 5.5)
		s field.rgt = ##class(fbt.Point).Construct(field.widths - 5.5,field.r2 + 5.5)
		
		
		
		return field
		
		/*
		s ..lt.lat = ..len * (1 / ..degOfLat) + ..lt.lat
		s ..rt.lat = ..len * (1 / ..degOfLat) + ..rt.lat
		s ..rt.lon = ..widths * (1 / ..degOfLon) + ..rt.lon
		s ..rb.lon = ..widths * (1 / ..degOfLon) + ..rb.lon
		*/
	}
Storage Default
{
<Data name="FieldDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>startPoint</Value>
</Value>
<Value name="3">
<Value>lt</Value>
</Value>
<Value name="4">
<Value>rb</Value>
</Value>
<Value name="5">
<Value>rt</Value>
</Value>
<Value name="6">
<Value>center</Value>
</Value>
<Value name="7">
<Value>len</Value>
</Value>
<Value name="8">
<Value>widths</Value>
</Value>
<Value name="9">
<Value>degOfLat</Value>
</Value>
<Value name="10">
<Value>degOfLon</Value>
</Value>
<Value name="11">
<Value>segLenX</Value>
</Value>
<Value name="12">
<Value>segLenY</Value>
</Value>
<Value name="13">
<Value>l0</Value>
</Value>
<Value name="14">
<Value>l1</Value>
</Value>
<Value name="15">
<Value>l2</Value>
</Value>
<Value name="16">
<Value>l3</Value>
</Value>
<Value name="17">
<Value>r0</Value>
</Value>
<Value name="18">
<Value>r1</Value>
</Value>
<Value name="19">
<Value>r2</Value>
</Value>
<Value name="20">
<Value>r3</Value>
</Value>
<Value name="21">
<Value>l5</Value>
</Value>
<Value name="22">
<Value>l4</Value>
</Value>
<Value name="23">
<Value>lgt</Value>
</Value>
<Value name="24">
<Value>lgb</Value>
</Value>
<Value name="25">
<Value>r4</Value>
</Value>
<Value name="26">
<Value>r5</Value>
</Value>
<Value name="27">
<Value>rgb</Value>
</Value>
<Value name="28">
<Value>rgt</Value>
</Value>
</Data>
<DataLocation>^fbt.FieldD</DataLocation>
<DefaultData>FieldDefaultData</DefaultData>
<IdLocation>^fbt.FieldD</IdLocation>
<IndexLocation>^fbt.FieldI</IndexLocation>
<StreamLocation>^fbt.FieldS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}