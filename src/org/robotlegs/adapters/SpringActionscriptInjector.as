package org.robotlegs.adapters
{
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import org.as3commons.lang.ClassUtils;
	import org.robotlegs.core.IInjector;
	import org.springextensions.actionscript.context.support.AbstractApplicationContext;
	import org.springextensions.actionscript.context.support.XMLApplicationContext;
	import org.springextensions.actionscript.ioc.IObjectDefinition;
	import org.springextensions.actionscript.ioc.ObjectDefinition;
	import org.springextensions.actionscript.ioc.ObjectDefinitionScope;
	import org.springextensions.actionscript.ioc.factory.support.AbstractObjectFactory;
	import org.springextensions.actionscript.ioc.factory.support.IObjectDefinitionRegistry;
	
	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public class SpringActionscriptInjector implements IInjector
	{
		protected var springContext:AbstractApplicationContext;
		
		public function SpringActionscriptInjector(springContext:AbstractApplicationContext)
		{
			this.springContext = springContext;
		}
		
		public function mapValue(whenAskedFor:Class, useValue:Object, named:String=""):*
		{
			if (useValue)
			{
				springContext.registerSingleton(getName(whenAskedFor, named), useValue);
			}
			return null;
		}
		
		public function mapClass(whenAskedFor:Class, instantiateClass:Class, named:String=""):*
		{
			var def:IObjectDefinition = createObjectDefinitionForClass(instantiateClass);
			def.scope = ObjectDefinitionScope.PROTOTYPE;
			springContext.registerObjectDefinition(getName(whenAskedFor, named), def);
			return null;
		}
		
		public function mapSingleton(whenAskedFor:Class, named:String=""):*
		{
			return mapSingletonOf(whenAskedFor, whenAskedFor, named);
		}
		
		public function mapSingletonOf(whenAskedFor:Class, useSingletonOf:Class, named:String=""):*
		{
			var def:IObjectDefinition = createObjectDefinitionForClass(useSingletonOf);
			def.scope = ObjectDefinitionScope.SINGLETON;
			springContext.registerObjectDefinition(getName(whenAskedFor, named), def);
			return null;
		}
		
		public function mapRule(whenAskedFor:Class, useRule:*, named:String=""):*
		{
			throw new IllegalOperationError("Method is not supported");
		}
		
		public function injectInto(target:Object):void
		{
			springContext.wire(target);
		}
		
		public function instantiate(clazz:Class):*
		{
			var instance:Object = ClassUtils.newInstance(clazz);
			injectInto(instance);
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
			var injector:SpringActionscriptInjector = new SpringActionscriptInjector(context);
			return injector;
		}
		
		public function unmap(clazz:Class, named:String=""):void
		{
			springContext.removeObjectDefinition(getName(clazz, named));
		}
		
		public function hasMapping(clazz:Class, named:String=""):Boolean
		{
			return springContext.containsObject(getName(clazz, named));
		}
		
		public function get applicationDomain():ApplicationDomain
		{
			return springContext.applicationDomain;
		}
		
		public function set applicationDomain(value:ApplicationDomain):void
		{
			springContext.applicationDomain = value;
		}
		
		protected function getName(whenAskedFor:Class, named:String = ""):String
		{
			var requestName:String = getQualifiedClassName(whenAskedFor);
			return requestName + '#' + named;
		}
		
		protected function createObjectDefinitionForClass(clazz:Class):IObjectDefinition 
		{
			return new ObjectDefinition(ClassUtils.getFullyQualifiedName(clazz, true));
		}
	}
}