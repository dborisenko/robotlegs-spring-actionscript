package org.robotlegs.xml.parser
{
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.ClassUtils;
	import org.robotlegs.base.MediatorMapper;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.xml.RobotlegsNamespaceHandler;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.factory.support.ObjectDefinitionBuilder;
	import org.springextensions.actionscript.ioc.factory.xml.AbstractObjectDefinitionParser;
	import org.springextensions.actionscript.ioc.factory.xml.parser.support.XMLObjectDefinitionsParser;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class MapViewNodeParser extends AbstractObjectDefinitionParser
	{
		public function MapViewNodeParser()
		{
		}
		
		override protected function parseInternal(node:XML, context:XMLObjectDefinitionsParser):IObjectDefinition {
			var builder:ObjectDefinitionBuilder = ObjectDefinitionBuilder.objectDefinitionForClass(MediatorMapper);
			builder.objectDefinition.isLazyInit = false;
			builder.objectDefinition.dependsOn = context.applicationContext.getObjectNamesForType(IMediatorMap);
			
			var viewClass:String = node.attribute(RobotlegsNamespaceHandler.VIEW_CLASS_ATTR);
			Assert.hasText(viewClass);
			builder.addConstructorArgValue(ClassUtils.forName(viewClass));
			
			var mediatorClass:String = node.attribute(RobotlegsNamespaceHandler.MEDIATOR_CLASS_ATTR);
			Assert.hasText(mediatorClass);
			builder.addConstructorArgValue(ClassUtils.forName(mediatorClass));
			
			var injectViewAs:String = node.attribute(RobotlegsNamespaceHandler.INJECT_VIEW_AS_ATTR);
			builder.addConstructorArgValue(ClassUtils.forName(injectViewAs));
			
			var autoCreate:Boolean = (node.attribute(RobotlegsNamespaceHandler.AUTO_CREATE_ATTR).text().toString() == "true");
			builder.addConstructorArgValue(autoCreate);
			
			var autoRemove:Boolean = (node.attribute(RobotlegsNamespaceHandler.AUTO_REMOVE_ATTR).text().toString() == "true");
			builder.addConstructorArgValue(autoRemove);
			
			return builder.objectDefinition;
		}

	}
}