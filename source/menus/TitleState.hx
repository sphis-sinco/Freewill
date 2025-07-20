package menus;

class TitleState extends FlxState
{
	override function create()
	{
		Global.resetWindowTitle();
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
