package com.dborisenko.robotlegs.spring.cafe.view.mediator
{
	import com.dborisenko.robotlegs.spring.cafe.data.Food;
	import com.dborisenko.robotlegs.spring.cafe.model.ICafeModel;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.CancelFoodOrderSignal;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.OrderFoodSignal;
	import com.dborisenko.robotlegs.spring.cafe.signal.notification.OrderPriceChangeSignal;
	import com.dborisenko.robotlegs.spring.cafe.view.component.IFoodControlsView;
	import com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent;
	
	import flash.events.Event;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class FoodControlsMediator extends CafeMediator
	{
		//--------------------------------------------------------------------------
		//  Injections
		//--------------------------------------------------------------------------
		
		[Inject]
		public var view:IFoodControlsView;
		
		[Inject]
		public var cafeModel:ICafeModel;
		
		//--------------------------------------------------------------------------
		//  Action signals
		//--------------------------------------------------------------------------
		
		[Inject]
		public var orderFoodSignal:OrderFoodSignal;
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function FoodControlsMediator()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//  initialize
		//--------------------------------------------------------------------------
		
		protected var isInitialized:Boolean = false;
		
		[PostConstruct]
		protected function initialize():void
		{
			if (!isInitialized)
			{
				isInitialized = true;
				
				view.addEventListener(FoodEvent.PERFORM_ORDER_FOOD, onPerformOrderFood);
				
				view.food = cafeModel.foodList;
			}
		}
		
		override public function onRegister():void
		{
			initialize();
		}
		
		//--------------------------------------------------------------------------
		//  destroy
		//--------------------------------------------------------------------------
		
		protected var isDestroyed:Boolean = false;
		
		[PreDestroy]
		protected function destroy():void
		{
			if (!isDestroyed)
			{
				isDestroyed = true;
				
				view.removeEventListener(FoodEvent.PERFORM_ORDER_FOOD, onPerformOrderFood);
				
				view.food = null;
			}
		}
		
		override public function onRemove():void
		{
			destroy();
		}
		
		//--------------------------------------------------------------------------
		//  View event handlers
		//--------------------------------------------------------------------------
		
		protected function onPerformOrderFood(event:FoodEvent):void
		{
			var food:Food = event.data as Food;
			if (food)
			{
				orderFoodSignal.dispatch(food);
			}
		}
	}
}