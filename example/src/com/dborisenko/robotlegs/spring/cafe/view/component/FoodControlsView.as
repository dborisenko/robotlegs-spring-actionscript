package com.dborisenko.robotlegs.spring.cafe.view.component
{
	import com.dborisenko.robotlegs.spring.cafe.data.Food;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.CancelFoodOrderSignal;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.OrderFoodSignal;
	import com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.ListBase;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.core.IDisplayText;
	
	[Event(name="performOrderFood", type="com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent")]
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class FoodControlsView extends SkinnableComponent implements IFoodControlsView
	{
		//--------------------------------------------------------------------------
		//  Skin Parts
		//--------------------------------------------------------------------------
		
		[SkinPart(required="false")]
		public var foodList:ListBase;
		
		[SkinPart(required="false")]
		public var orderButton:ButtonBase;
		
		//--------------------------------------------------------------------------
		//  Implementation of IFoodControlsView
		//--------------------------------------------------------------------------
		
		private var _food:IList;

		[Bindable]
		public function get food():IList
		{
			return _food;
		}
		public function set food(value:IList):void
		{
			_food = value;
		}
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function FoodControlsView()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//  Overriden methods
		//--------------------------------------------------------------------------
		
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == orderButton)
			{
				orderButton.addEventListener(MouseEvent.CLICK, onOrderFood);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == orderButton)
			{
				orderButton.removeEventListener(MouseEvent.CLICK, onOrderFood);
			}
		}
		
		//--------------------------------------------------------------------------
		//  Event handlers
		//--------------------------------------------------------------------------
		
		protected function onOrderFood(event:Event):void
		{
			if (foodList && foodList.selectedItem)
			{
				dispatchEvent(new FoodEvent(FoodEvent.PERFORM_ORDER_FOOD, foodList.selectedItem as Food));
			}
		}
		
	}
}