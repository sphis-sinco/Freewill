package;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

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
