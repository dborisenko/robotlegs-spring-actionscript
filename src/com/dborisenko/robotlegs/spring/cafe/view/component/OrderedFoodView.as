package com.dborisenko.robotlegs.spring.cafe.view.component
{
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.CancelFoodOrderSignal;
	import com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.IList;
	
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.ListBase;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.core.IDisplayText;
	
	[Event(name="performCancelOrder", type="com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent")]
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class OrderedFoodView extends SkinnableComponent implements IOrderedFoodView
	{
		//--------------------------------------------------------------------------
		//  Skin Parts
		//--------------------------------------------------------------------------
		
		[SkinPart(required="false")]
		public var orderedFoodList:ListBase;
		
		[SkinPart(required="false")]
		public var cancelOrderButton:ButtonBase;
		
		[SkinPart(required="true")]
		public var orderPriceDisplay:IDisplayText;
		
		//--------------------------------------------------------------------------
		//  
		//  Implementation of IOrderedFoodView
		//  
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  orderedFood
		//--------------------------------------------------------------------------
		
		private var _orderedFood:IList;
		
		[Bindable]
		public function get orderedFood():IList
		{
			return _orderedFood;
		}
		public function set orderedFood(value:IList):void
		{
			_orderedFood = value;
		}
		
		//--------------------------------------------------------------------------
		//  orderPrice
		//--------------------------------------------------------------------------
		
		private var _orderPrice:Number = 0.0;
		
		[Bindable]
		public function set orderPrice(value:Number):void
		{
			_orderPrice = value;
		}
		public function get orderPrice():Number
		{
			return _orderPrice;
		}
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function OrderedFoodView()
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
			if (instance == cancelOrderButton)
			{
				cancelOrderButton.addEventListener(MouseEvent.CLICK, onCancelOrder);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == cancelOrderButton)
			{
				cancelOrderButton.removeEventListener(MouseEvent.CLICK, onCancelOrder);
			}
		}
		
		//--------------------------------------------------------------------------
		//  Event handlers
		//--------------------------------------------------------------------------
		
		protected function onCancelOrder(event:Event):void
		{
			if (orderedFoodList && orderedFoodList.selectedItem)
			{
				dispatchEvent(new FoodEvent(FoodEvent.PERFORM_CANCEL_ORDER, orderedFoodList.selectedItem as FoodOrder));
			}
		}
		
	}
}