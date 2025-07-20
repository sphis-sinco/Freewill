import flixel.FlxG;
import objects.Lyrics;
import openfl.Lib;

class Global
{
        public static var lyricsObject:Lyrics = new Lyrics();

	public static function resizeWindow(width:Int = 820, height:Int = 720) // yoinked from rewrite round 2 LOL
	{
		FlxG.resizeWindow(width, height);
		FlxG.resizeGame(width, height);
		var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
		var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
		Lib.application.window.x = Std.int((resolutionX - Lib.application.window.width) / 2);
		Lib.application.window.y = Std.int((resolutionY - Lib.application.window.height) / 2);
	}
}
