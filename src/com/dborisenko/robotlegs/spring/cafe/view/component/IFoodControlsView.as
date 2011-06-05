package com.dborisenko.robotlegs.spring.cafe.view.component
{
	import mx.collections.IList;
	import mx.core.IVisualElement;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface IFoodControlsView extends IVisualElement
	{
		function get food():IList;
		function set food(value:IList):void;
	}
}