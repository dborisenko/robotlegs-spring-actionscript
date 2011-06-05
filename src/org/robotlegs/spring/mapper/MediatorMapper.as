package org.robotlegs.spring.mapper
{
	import org.as3commons.lang.Assert;
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.robotlegs.core.IMediatorMap;
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class MediatorMapper extends AbstractContextMapper
	{
		//--------------------------------------------------------------------------
		//  Logger
		//--------------------------------------------------------------------------
		
		protected var logger:ILogger = LoggerFactory.getClassLogger(AbstractContextMapper);
		
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
		
		override public function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var mediatorMap:IMediatorMap = getObjectFromContext(IMediatorMap) as IMediatorMap;
				
				if (!mediatorMap)
				{
					throw new Error("Cannot receive object of type [IMediatorMap] from context");
				}
				
				logger.debug("Mapping view [" + viewClass + "] as [" + injectViewAs + "] with mediator [" + mediatorClass + "]");
				mediatorMap.mapView(viewClass, mediatorClass, injectViewAs, autoCreate, autoRemove);
			}
		}
		
	}
}