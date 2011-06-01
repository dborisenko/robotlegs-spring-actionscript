package com.dborisenko.robotlegs.spring.cafe.controller
{
	import com.dborisenko.robotlegs.spring.cafe.data.Food;
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;
	import com.dborisenko.robotlegs.spring.cafe.model.ICafeModel;
	import com.dborisenko.robotlegs.spring.cafe.signal.notification.OrderPriceChangeSignal;
	
	import mx.collections.IViewCursor;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class CafeController implements ICafeController
	{
		[Inject]
		public var cafeModel:ICafeModel;
		
		[Inject]
		public var orderPriceChangeSignal:OrderPriceChangeSignal;
		
		public function CafeController()
		{
		}
		
		public function orderFood(food:Food):void
		{
			var foodOrder:FoodOrder = findFoodOrder(food);
			if (foodOrder)
			{
				foodOrder.quantity++;
			}
			else
			{
				cafeModel.orderedFood.addItem(new FoodOrder(food));
			}
			updateOrderedFoodPrice();
		}
		
		public function cancelFoodOrder(foodOrder:FoodOrder):void
		{
			cafeModel.orderedFood.removeItemAt(cafeModel.orderedFood.getItemIndex(foodOrder));
			updateOrderedFoodPrice();
		}
		
		protected function findFoodOrder(food:Food):FoodOrder
		{
			for (var i:int = 0; i < cafeModel.orderedFood.length; i++)
			{
				var foodOrder:FoodOrder = cafeModel.orderedFood.getItemAt(i) as FoodOrder;
				if (foodOrder && foodOrder.food == food)
				{
					return foodOrder;
				}
			}
			return null;
		}
		
		protected function updateOrderedFoodPrice():void
		{
			var totalPrice:Number = 0;
			for (var i:int = 0; i < cafeModel.orderedFood.length; i++)
			{
				var foodOrder:FoodOrder = cafeModel.orderedFood.getItemAt(i) as FoodOrder;
				if (foodOrder)
				{
					totalPrice += (foodOrder.food.cost * foodOrder.quantity);
				}
			}
			
			cafeModel.orderPrice = totalPrice;
			orderPriceChangeSignal.dispatch();
		}
	}
}