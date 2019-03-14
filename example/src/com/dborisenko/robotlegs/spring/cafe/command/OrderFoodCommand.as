package com.dborisenko.robotlegs.spring.cafe.command
{
	import com.dborisenko.robotlegs.spring.cafe.controller.ICafeController;
	import com.dborisenko.robotlegs.spring.cafe.data.Food;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class OrderFoodCommand
	{
		[Inject]
		public var cafeController:ICafeController;
		
		[Inject]
		public var food:Food;
		
		public function execute():void
		{
			cafeController.orderFood(food);
		}
	}
}