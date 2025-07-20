package;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		CoolUtil.checkForUpdates();

		Global.resizeWindow();
		Global.setWindowTitle('');
		FlxTimer.wait(5, () ->
		{
			Global.setWindowTitle('Thank you for your patience');
			FlxG.switchState(() -> new CreditsMenu());
		});
	}
}
