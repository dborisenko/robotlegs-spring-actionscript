package com.dborisenko.robotlegs.spring.cafe.data
{
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.IllegalArgumentError;

	[Bindable]
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class Food
	{
		//--------------------------------------------------------------------------
		//  iconSource
		//--------------------------------------------------------------------------
		
		private var _iconSource:Object;
		
		public function get iconSource():Object
		{
			return _iconSource;
		}
		public function set iconSource(value:Object):void
		{
			_iconSource = value;
		}
		
		//--------------------------------------------------------------------------
		//  name
		//--------------------------------------------------------------------------
		
		private var _name:String;

		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			Assert.hasText(value, "Name is required");
			_name = value;
		}
		
		//--------------------------------------------------------------------------
		//  cost
		//--------------------------------------------------------------------------
		
		private var _cost:Number;

		public function get cost():Number
		{
			return _cost;
		}
		public function set cost(value:Number):void
		{
			Assert.isTrue(value >= 0, "Cost must be >= 0");
			_cost = value;
		}
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function Food(name:String, cost:Number, iconSource:Object=null)
		{
			this.name = name;
			this.cost = cost;
			this.iconSource = iconSource;
		}
	}
}