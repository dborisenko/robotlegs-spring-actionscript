package com.dborisenko.robotlegs.spring.cafe.model
{
	import mx.collections.ArrayCollection;

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
		protected var _foodList:ArrayCollection = new ArrayCollection();
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.Food")]
		public function get foodList():ArrayCollection
		{
			return _foodList;
		}
		public function set foodList(value:ArrayCollection):void
		{
			_foodList = value;
		}
		
		//--------------------------------------------------------------------------
		//  selectedFood
		//--------------------------------------------------------------------------
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		protected var _selectedFood:ArrayCollection = new ArrayCollection();
		
		[ArrayElementType("com.dborisenko.robotlegs.spring.cafe.data.FoodOrder")]
		public function get orderedFood():ArrayCollection
		{
			return _selectedFood;
		}
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function CafeModel()
		{
		}
	}
}