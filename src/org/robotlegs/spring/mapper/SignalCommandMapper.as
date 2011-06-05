package org.robotlegs.spring.mapper
{
	import org.as3commons.lang.Assert;
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.osflash.signals.ISignal;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.ISignalCommandMap;
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class SignalCommandMapper extends AbstractContextMapper
	{
		//--------------------------------------------------------------------------
		//  Logger
		//--------------------------------------------------------------------------
		
		private var logger:ILogger = LoggerFactory.getClassLogger(SignalCommandMapper);
		
		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		
		protected var mapped:Boolean = false;
		
		public var signal:ISignal;
		public var signalClass:Class;
		public var commandClass:Class;
		public var oneShot:Boolean = false;
		public var startup:Boolean = false;
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function SignalCommandMapper(signalOrSignalClass:Object, commandClass:Class, oneShot:Boolean=false, startup:Boolean=false)
		{
			logger.debug("mapping signal [{0}] and command [{1}]", signalOrSignalClass, commandClass);
			
			if (signalOrSignalClass is ISignal)
			{
				this.signal = signalOrSignalClass as ISignal;
			}
			else if (signalOrSignalClass is Class)
			{
				this.signalClass = signalOrSignalClass as Class;
			}
			this.commandClass = commandClass;
			this.oneShot = oneShot;
			this.startup = startup;
		}
		
		//--------------------------------------------------------------------------
		//  map
		//--------------------------------------------------------------------------
		
		override public function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var signalCommandMap:ISignalCommandMap = getObjectFromContext(ISignalCommandMap) as ISignalCommandMap;
				var injector:IInjector = getObjectFromContext(IInjector) as IInjector;
				
				if (!signalCommandMap)
				{
					throw new Error("Cannot receive object of type [ISignalCommandMap] from context");
				}
				
				if (commandClass)
				{
					if (signal)
					{
						signalCommandMap.mapSignal(signal, commandClass, oneShot);
					}
					else if (signalClass)
					{
						signalCommandMap.mapSignalClass(signalClass, commandClass, oneShot);
					}
				}
				else
				{
					if (signalClass)
					{
						injector.mapSingleton(signalClass);
					}
				}
			}
		}
	}
}