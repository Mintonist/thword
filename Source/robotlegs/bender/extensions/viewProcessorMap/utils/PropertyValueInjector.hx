//------------------------------------------------------------------------------
//  Copyright (c) 2009-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.viewProcessorMap.utils;

import robotlegs.bender.framework.api.IInjector;

/**
 * Avoids view reflection by using a provided map
 * of property names to dependency values
 */
@:keepSub
class PropertyValueInjector
{

	/*============================================================================*/
	/* Private Properties                                                         */
	/*============================================================================*/

	private var _valuesByPropertyName:Dynamic;

	/*============================================================================*/
	/* Constructor                                                                */
	/*============================================================================*/

	/**
	 * Creates a Value Property Injection Processor
	 *
	 * <code>
	 *     new PropertyValueInjector({
	 *         userService: myUserService,
	 *         userPM: myUserPM
	 *     })
	 * </code>
	 *
	 * @param valuesByPropertyName A map of property names to dependency values
	 */
	public function new(valuesByPropertyName:Dynamic)
	{
		_valuesByPropertyName = valuesByPropertyName;
	}

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	/**
	 * @private
	 */
	public function process(view:Dynamic, type:Class<Dynamic>, injector:IInjector):Void
	{
		var fields = Reflect.fields(_valuesByPropertyName);
		for (propName in fields) {
			Reflect.setProperty(view, propName, Reflect.getProperty(_valuesByPropertyName, propName));
		}
		/*for (propName in _valuesByPropertyName)
		{
			view[propName] = _valuesByPropertyName[propName];
		}*/
	}

	/**
	 * @private
	 */
	public function unprocess(view:Dynamic, type:Class<Dynamic>, injector:IInjector):Void
	{
	}
}
