package org.robotlegs.base
{
	import org.as3commons.lang.Assert;
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
		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		
		protected var mapped:Boolean = false;
		
		public var viewClass:Object;
		public var mediatorClass:Class;
		public var injectViewAs:Object;
		public var autoCreate:Boolean = true;
		public var autoRemove:Boolean = true;
		
		//--------------------------------------------------------------------------
		//  IApplicationContextAware implementation
		//--------------------------------------------------------------------------
		
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
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function MediatorMapper(viewClass:Object, mediatorClass:Class, 
									   injectViewAs:Object = null, autoCreate:Boolean = true, autoRemove:Boolean = true)
		{
			Assert.notNull(viewClass);
			Assert.notNull(mediatorClass);
			
			this.viewClass = viewClass;
			this.mediatorClass = mediatorClass;
			this.injectViewAs = injectViewAs;
			this.autoCreate = autoCreate;
			this.autoRemove = autoRemove;
		}
		
		//--------------------------------------------------------------------------
		//  map
		//--------------------------------------------------------------------------
		
		protected function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var mediatorMap:IMediatorMap;
				var obj:Object = applicationContext.getObjectsOfType(IMediatorMap);
				if (obj is IMediatorMap)
				{
					mediatorMap = obj as IMediatorMap;
				}
				else 
				{
					for each (var item:Object in obj)
					{
						if (item is IMediatorMap)
						{
							mediatorMap = item as IMediatorMap;
							break;
						}
					}
				}
				
				if (!mediatorMap)
				{
					throw new Error("Cannot receive object of type [ISignalCommandMap] from context");
				}
				
				mediatorMap.mapView(viewClass, mediatorClass, injectViewAs, autoCreate, autoRemove);
			}
		}
		
	}
}