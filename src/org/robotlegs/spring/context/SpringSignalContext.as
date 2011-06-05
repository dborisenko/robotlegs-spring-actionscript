package org.robotlegs.spring.context
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.SignalContext;
	import org.robotlegs.spring.injector.SpringActionscriptInjector;
	import org.robotlegs.spring.ioc.autowire.IgnoreErrorAutowireProcessor;
	import org.robotlegs.spring.ioc.xml.factory.RobotlegsNamespaceHandler;
	import org.robotlegs.spring.signal.StartupSignal;
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
		//--------------------------------------------------------------------------
		//  Constaints
		//--------------------------------------------------------------------------
		
		public static const SPRING_CONTEXT_TYPE_XML:String = "xml";
		public static const SPRING_CONTEXT_TYPE_FLEX:String = "flex";
		
		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		
		protected var _springContext:XMLApplicationContext;
		protected var _configs:ArrayCollection = new ArrayCollection();
		protected var _isConfigurable:Boolean = false;
		
		//--------------------------------------------------------------------------
		//  Injections
		//--------------------------------------------------------------------------
		
		[Inject]
		public var startupSignal:StartupSignal;
		
		//--------------------------------------------------------------------------
		//  springContextType
		//--------------------------------------------------------------------------
		
		private var _springContextType:String;
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
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function SpringSignalContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			springContextType = SPRING_CONTEXT_TYPE_FLEX;
			super(contextView, autoStartup);
		}
		
		//--------------------------------------------------------------------------
		//  config
		//--------------------------------------------------------------------------
		
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
			addConfig(value);
		}
		
		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		
		public function addConfig(config:Object):void
		{
			if (_configs.contains(config))
			{
				return;
			}
			
			_isConfigurable = true;
			if (config is XML)
			{
				springContext.addConfig(config as XML);
				_configs.addItem(config);
			}
			else if (config is Class)
			{
				springContext.addEmbeddedConfig(config as Class);
				_configs.addItem(config);
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
				_configs.addItem(config);
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
		
		//--------------------------------------------------------------------------
		//  Overriden methods
		//--------------------------------------------------------------------------
		
		override public function startup():void
		{
			if (_isConfigurable)
			{
				_springContext.addEventListener(Event.COMPLETE, onApplicationConfigLoaded);
				springContext.load();
			}
			else
			{
				doStartup();
			}
		}
		
		override protected function createInjector():IInjector
		{
			var injector:IInjector = new SpringActionscriptInjector(springContext);
			injector.applicationDomain = getApplicationDomainFromContextView();
			return injector;
		}
		
		//--------------------------------------------------------------------------
		//  Protected methods and properties
		//--------------------------------------------------------------------------
		
		protected function get springContext():XMLApplicationContext
		{
			return _springContext;
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
			context.autowireProcessor = new IgnoreErrorAutowireProcessor(context);
			return context;
		}
		
		protected function doStartup():void
		{
			super.startup();
			injector.mapSingleton(StartupSignal);
			injector.mapValue(IContext, this);
			injector.injectInto(this);
			startupSignal.dispatch();
		}
		
		//--------------------------------------------------------------------------
		//  Event Handlers
		//--------------------------------------------------------------------------
		
		protected function onApplicationConfigLoaded(event:Event):void
		{
			_springContext.removeEventListener(Event.COMPLETE, onApplicationConfigLoaded);
			doStartup();
		}
	}
}