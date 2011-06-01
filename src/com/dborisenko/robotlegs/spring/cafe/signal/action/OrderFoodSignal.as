package com.dborisenko.robotlegs.spring.cafe.signal.action
{
	import com.dborisenko.robotlegs.spring.cafe.data.Food;
	
	import org.osflash.signals.Signal;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class OrderFoodSignal extends Signal
	{
		public function OrderFoodSignal()
		{
			super(Food);
		}
	}
}