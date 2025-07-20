package;

import flixel.FlxG;
import flixel.FlxState;
import menus.TitleState;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		FlxG.switchState(() -> new TitleState());
	}
}
