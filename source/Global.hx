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

	public static var lyricsShadow:FlxText;
	public static var lyrics:FlxText;

	public static function initLyrics()
	{
		lyricsShadow = new FlxText(3, FlxG.height + 3, FlxG.width, '', 48);
		lyrics = new FlxText(0, FlxG.height, FlxG.width, '', 48);

		lyricsShadow.font = Paths.font('sonic2HUD.ttf');
		lyrics.font = Paths.font('sonic2HUD.ttf');

		lyricsShadow.alignment = CENTER;
		lyrics.alignment = CENTER;

		lyricsShadow.color = 0x000000;
	}

	public static function centerLyrics(axes:FlxAxes = XY)
	{
		if (axes.x)
			lyrics.x = (FlxG.width - lyrics.width) / 2;

		if (axes.y)
			lyrics.y = (FlxG.height - lyrics.height) / 2;

		setLyricPosition(lyrics.x, lyrics.y);
	}

	public static function setLyricPosition(x:Float, y:Float)
	{
		lyrics.setPosition(x, y);

		lyricsShadow.x = lyrics.x + 3;
		lyricsShadow.y = lyrics.y + 3;
	}

	public static function displayLyrics(value:String)
	{
		trace('displayLyrics(value: $value)');

		if (lyrics == null)
			initLyrics();

		lyrics.text = value.toUpperCase();
		lyricsShadow.text = value.toUpperCase();
	}

	public static function clearLyrics()
	{
		displayLyrics('');
	}

	public static function destroyLyrics()
	{
		lyrics = null;
		lyricsShadow = null;
	}
}
