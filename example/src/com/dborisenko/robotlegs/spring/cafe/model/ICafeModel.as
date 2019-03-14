package com.dborisenko.robotlegs.spring.cafe.model
{
	import mx.collections.IList;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface ICafeModel
	{
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.Food")]
		function get foodList():IList;
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		function get orderedFood():IList;
		
		function set orderPrice(value:Number):void;
		function get orderPrice():Number;
	}
}