package;

import flixel.FlxG;
import flixel.FlxState;
import menus.TitleState;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		Global.resizeWindow();
		Global.setWindowTitle('');
		FlxG.switchState(() -> new TitleState());
	}
}
