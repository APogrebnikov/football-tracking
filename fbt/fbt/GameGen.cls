Class fbt.GameGen
{
	/// pass id
	Property passId As %Integer;
	Property inField As %Boolean;
	Property fieled As fbt.Field;
	/// The method generates the game
	Method stepGen(rad As %Decimal = 50, pass As fbt.Pass) {
		//get start point
		//get player from
		if (..inField){
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
		s pass.speed = speed / 111000
		// calc time
		s pass.duration = vecLen / speed + 1
		
	}
	
	/// check if in circle
	ClassMethod vecLen(cordX As %Decimal, cordY As %Decimal) As %Decimal
	{
		return (cordX * cordX + (cordY * cordY))
	}
	ClassMethod vecGen(rad As %Decimal, field As fbt.Field, pass As fbt.Pass, Output len As %Decimal) As fbt.Point {
		s a = rad
		s b = rad
		while(vecLen(a,b) >= (rad ** 2)) {
			s a = $R(rad)
			s b = $R(rad)
		}
		s len = vecLen(a,b)
		s ans = ##class(fbt.Point).vecSum(pass.vecStart,field.convMtoDeg(a,b))
		return ans
	}
	
		

}