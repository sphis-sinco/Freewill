package menus;

class MainMenu extends FlxState
{
	var menuItems:Array<Array<Dynamic>> = [["SETTINGS", true], ["CREDITS", false,]]; // Item, Unlocked by default
	var menuItemsText:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	var bg:FlxSprite;
	var menuTitle:FlxSprite;
	var curSelected:Int = 0;
	var selector:FlxSprite;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('menus/main/bg'));
		bg.setGraphicSize(FlxG.width, FlxG.height);

		selector = new FlxSprite().loadGraphic(Paths.image("menus/main/selector"));

		menuTitle = new FlxSprite();
		menuTitle.frames = Paths.getSparrowAtlas("menus/main/menuTitles");
		menuTitle.animation.addByPrefix("mainMenu", "mainMenu", 1, true);
		menuTitle.animation.addByPrefix("dataSelect", "dataSelect", 1, true);
		menuTitle.animation.play("mainMenu");

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
			menuText.setFormat(Paths.font("sonic2HUD.ttf"), 55, menuItems[i][1] ? 0xFFFFFFFF : 0xFFB4B4B4, "center", FlxTextBorderStyle.SHADOW, 0xFF000000);
			menuText.shadowOffset.x += 1;
			menuText.shadowOffset.y += 3;
			menuText.screenCenter();
			menuText.y += i * 70 - 80;
			menuItems[i][2] = menuText;
			menuItemsText.add(menuText);
		}

		add(menuItemsText);

		changeSelection(0, true);
		Paths.sound("confirmMenu");

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.UI_MOVE_UP)
			changeSelection(-1, false);
		if (Controls.UI_MOVE_DOWN)
			changeSelection(1, false);
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
