package menus;

class MainMenu extends FlxState
{
	var bg:FlxSprite;
	var menuTitle:FlxSprite;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('menus/main/bg'));
		bg.setGraphicSize(FlxG.width, FlxG.height);

		menuTitle = new FlxSprite();
		menuTitle.frames = Paths.getSparrowAtlas("menus/main/menuTitles");
		menuTitle.animation.addByPrefix("mainMenu", "mainMenu", 1, true);
		menuTitle.animation.addByPrefix("dataSelect", "dataSelect", 1, true);
		menuTitle.animation.play("mainMenu");

		for (i in [bg, menuTitle])
		{
			if (i != bg)
				i.scale.set(i == menuTitle ? 2.75 : 4, i == menuTitle ? 2.75 : 4);
			i.screenCenter();
			add(i);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
