package com.dborisenko.robotlegs.spring.cafe.view.component
{
	import mx.collections.IList;
	import mx.core.IVisualElement;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface IOrderedFoodView extends IVisualElement
	{
		function get orderedFood():IList;
		function set orderedFood(value:IList):void;
		
		function set orderPrice(value:Number):void;
		function get orderPrice():Number;
	}
}