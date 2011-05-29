package org.robotlegs.spring.ioc.autowire
{
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.reflect.Field;
	import org.as3commons.reflect.MetaData;
	import org.springextensions.actionscript.ioc.autowire.DefaultAutowireProcessor;
	import org.springextensions.actionscript.ioc.factory.IObjectFactory;
	import org.springextensions.actionscript.ioc.factory.support.UnsatisfiedDependencyError;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class IgnoreErrorAutowireProcessor extends DefaultAutowireProcessor
	{
		protected var logger:ILogger = LoggerFactory.getClassLogger(IgnoreErrorAutowireProcessor);
		
		public function IgnoreErrorAutowireProcessor(objectFactory:IObjectFactory)
		{
			super(objectFactory);
		}
		
		override protected function autoWireField(object:Object, field:Field, objectName:String):void {
			try
			{
				super.autoWireField(object, field, objectName);
			}
			catch (err:Error)
			{
				var msg:String = err.message.toString();
				msg = msg.substr(0, msg.indexOf("\n"));
				logger.debug("Error while autowiring property {1} of object {0}: " + msg , field.name, objectName);
			}
		}
	}
}