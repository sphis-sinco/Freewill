class Global
{
	public static var lyricsObject:Lyrics = new Lyrics();

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
}
