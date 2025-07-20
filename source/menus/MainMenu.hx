package menus;

class MainMenu extends FlxState
{
	var menuItems:Array<Array<Dynamic>> = [['LEVELS', false], ['SETTINGS', false], ['CREDITS', false], ['GALLERY', false]]; // Item, Unlocked by default
	var menuItemsText:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	var bg:FlxSprite;
	var menuTitle:FlxSprite;
	var curSelected:Int = 0;
	var selector:FlxSprite;

	var secretIndex:Int = 0;

	public static var secretUnlocked:Bool = false;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('menus/main/bg'));
		bg.setGraphicSize(FlxG.width, FlxG.height);

		selector = new FlxSprite().loadGraphic(Paths.image('menus/main/selector'));

		menuTitle = new FlxSprite();
		menuTitle.frames = Paths.getSparrowAtlas('menus/main/menuTitles');
		menuTitle.animation.addByPrefix('mainMenu', 'mainMenu', 1, true);
		menuTitle.animation.addByPrefix('dataSelect', 'dataSelect', 1, true);
		menuTitle.animation.play('mainMenu');

		for (i in [bg, menuTitle, selector])
		{
			if (i != bg)
				i.scale.set(i == menuTitle ? 2.75 : 4, i == menuTitle ? 2.75 : 4);
			i.screenCenter();
			add(i);
		}
		menuTitle.y -= 290;

		for (i in 0...menuItems.length)
		{
			var menuText = new FlxText(0, 0, FlxG.width, menuItems[i][0]);
			menuText.setFormat(Paths.font('sonic2HUD.ttf'), 55, menuItems[i][1] ? 0xFFFFFFFF : 0xFFB4B4B4, 'center', FlxTextBorderStyle.SHADOW, 0xFF000000);
			menuText.shadowOffset.x += 3;
			menuText.shadowOffset.y += 3;
			menuText.screenCenter();
			menuText.y += i * 70 - 80;
			menuItems[i][2] = menuText;
			menuItemsText.add(menuText);
		}

		add(menuItemsText);

		changeSelection(0, true);

		if (secretUnlocked)
		{
			FlxG.sound.play(Paths.sound('confirmMenu-glitch'), 1.0);
			Global.displayLyrics('Secret Unlocked');

			add(Global.lyricsShadow);
			add(Global.lyrics);

			Global.centerLyrics(X);
			Global.setLyricPosition(Global.lyrics.x, FlxG.height - Global.lyrics.height);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.UI_MOVE_UP)
			changeSelection(-1, false);
		if (Controls.UI_MOVE_DOWN)
			changeSelection(1, false);
		if (Controls.UI_SELECT)
		{
			if (!menuItems[curSelected][1])
			{
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.8);
				return;
			}

			final selVal = menuItems[curSelected][0];

			switch (selVal)
			{
				default:
					FlxG.sound.play(Paths.sound('cancelMenu'), 0.8);
					trace('$selVal has no implementation');
			}
		}

		if (FlxG.keys.anyJustReleased([LEFT, DOWN, RIGHT, UP]))
		{
			if (secretUnlocked)
				return;

			var reset = false;

			final LEFT = FlxG.keys.justReleased.LEFT;
			final DOWN = FlxG.keys.justReleased.DOWN;
			final UP = FlxG.keys.justReleased.UP;
			final RIGHT = FlxG.keys.justReleased.RIGHT;

			switch (secretIndex)
			{
				case 0, 2:
					reset = !LEFT;
				case 1, 3:
					reset = !RIGHT;
				case 4, 6:
					reset = !UP;
				case 5, 7:
					reset = !DOWN;
			}

			if (reset)
			{
				trace('secret index reset');
				secretIndex = 0;
			}
			else
			{
				trace('secret index increase');
				secretIndex++;
			}

			if (secretIndex == 8)
			{
				secretUnlocked = true;
				FlxG.resetState();
			}
		}
	}

	function changeSelection(change, silent)
	{
		if (!silent)
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);

		curSelected += change;
		if (curSelected > menuItems.length - 1)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		for (i in 0...menuItems.length)
		{
			for (text in menuItemsText)
			{
				if (i == curSelected)
				{
					menuItemsText.members[i].color = menuItems[i][1] ? 0xFFFCFC00 : 0xFFB5B500;
				}
				else
				{
					menuItemsText.members[i].color = menuItems[i][1] ? 0xFFFFFFFF : 0xFFB4B4B4;
				}
			}
		}

		selector.y = menuItemsText.members[curSelected].y + 25;
		selector.color = menuItemsText.members[curSelected].color;
	}
}
