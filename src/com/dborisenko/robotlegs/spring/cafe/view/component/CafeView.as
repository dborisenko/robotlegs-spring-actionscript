package com.dborisenko.robotlegs.spring.cafe.view.component
{
	import spark.components.supportClasses.SkinnableComponent;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class CafeView extends SkinnableComponent
	{
		//--------------------------------------------------------------------------
		//  Skin parts
		//--------------------------------------------------------------------------
		
		[SkinPart(required="false")]
		public var foodControls:IFoodControlsView;
		
		[SkinPart(required="false")]
		public var orderedFood:IOrderedFoodView;
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function CafeView()
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
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}