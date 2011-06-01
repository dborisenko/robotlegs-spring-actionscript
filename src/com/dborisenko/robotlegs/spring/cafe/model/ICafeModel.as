package com.dborisenko.robotlegs.spring.cafe.model
{
	import mx.collections.ArrayCollection;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface ICafeModel
	{
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.Food")]
		function get foodList():ArrayCollection;
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		function get orderedFood():ArrayCollection;
		
		function set orderPrice(value:Number):void;
		function get orderPrice():Number;
	}
}