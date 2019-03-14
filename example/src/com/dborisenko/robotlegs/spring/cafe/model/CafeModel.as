package com.dborisenko.robotlegs.spring.cafe.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class CafeModel implements ICafeModel
	{
		//--------------------------------------------------------------------------
		//  foodList
		//--------------------------------------------------------------------------
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.Food")]
		protected var _foodList:IList = new ArrayCollection();
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.Food")]
		public function get foodList():IList
		{
			return _foodList;
		}
		public function set foodList(value:IList):void
		{
			_foodList = value;
		}
		
		//--------------------------------------------------------------------------
		//  selectedFood
		//--------------------------------------------------------------------------
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		protected var _orderedFood:IList = new ArrayCollection();
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		public function get orderedFood():IList
		{
			return _orderedFood;
		}
		
		//--------------------------------------------------------------------------
		//  orderPrise
		//--------------------------------------------------------------------------
		
		private var _orderPrice:Number = 0.0;

		public function get orderPrice():Number
		{
			return _orderPrice;
		}
		public function set orderPrice(value:Number):void
		{
			_orderPrice = value;
		}
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function CafeModel()
		{
		}
	}
}