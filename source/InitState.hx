package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import menus.TitleState;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		Global.resizeWindow();
		Global.setWindowTitle('');
		FlxTimer.wait(5, () ->
		{
			Global.setWindowTitle('Thank you for your patience');
			FlxG.switchState(() -> new TitleState());
		});
	}
}
