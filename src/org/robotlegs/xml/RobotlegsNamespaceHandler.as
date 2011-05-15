package org.robotlegs.xml
{
	import org.as3commons.lang.StringUtils;
	import org.robotlegs.robotlegs_spring_actionscript;
	import org.robotlegs.xml.parser.MapSignalNodeParser;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.factory.config.RuntimeObjectReference;
	import org.springextensions.actionscript.ioc.factory.xml.NamespaceHandlerSupport;
	import org.springextensions.actionscript.ioc.factory.xml.parser.support.XMLObjectDefinitionsParser;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class RobotlegsNamespaceHandler extends NamespaceHandlerSupport
	{
		public function RobotlegsNamespaceHandler()
		{
			super(robotlegs_spring_actionscript);
			init();
		}
		
		private var _preprocessed:Boolean = false;
		
		public static const MAP_SIGNAL_ELEM:String = "map-signal";
		
		public static const SIGNAL_CLASS_ATTR:String = "signal-class";
		public static const SIGNAL_REF_ATTR:String = "signal-ref";
		public static const COMMAND_CLASS_ATTR:String = "command-class";
		public static const ONE_SHOT_ATTR:String = "one-shot";
		
		public static const MAP_VIEW_ELEM:String = "map-view";
		
		public static const VIEW_CLASS_ATTR:String = "view-class";
		public static const MEDIATOR_CLASS_ATTR:String = "mediator-class";
		public static const INJECT_VIEW_AS_ATTR:String = "inject-view-as";
		public static const AUTO_CREATE_ATTR:String = "auto-create";
		public static const AUTO_REMOVE_ATTR:String = "auto-remove";

		protected function init():void {
			registerObjectDefinitionParser(MAP_SIGNAL_ELEM, new MapSignalNodeParser());
		}
		
		/**
		 * <p>When invoked for the first time this method will create a <code>TaskElementsPreprocessor</code> and preprocess
		 * the incoming <code>XML</code>.</p>
		 * @see org.springextensions.actionscript.core.task.xml.TaskElementsPreprocessor TaskElementsPreprocessor
		 * @inheritDoc
		 */
		override public function parse(node:XML, parser:XMLObjectDefinitionsParser):IObjectDefinition {
			if (!_preprocessed) {
				new RobotlegsElementsPreprocessor().preprocess(getRoot(node));
				_preprocessed = true;
			}
			for each (var subNode:XML in node.descendants()) {
				parser.parseNode(subNode);
			}
			return super.parse(node, parser);
		}
		
		/**
		 * Returns the root node for the specified <code>XML</code> node by recursively retrieving the parent node.
		 * @param xml The specified <code>XML</code> node
		 * @return The root node
		 */
		public function getRoot(xml:XML):XML {
			while (xml.parent() != null) {
				xml = xml.parent();
			}
			return xml;
		}
		
		public static function refOrNull(node:XML, attributeName:String):RuntimeObjectReference {
			var attr:String = node.attribute(attributeName);
			if (StringUtils.hasText(attr)) {
				return new RuntimeObjectReference(attr);
			} else {
				return null;
			}
		}
		
	}
}