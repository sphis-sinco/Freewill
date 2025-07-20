package menus;

class MainMenu extends FlxState
{
	var bg:FlxSprite;
	var menuTitle:FlxSprite;

	override public function new()
	{
		super();

		Global.resizeWindow();
	}

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('menus/main/bg'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.screenCenter();
		add(bg);

		menuTitle = new FlxSprite();
		menuTitle.frames = Paths.getSparrowAtlas("menus/main/menuTitles");
		menuTitle.animation.addByPrefix("mainMenu", "mainMenu", 1, true);
		menuTitle.animation.addByPrefix("dataSelect", "dataSelect", 1, true);
		menuTitle.animation.play("mainMenu");
		menuTitle.screenCenter(X);
		add(menuTitle);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
