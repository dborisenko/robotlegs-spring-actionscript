package org.robotlegs.spring.ioc.xml.factory.parser
{
	import mx.rpc.AbstractOperation;
	import mx.utils.StringUtil;
	
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.lang.IllegalArgumentError;
	import org.as3commons.lang.StringUtils;
	import org.osflash.signals.Signal;
	import org.robotlegs.spring.mapper.AbstractContextMapper;
	import org.robotlegs.spring.mapper.SignalCommandMapper;
	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.spring.ioc.xml.factory.RobotlegsNamespaceHandler;
	import org.springextensions.actionscript.context.IApplicationContext;
	import org.springextensions.actionscript.context.IApplicationContextAware;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.factory.config.RuntimeObjectReference;
	import org.springextensions.actionscript.ioc.factory.support.ObjectDefinitionBuilder;
	import org.springextensions.actionscript.ioc.factory.xml.AbstractObjectDefinitionParser;
	import org.springextensions.actionscript.ioc.factory.xml.parser.support.XMLObjectDefinitionsParser;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class MapSignalNodeParser extends AbstractMapperNodeParser
	{
		public function MapSignalNodeParser()
		{
		}
		
		override protected function buildMapper(node:XML, context:XMLObjectDefinitionsParser):AbstractContextMapper 
		{
			
			var signalOrSignalClass:Object;
			var signalRef:RuntimeObjectReference = RobotlegsNamespaceHandler.refOrNull(node, RobotlegsNamespaceHandler.SIGNAL_REF_ATTR);
			if (signalRef)
			{
				signalOrSignalClass = signalRef;
			}
			else
			{
				var signalClassName:String = node.attribute(RobotlegsNamespaceHandler.SIGNAL_CLASS_ATTR);
				var signalClass:Class = ClassUtils.forName(signalClassName);
				signalOrSignalClass = signalClass;
			}
			
			var commandClass:Class;
			var commandClassName:String = node.attribute(RobotlegsNamespaceHandler.COMMAND_CLASS_ATTR);
			if (commandClassName)
			{
				commandClass = ClassUtils.forName(commandClassName);
			}
			
			var oneShot:Boolean = (node.attribute(RobotlegsNamespaceHandler.ONE_SHOT_ATTR).text().toString() == "true");
			
			var startup:Boolean = (node.attribute(RobotlegsNamespaceHandler.STARTUP_ATTR).text().toString() == "true");
			
			return new SignalCommandMapper(signalOrSignalClass, commandClass, oneShot, startup);
		}

	}
}