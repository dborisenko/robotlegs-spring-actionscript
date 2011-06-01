package com.dborisenko.robotlegs.spring.cafe.data
{
	import org.as3commons.lang.Assert;

	[Bindable]
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class FoodOrder
	{
		//--------------------------------------------------------------------------
		//  food
		//--------------------------------------------------------------------------
		
		private var _food:Food;

		public function get food():Food
		{
			return _food;
		}
		public function set food(value:Food):void
		{
			_food = value;
		}

		//--------------------------------------------------------------------------
		//  quantity
		//--------------------------------------------------------------------------
		
		private var _quantity:uint = 0;

		public function get quantity():uint
		{
			return _quantity;
		}
		public function set quantity(value:uint):void
		{
			_quantity = value;
		}

		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function FoodOrder(food:Food, quantity:uint = 1)
		{
			Assert.notNull(food, "Argument [food] cannot be null");
			this.food = food;
			this.quantity = quantity;
		}
	}
}