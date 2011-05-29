package org.robotlegs.xml.parser
{
	import flash.errors.IllegalOperationError;
	
	import org.robotlegs.base.IContextMapper;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.factory.xml.AbstractObjectDefinitionParser;
	import org.springextensions.actionscript.ioc.factory.xml.parser.support.XMLObjectDefinitionsParser;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class AbstractMapperNodeParser extends AbstractObjectDefinitionParser
	{
		public function AbstractMapperNodeParser()
		{
		}
		
		override protected function parseInternal(node:XML, context:XMLObjectDefinitionsParser):IObjectDefinition {
			
			var mapper:IContextMapper = buildMapper(node, context);
			mapper.applicationContext = context.applicationContext;
			mapper.map();
			
			return null;
		}
		
		protected function buildMapper(node:XML, context:XMLObjectDefinitionsParser):IContextMapper
		{
			throw new IllegalOperationError("Method must be implemented in subclasses");
		}
	}
}