package org.robotlegs.base
{
	import org.robotlegs.core.IMediatorMap;
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class MediatorMapper implements IApplicationContextAware
	{
		protected var mapped:Boolean = false;
		
		public var viewClass:Object;
		public var mediatorClass:Class;
		public var injectViewAs:Object;
		public var autoCreate:Boolean = true;
		public var autoRemove:Boolean = true;
		
		private var _applicationContext:IApplicationContext;
		public function get applicationContext():IApplicationContext
		{
			return _applicationContext;
		}
		public function set applicationContext(value:IApplicationContext):void
		{
			_applicationContext = value;
			map();
		}
		
		public function MediatorMapper(viewClass:*, mediatorClass:Class, 
									   injectViewAs:* = null, autoCreate:Boolean = true, autoRemove:Boolean = true)
		{
			this.viewClass = viewClass;
			this.mediatorClass = mediatorClass;
			this.injectViewAs = injectViewAs;
			this.autoCreate = autoCreate;
			this.autoRemove = autoRemove;
		}
		
		protected function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var mediatorMap:IMediatorMap = applicationContext.getObjectsOfType(IMediatorMap) as IMediatorMap;
				mediatorMap.mapView(viewClass, mediatorClass, injectViewAs, autoCreate, autoRemove);
			}
		}
		
	}
}