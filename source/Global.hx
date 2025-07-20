class Global
{
	public static var defaultWindowTitle:String = 'Freewill';

	public static function setWindowTitle(value:String):Void
	{
		if (value != 'reset')
		{
			trace('setWindowTitle(value: $value)');
			Lib.application.window.title = value;
		}
		else
		{
			resetWindowTitle();
		}
	}

	public static function resetWindowTitle():Void
	{
		Lib.application.window.title = defaultWindowTitle;
	}

	public static var lyrics:FlxText;

	public static function initLyrics()
	{
		if (lyrics != null)
			destroyLyrics();

		lyrics = new FlxText(0, FlxG.height, FlxG.width, '', 48);
		lyrics.setFormat(Paths.font('sonic2HUD.ttf'), 48, 0xFFFFFFFF, 'center', FlxTextBorderStyle.SHADOW, 0xFF000000);
		lyrics.shadowOffset.x += 0;
		lyrics.shadowOffset.y += 3;
		lyrics.alignment = CENTER;
	}

	public static function centerLyrics(axes:FlxAxes = XY)
	{
		if (axes.x)
			lyrics.x = (FlxG.width - lyrics.width) / 2;

		if (axes.y)
			lyrics.y = (FlxG.height - lyrics.height) / 2;
	}

	public static function setLyricPosition(x:Float, y:Float)
	{
		lyrics.setPosition(x, y);
	}

	public static function displayLyrics(value:String)
	{
		trace('displayLyrics(value: $value)');

		if (lyrics == null)
			initLyrics();

		lyrics.text = value.toUpperCase();
	}

	public static function clearLyrics()
	{
		displayLyrics('');
	}

	public static function destroyLyrics()
	{
		lyrics = null;
	}
}
