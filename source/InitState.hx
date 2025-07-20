package;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		FlxSprite.defaultAntialiasing = false;

		Paths.sound('cancelMenu');
		Paths.sound('scrollMenu-glitch');
		Paths.sound('confirmMenu-glitch');
		Paths.sound('scrollMenu');
		Paths.sound('confirmMenu');

		CoolUtil.checkForUpdates();

		Global.setWindowTitle('');
		FlxTimer.wait(#if debug 0 #else FlxG.random.float(0, 5) #end, () ->
		{
			Global.setWindowTitle('Thank you for your patience');

			Global.resetWindowTitle();

			FlxG.switchState(() -> new MainMenu());
		});
	}
}
