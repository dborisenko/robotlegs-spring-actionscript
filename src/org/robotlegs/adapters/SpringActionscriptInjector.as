package org.robotlegs.adapters
{
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import org.as3commons.lang.ClassUtils;
	import org.as3commons.lang.StringUtils;
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.robotlegs.core.IInjector;
	import org.springextensions.actionscript.context.support.AbstractApplicationContext;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.ObjectDefinition;
	import org.springextensions.actionscript.ioc.ObjectDefinitionScope;
	import org.springextensions.actionscript.ioc.factory.support.AbstractObjectFactory;
	import org.springextensions.actionscript.ioc.factory.support.IObjectDefinitionRegistry;
	import org.springextensions.actionscript.ioc.factory.support.ObjectDefinitionBuilder;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class SpringActionscriptInjector implements IInjector
	{
		//--------------------------------------------------------------------------
		//  Logger
		//--------------------------------------------------------------------------
		
		protected var logger:ILogger = LoggerFactory.getClassLogger(SpringActionscriptInjector);
		
		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------
		
		protected var springContext:AbstractApplicationContext;
		
		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		
		public function SpringActionscriptInjector(springContext:AbstractApplicationContext)
		{
			this.springContext = springContext;
		}
		
		//--------------------------------------------------------------------------
		//  Map methods
		//--------------------------------------------------------------------------
		
		public function mapValue(whenAskedFor:Class, useValue:Object, named:String=""):*
		{
			if (useValue)
			{
				var name:String = getName(whenAskedFor, named);
				springContext.registerSingleton(name, useValue);
				logger.debug("mapping value (registerSingleton) [{0}]", name);
			}
			return null;
		}
		
		public function mapClass(whenAskedFor:Class, instantiateClass:Class, named:String=""):*
		{
			var def:IObjectDefinition = createObjectDefinitionForClass(instantiateClass);
			def.scope = ObjectDefinitionScope.PROTOTYPE;
			var name:String = getName(whenAskedFor, named);
			springContext.registerObjectDefinition(name, def);
			logger.debug("mapping class (registerObjectDefinition) [{0}]", name);
			return null;
		}
		
		public function mapSingleton(whenAskedFor:Class, named:String=""):*
		{
			return mapSingletonOf(whenAskedFor, whenAskedFor, named);
		}
		
		public function mapSingletonOf(whenAskedFor:Class, useSingletonOf:Class, named:String=""):*
		{
			var name:String = getName(whenAskedFor, named);
			springContext.registerSingleton(name, instantiate(useSingletonOf));
			logger.debug("mapping singleton (registerSingleton) [{0}]", name);
			
//			var def:IObjectDefinition = createObjectDefinitionForClass(useSingletonOf);
//			def.scope = ObjectDefinitionScope.SINGLETON;
//			springContext.registerObjectDefinition(getName(whenAskedFor, named), def);
			return null;
		}
		
		public function mapRule(whenAskedFor:Class, useRule:*, named:String=""):*
		{
			throw new IllegalOperationError("Method is not supported");
		}
		
		//--------------------------------------------------------------------------
		//  Inject method
		//--------------------------------------------------------------------------
		
		public function injectInto(target:Object):void
		{
			springContext.wire(target);
		}
		
		//--------------------------------------------------------------------------
		//  Instance methods
		//--------------------------------------------------------------------------
		
		public function instantiate(clazz:Class):*
		{
			var instance:Object = ClassUtils.newInstance(clazz);
//			injectInto(instance);
			return instance;
		}
		
		public function getInstance(clazz:Class, named:String=""):*
		{
			return springContext.getObject(getName(clazz, named));
		}
		
		public function createChild(applicationDomain:ApplicationDomain=null):IInjector
		{
			var context:AbstractApplicationContext = new XMLApplicationContext();
			context.parent = springContext;
			context.registerSingleton(getName(IInjector), this);
			var injector:SpringActionscriptInjector = new SpringActionscriptInjector(context);
			return injector;
		}
		
		//--------------------------------------------------------------------------
		//  Mapping methods
		//--------------------------------------------------------------------------
		
		public function unmap(clazz:Class, named:String=""):void
		{
			springContext.removeObjectDefinition(getName(clazz, named));
		}
		
		public function hasMapping(clazz:Class, named:String=""):Boolean
		{
			var obj:Object = springContext.getObject(getName(clazz, named));
			return (obj != null);
		}
		
		//--------------------------------------------------------------------------
		//  applicationDomain
		//--------------------------------------------------------------------------
		
		public function get applicationDomain():ApplicationDomain
		{
			return springContext.applicationDomain;
		}
		
		public function set applicationDomain(value:ApplicationDomain):void
		{
			springContext.applicationDomain = value;
		}
		
		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------
		
		protected function getName(whenAskedFor:Class, named:String = ""):String
		{
			var requestName:String = getQualifiedClassName(whenAskedFor);
			return requestName + (StringUtils.hasText(named) ? ('#' + named) : "");
		}
		
		protected function createObjectDefinitionForClass(clazz:Class):IObjectDefinition 
		{
			var builder:ObjectDefinitionBuilder = ObjectDefinitionBuilder.objectDefinitionForClass(clazz);
			return builder.objectDefinition;
		}
	}
}