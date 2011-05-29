package org.robotlegs.spring.ioc.xml.factory.parser
{
	import org.as3commons.lang.Assert;
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.lang.StringUtils;
	import org.robotlegs.spring.mapper.AbstractContextMapper;
	import org.robotlegs.spring.mapper.MediatorMapper;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.spring.ioc.xml.factory.RobotlegsNamespaceHandler;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.factory.support.ObjectDefinitionBuilder;
	import org.springextensions.actionscript.ioc.factory.xml.AbstractObjectDefinitionParser;
	import org.springextensions.actionscript.ioc.factory.xml.parser.support.XMLObjectDefinitionsParser;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class MapViewNodeParser extends AbstractMapperNodeParser
	{
		public function MapViewNodeParser()
		{
		}
		
		override protected function buildMapper(node:XML, context:XMLObjectDefinitionsParser):AbstractContextMapper
		{
			var viewClass:String = node.attribute(RobotlegsNamespaceHandler.VIEW_CLASS_ATTR);
			Assert.hasText(viewClass);
			
			var mediatorClass:String = node.attribute(RobotlegsNamespaceHandler.MEDIATOR_CLASS_ATTR);
			Assert.hasText(mediatorClass);
			
			var injectViewAs:String = node.attribute(RobotlegsNamespaceHandler.INJECT_VIEW_AS_ATTR);
			var injectViewAsClass:Class;
			if (StringUtils.hasText(injectViewAs))
			{
				injectViewAsClass = ClassUtils.forName(injectViewAs);
			}
			
			var autoCreate:Boolean = (node.attribute(RobotlegsNamespaceHandler.AUTO_CREATE_ATTR).text().toString() != "false");
			
			var autoRemove:Boolean = (node.attribute(RobotlegsNamespaceHandler.AUTO_REMOVE_ATTR).text().toString() != "false");
			
			return new MediatorMapper(ClassUtils.forName(viewClass), ClassUtils.forName(mediatorClass), injectViewAsClass, autoCreate, autoRemove);
		}

	}
}