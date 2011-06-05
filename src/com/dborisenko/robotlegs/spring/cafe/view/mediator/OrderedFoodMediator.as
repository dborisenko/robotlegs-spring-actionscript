package com.dborisenko.robotlegs.spring.cafe.view.mediator
{
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;
	import com.dborisenko.robotlegs.spring.cafe.model.ICafeModel;
	import com.dborisenko.robotlegs.spring.cafe.signal.action.CancelFoodOrderSignal;
	import com.dborisenko.robotlegs.spring.cafe.signal.notification.OrderPriceChangeSignal;
	import com.dborisenko.robotlegs.spring.cafe.view.component.IOrderedFoodView;
	import com.dborisenko.robotlegs.spring.cafe.view.component.event.FoodEvent;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class OrderedFoodMediator extends CafeMediator
	{
		//--------------------------------------------------------------------------
		//  Injections
		//--------------------------------------------------------------------------
		
		[Inject]
		public var view:IOrderedFoodView;
		
		[Inject]
		public var cafeModel:ICafeModel;
		
		//--------------------------------------------------------------------------
		//  Action signals
		//--------------------------------------------------------------------------
		
		[Inject]
		public var cancelFoodOrferSignal:CancelFoodOrderSignal;
		
		//--------------------------------------------------------------------------
		//  Notification signals
		//--------------------------------------------------------------------------
		
		[Inject]
		public var orderPriceChangeSignal:OrderPriceChangeSignal;
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function OrderedFoodMediator()
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
				
				view.addEventListener(FoodEvent.PERFORM_CANCEL_ORDER, onPerformCancelOrderFood);
				orderPriceChangeSignal.add(onOrderPriceChange);
				
				view.orderedFood = cafeModel.orderedFood;
				view.orderPrice = cafeModel.orderPrice;
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
				
				view.removeEventListener(FoodEvent.PERFORM_CANCEL_ORDER, onPerformCancelOrderFood);
				orderPriceChangeSignal.remove(onOrderPriceChange);
				
				view.orderedFood = null;
			}
		}
		
		override public function onRemove():void
		{
			destroy();
		}
		
		//--------------------------------------------------------------------------
		//  View event handlers
		//--------------------------------------------------------------------------
		
		protected function onPerformCancelOrderFood(event:FoodEvent):void
		{
			var foodOrder:FoodOrder = event.data as FoodOrder;
			if (foodOrder)
			{
				cancelFoodOrferSignal.dispatch(foodOrder);
			}
		}
		
		//--------------------------------------------------------------------------
		//  Notification signals handlers
		//--------------------------------------------------------------------------
		
		protected function onOrderPriceChange():void
		{
			view.orderPrice = cafeModel.orderPrice;
		}
	}
}