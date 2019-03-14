package com.dborisenko.robotlegs.spring.cafe.view.component.event
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class FoodEvent extends Event
	{
		public static const PERFORM_ORDER_FOOD:String = "performOrderFood";
		public static const PERFORM_CANCEL_ORDER:String = "performCancelOrder";
		
		public var data:Object;
		
		public function FoodEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}