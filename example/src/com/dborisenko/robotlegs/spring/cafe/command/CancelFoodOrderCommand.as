package com.dborisenko.robotlegs.spring.cafe.command
{
	import com.dborisenko.robotlegs.spring.cafe.controller.ICafeController;
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class CancelFoodOrderCommand
	{
		[Inject]
		public var cafeController:ICafeController;
		
		[Inject]
		public var food:FoodOrder;
		
		public function execute():void
		{
			cafeController.cancelFoodOrder(food);
		}
	}
}