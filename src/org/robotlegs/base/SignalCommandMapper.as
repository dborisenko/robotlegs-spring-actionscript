package org.robotlegs.base
{
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
		protected var mapped:Boolean = false;
		
		public var signal:ISignal;
		public var signalClass:Class;
		public var commandClass:Class;
		public var oneShot:Boolean = false

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
		
		public function SignalCommandMapper(signalOrSignalClass:Object, commandClass:Class, oneShot:Boolean=false)
		{
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
		}
		
		protected function map():void
		{
			if (!mapped)
			{
				mapped = true;
				var signalCommandMap:ISignalCommandMap = applicationContext.getObjectsOfType(ISignalCommandMap) as ISignalCommandMap;
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