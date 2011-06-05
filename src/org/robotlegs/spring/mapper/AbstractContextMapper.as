package org.robotlegs.spring.mapper
{
	import flash.errors.IllegalOperationError;
	
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class AbstractContextMapper implements IApplicationContextAware
	{
		public function map():void
		{
			throw new IllegalOperationError("Method must be implemented in subclasses");
		}
		
		protected function getObjectFromContext(clazz:Class):Object
		{
			var result:Object;
			var obj:Object = applicationContext.getObjectsOfType(clazz);
			if (obj is clazz)
			{
				result = obj;
			}
			else 
			{
				for each (var item:Object in obj)
				{
					if (item is clazz)
					{
						result = item;
						break;
					}
				}
			}
			return result;
		}
		
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
		}
				
	}
}