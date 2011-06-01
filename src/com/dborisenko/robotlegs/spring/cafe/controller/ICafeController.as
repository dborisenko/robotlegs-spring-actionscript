package com.dborisenko.robotlegs.spring.cafe.controller
{
	import com.dborisenko.robotlegs.spring.cafe.data.Food;
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface ICafeController
	{
		function orderFood(food:Food):void;
		function cancelFoodOrder(food:FoodOrder):void;
	}
}