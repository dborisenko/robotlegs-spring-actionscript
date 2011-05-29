package org.robotlegs.base
{
	import org.springextensions.actionscript.context.IApplicationContextAware;

	/**
	 * 
	 * @author Denis Borisenko
	 * 
	 */
	public interface IContextMapper extends IApplicationContextAware
	{
		function map():void;
	}
}