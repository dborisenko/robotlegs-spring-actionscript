package org.robotlegs.base
{
	import org.as3commons.lang.Assert;
	import org.osflash.signals.ISignal;
	import org.robotlegs.core.ISignalCommandMap;
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class SignalCommandMapper implements IApplicationContextAware
	{
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
		
		public function SignalCommandMapper(signalOrSignalClass:Object, commandClass:Class, oneShot:Boolean=false, startup:Boolean=false)
		{
			Assert.notNull(signalOrSignalClass);
			Assert.notNull(commandClass);
			
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
		
		protected function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var signalCommandMap:ISignalCommandMap;
				var obj:Object = applicationContext.getObjectsOfType(ISignalCommandMap);
				if (obj is ISignalCommandMap)
				{
					signalCommandMap = obj as ISignalCommandMap;
				}
				else 
				{
					for each (var item:Object in obj)
					{
						if (item is ISignalCommandMap)
						{
							signalCommandMap = item as ISignalCommandMap;
							break;
						}
					}
				}
				
				if (!signalCommandMap)
				{
					throw new Error("Cannot receive object of type [ISignalCommandMap] from context");
				}
				
				if (signal)
				{
					signalCommandMap.mapSignal(signal, commandClass, oneShot);
				}
				else if (signalClass)
				{
					signalCommandMap.mapSignalClass(signalClass, commandClass, oneShot);
				}
			}
		}
	}
}