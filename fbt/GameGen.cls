Class fbt.GameGen Extends %Persistent
{
	Property fieled As fbt.Field;
	/// The method generates the game
	Method stepGen(rad As %Decimal = 50, pass As fbt.Pass) {
		//get start point
		//get player from
		if (pass.inField){
			s start = end  
			s fromPl = toPl
		} else {
			s start = end  
			s fromPl = toPl
		}
		//get end point [rand]
			s end = vecGen(rad, ..fieled, pass) 
		//get player to
		
		//get speed [rand]
		/// TO DO normal destributon
		s speed = $R(40)
		s pass.speed = speed
		// calc time
		s pass.duration = vecLen / speed + 1
		
	}
	
	/// check if in circle
	ClassMethod vecLen(cordX As %Decimal, cordY As %Decimal) As %Decimal
	{
		return (cordX * cordX + (cordY * cordY))
	}
	ClassMethod vecGen(rad As %Decimal, pass As fbt.Pass, Output len As %Decimal) As fbt.Point {
		s a = rad
		s b = rad
		while(vecLen(a,b) >= (rad ** 2)) {
			s a = $R(2 * rad) - rad
			s b = $R(2 * rad) - rad
		}
		s len = vecLen(a,b)
		s vec = ##class(fbt.Point).%New()
		s vec.lat = a
		s vec.lon = b
		s ans = ##class(fbt.Point).vecSum(pass.vecStart, vec)
		//s ans = ##class(fbt.Point).vecSum(pass.vecStart,field.convMtoDeg(a,b))
		
		return ans
	}
	/// Check if vectors intersects
	Method interCheck(p1 As fbt.Point,p2 As fbt.Point,f1 As fbt.Point,f2 As fbt.Point) As fbt.Point 
	{
		#dim retVal As fbt.Point
		s a12 = f1.lat - f2.lat
		s x12 = p1.lat - f2.lat
		s ax2 = f1.lat - p2.lat
		s y12 = p1.lon - p2.lon
		s b12 = f1.lon - f2.lon 
		s yb2 = p2.lon - f2.lon
		s c1 = (y12 * ax2 / b12 / x12 + (yb2 / b12))
		s c2 =(1 - (y12 * a12 / b12 / x12))
		s m1 = c1 / c2
		s m2 = a12 * m1 / x12 + (ax2 / x12)
		s retVal = ##class(fbt.Point).%New()
		s retVal.lon = -1 
		s retVal.lat = -1
		if (m1 >= 0 && m2 >= 0 && m1<= 1 && m2 <=1){
			s retVal.lon = p1.lon + p2.lon * m2
			s retVal.lat = p1.lat + p2.lat * m2
		}
		return retVal
	}
	
	/// start generation
	ClassMethod gameGen(startPoint As fbt.Point,len As %Integer,widths As %Integer )	 
	{	
		#dim game As fbt.GameGen
		s game = ##class(fbt.GameGen).%New()
		//step 1 GF
		s game.field = ##class(fbt.Field).calcFeeld(startPoint,len,widths)
		//GCT
		
		//loop
		while(true){
			s rad = $R(20) + 40
			d game.stepGen(rad,pass)
		}
		
	}	

Storage Default
{
<Data name="GameGenDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>fieled</Value>
</Value>
</Data>
<DataLocation>^fbt.GameGenD</DataLocation>
<DefaultData>GameGenDefaultData</DefaultData>
<IdLocation>^fbt.GameGenD</IdLocation>
<IndexLocation>^fbt.GameGenI</IndexLocation>
<StreamLocation>^fbt.GameGenS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}