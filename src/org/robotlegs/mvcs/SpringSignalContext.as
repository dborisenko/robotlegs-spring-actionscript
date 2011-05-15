package org.robotlegs.mvcs
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import org.robotlegs.adapters.SpringActionscriptInjector;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.xml.RobotlegsNamespaceHandler;
	import org.springextensions.actionscript.context.IConfigurableApplicationContext;
	import org.springextensions.actionscript.context.support.AbstractApplicationContext;
	import org.springextensions.actionscript.context.support.FlexXMLApplicationContext;
	import org.springextensions.actionscript.context.support.MXMLApplicationContext;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;
	
	import spark.components.mediaClasses.VolumeBar;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class SpringSignalContext extends SignalContext
	{
		public static const SPRING_CONTEXT_TYPE_XML:String = "xml";
		public static const SPRING_CONTEXT_TYPE_FLEX:String = "flex";
		
		protected var _springContext:XMLApplicationContext;
		protected var _configs:ArrayCollection = new ArrayCollection();
		protected var _isConfigurable:Boolean = false;
		
		private var _springContextType:String = SPRING_CONTEXT_TYPE_FLEX;
		[Inspectable(enumeration="xml,flex", defaultValue="flex")]
		public function get springContextType():String
		{
			return _springContextType;
		}
		public function set springContextType(value:String):void
		{
			if (value == _springContextType)
				return;
			_springContextType = value;
			_springContext = createSpringContext();
			addConfig(_configs);
		}
		
		public function SpringSignalContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			_springContext = createSpringContext();
			super(contextView, autoStartup);
		}
		
		public function get config():Object
		{
			if (_configs.length == 0)
			{
				return null;
			}
			else if (_configs.length == 1)
			{
				return _configs.getItemAt(0);
			}
			return _configs;
		}
		public function set config(value:Object):void
		{
			_configs.addItem(value);
			addConfig(value);
		}
		
		public function addConfig(config:Object):void
		{
			_isConfigurable = true;
			if (config is XML)
			{
				springContext.addConfig(config as XML);
			}
			else if (config is Class)
			{
				springContext.addEmbeddedConfig(config as Class);
			}
			else if (config is String)
			{
				var s:String = config as String;
				if (s.indexOf("<") == 0)
				{
					addConfig(new XML(s));
				}
				else
				{
					springContext.addConfigLocation(config as String);
				}
			}
			else if (config is ArrayCollection)
			{
				var ac:ArrayCollection = config as ArrayCollection;
				for (var i:int = 0; i < ac.length; i++)
				{
					addConfig(ac.getItemAt(i));
				}
			}
			else if (config is Array)
			{
				addConfig(new ArrayCollection(config as Array));
			}
		}
		
		protected function get springContext():XMLApplicationContext
		{
			return _springContext;
		}
		
		protected function onApplicationConfigLoaded(event:Event):void
		{
			_springContext.removeEventListener(Event.COMPLETE, onApplicationConfigLoaded);
			super.startup();
		}
		
		override public function startup():void
		{
			if (_isConfigurable)
			{
				_springContext.addEventListener(Event.COMPLETE, onApplicationConfigLoaded);
				springContext.load();
			}
			else
			{
				super.startup();
			}
		}
		
		override protected function createInjector():IInjector
		{
			var injector:IInjector = new SpringActionscriptInjector(springContext);
			injector.applicationDomain = getApplicationDomainFromContextView();
			return injector;
		}
		
		protected function createSpringContext():XMLApplicationContext
		{
			var context:XMLApplicationContext;
			switch(springContextType)
			{
				case SPRING_CONTEXT_TYPE_XML:
					context = new XMLApplicationContext();
				case SPRING_CONTEXT_TYPE_FLEX:
				default:
					context = new FlexXMLApplicationContext();
			}
			context.addNamespaceHandler(new RobotlegsNamespaceHandler());
			return context;
		}
	}
}