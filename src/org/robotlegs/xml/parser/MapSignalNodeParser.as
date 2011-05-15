package org.robotlegs.xml.parser
{
	import mx.rpc.AbstractOperation;
	import mx.utils.StringUtil;
	
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.lang.IllegalArgumentError;
	import org.as3commons.lang.StringUtils;
	import org.robotlegs.base.SignalCommandMapper;
	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.xml.RobotlegsNamespaceHandler;
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
	public class MapSignalNodeParser extends AbstractObjectDefinitionParser
	{
		public function MapSignalNodeParser()
		{
		}
		
		override protected function parseInternal(node:XML, context:XMLObjectDefinitionsParser):IObjectDefinition {
			var builder:ObjectDefinitionBuilder = ObjectDefinitionBuilder.objectDefinitionForClass(SignalCommandMapper);
			builder.objectDefinition.isLazyInit = false;
			builder.objectDefinition.dependsOn = context.applicationContext.getObjectNamesForType(ISignalCommandMap);
			
			var signalRef:RuntimeObjectReference = RobotlegsNamespaceHandler.refOrNull(node, RobotlegsNamespaceHandler.SIGNAL_REF_ATTR);
			if (signalRef)
			{
				builder.addConstructorArgValue(signalRef);
			}
			else
			{
				var signalClassName:String = node.attribute(RobotlegsNamespaceHandler.SIGNAL_CLASS_ATTR);
				Assert.hasText(signalClassName);
				var signalClass:Class = ClassUtils.forName(signalClassName);
				builder.addConstructorArgValue(signalClass);
			}
			
			var commandClassName:String = node.attribute(RobotlegsNamespaceHandler.COMMAND_CLASS_ATTR);
			Assert.hasText(commandClassName, "Attribute command-class is required");
			var commandClass:Class = ClassUtils.forName(commandClassName);
			builder.addConstructorArgValue(commandClass);
			
			var oneShot:Boolean = (node.attribute(RobotlegsNamespaceHandler.ONE_SHOT_ATTR).text().toString() == "true");
			builder.addConstructorArgValue(oneShot);
			
			return builder.objectDefinition;
		}

	}
}