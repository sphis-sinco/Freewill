package objects;

import flixel.FlxG;
import flixel.util.FlxAxes;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Lyrics extends Sprite
{
	static var lyricsShadow:TextField;
	static var lyrics:TextField;

	public function new()
	{
		super();
		init();
	}

	function init()
	{
		lyricsShadow = new TextField();
		lyricsShadow.width = 1280;
		lyricsShadow.height = 600;
		lyricsShadow.x = 0;
		lyricsShadow.y = 603; // 600 + 3
		lyricsShadow.border = false;
		lyricsShadow.antiAliasType = "advanced";
		lyricsShadow.embedFonts = true;
		lyricsShadow.defaultTextFormat = new TextFormat("sonic2HUD.ttf", 48, 0x000000, null, null, null, null, null, "center");
		lyricsShadow.text = "";
		addChild(lyricsShadow);

		lyrics = new TextField();
		lyrics.width = 1280;
		lyrics.height = 600;
		lyrics.x = 0;
		lyrics.y = 600;
		lyrics.border = false;
		lyrics.antiAliasType = "advanced";
		lyrics.embedFonts = true;
		lyrics.defaultTextFormat = new TextFormat("sonic2HUD.ttf", 48, 0xFFFFFF, null, null, null, null, null, "center");
		lyrics.text = "";
		addChild(lyrics);
	}

	public function centerLyrics(axes:FlxAxes = XY)
	{
		if (axes.x)
			lyrics.x = (FlxG.width - lyrics.width) / 2;

		if (axes.y)
			lyrics.y = (FlxG.height - lyrics.height) / 2;

		lyricsShadow.x = lyrics.x + 3;
		lyricsShadow.y = lyrics.y + 3;
	}

	public function displayLyrics(value:String)
	{
		lyrics.text = value.toUpperCase();
		lyricsShadow.text = value.toUpperCase();
	}

	public function clearLyrics()
	{
		displayLyrics('');
	}

	public function destroyLyrics()
	{
		lyrics = null;
		lyricsShadow = null;
	}
}
