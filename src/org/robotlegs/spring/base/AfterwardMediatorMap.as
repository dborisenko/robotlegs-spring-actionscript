package org.robotlegs.spring.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class AfterwardMediatorMap extends MediatorMap
	{
		public var mapExistedView:Boolean = true;
		
		public function AfterwardMediatorMap(contextView:DisplayObjectContainer, injector:IInjector, 
											 reflector:IReflector, mapExistedView:Boolean=true)
		{
			super(contextView, injector, reflector);
			this.mapExistedView = mapExistedView;
		}
		
		override public function mapView(viewClassOrName:*, mediatorClass:Class, injectViewAs:*=null, 
										 autoCreate:Boolean=true, autoRemove:Boolean=true):void
		{
			super.mapView(viewClassOrName, mediatorClass, injectViewAs, autoCreate, autoRemove);
			
			if (mapExistedView && contextView && autoCreate)
			{
				mapViewChildren(contextView);
			}
		}
		
		protected function mapViewChildren(view:DisplayObject):void
		{
			createMediator(view);
			if (view is DisplayObjectContainer && DisplayObjectContainer(view).numChildren > 0)
			{
				for (var i:int = 0; i < DisplayObjectContainer(view).numChildren; i++)
				{
					mapViewChildren(DisplayObjectContainer(view).getChildAt(i));
				}
			}
		}
	}
}