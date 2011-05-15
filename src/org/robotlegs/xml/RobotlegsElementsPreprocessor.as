package org.robotlegs.xml
{
	import flash.utils.Dictionary;
	
	import mx.utils.UIDUtil;
	
	import org.springextensions.actionscript.ioc.factory.xml.parser.IXMLObjectDefinitionsPreprocessor;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class RobotlegsElementsPreprocessor implements IXMLObjectDefinitionsPreprocessor
	{
		private var _nodeFunctions:Dictionary;
		
		public function RobotlegsElementsPreprocessor()
		{
			init();
		}
		
		protected function init():void {
			_nodeFunctions = new Dictionary();
			_nodeFunctions[RobotlegsNamespaceHandler.MAP_SIGNAL_ELEM] = preprocessMapSignalElement;
		}
		
		public function preprocess(xml:XML):XML {
			var objectNodes:XMLList = xml.descendants();
			
			for each (var node:XML in objectNodes) {
				var name:String = String(node.localName());
				if (_nodeFunctions[name] != null) {
					node = preprocessNode(node);
				}
			}
			return xml;
		}
		
		public function preprocessNode(node:XML):XML {
			var func:Function = _nodeFunctions[String(node.localName())] as Function;
			if (func != null) {
				return func(node);
			} else {
				throw new Error("No preprocess function found for " + String(node.localName()));
			}
		}

		public function preprocessMapSignalElement(node:XML):XML {
			return setMissingID(node);
		}
		
		protected function setMissingID(node:XML):XML {
			if (node.@id == undefined) {
				node.@id = UIDUtil.createUID();
			}
			return node;
		}
	}
}