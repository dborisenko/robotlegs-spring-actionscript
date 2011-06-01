package com.dborisenko.robotlegs.spring.cafe.signal.action
{
	import com.dborisenko.robotlegs.spring.cafe.data.FoodOrder;
	
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class CancelFoodOrderSignal extends Signal
	{
		public function CancelFoodOrderSignal()
		{
			super(FoodOrder);
		}
	}
}