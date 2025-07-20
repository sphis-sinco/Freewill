package menus;

import flixel.addons.display.FlxBackdrop;
import flixel.util.typeLimit.NextState;

class CreditsMenu extends FlxState
{
	var bg:FlxBackdrop;
	var menuTitle:FlxSprite;
	var back:FlxSprite;
	var up:FlxSprite;
	var down:FlxSprite;
	var endCredits:FlxSprite;
	var blueFade:FlxSprite;
	var bsky:FlxSprite;
	var youtube:FlxSprite;
	var twitter:FlxSprite;
	var border:FlxSprite;
	var name:FlxText;
	var seperator:FlxSprite;
	var desc:FlxText;
	var customCursor:FlxSprite;
	var entries:Array<Array<String>> = [];
	var icons:Array<FlxSprite> = [];
	var allowInput:Bool = true;
	var canChange:Bool = true;
	var curSelected:Int = 0;

	// entry format: name::what they did::bluesky link::youtube link::twitter link

	function onCreate()
	{
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		FlxG.mouse.visible = false;
		new FlxTimer().start(0.001, function(tmr)
		{
			FlxG.camera.alpha = 1;
			FlxG.camera.flash(0xFF000000, 0.6);
		});

		bg = new FlxBackdrop(Paths.image("menus/credits/bg"));
		bg.setGraphicSize(FlxG.width * 2, FlxG.height * 2);
		bg.screenCenter();
		bg.velocity.set(10, 10);

		back = new FlxSprite(10, 635).loadGraphic(Paths.image("menus/options/back"));
		menuTitle = new FlxSprite(140, 50).loadGraphic(Paths.image("menus/credits/credits"));

		for (i in [bg, back, menuTitle])
		{
			if (i != bg)
				i.scale.set(3, 3);
			if (i != menuTitle)
				add(i);
		}

		back.updateHitbox();

		bsky = new FlxSprite(102, 236);
		bsky.frames = Paths.getSparrowAtlas("menus/credits/socials");
		bsky.animation.addByPrefix("enabled", "bsky0", 24, true);
		bsky.animation.addByPrefix("disabled", "bskyDisabled", 24, true);
		bsky.animation.play("enabled");
		bsky.scale.set(5, 5);
		bsky.updateHitbox();
		add(bsky);

		youtube = new FlxSprite(103, 366);
		youtube.frames = Paths.getSparrowAtlas("menus/credits/socials");
		youtube.animation.addByPrefix("enabled", "youtube0", 24, true);
		youtube.animation.addByPrefix("disabled", "youtubeDisabled", 24, true);
		youtube.animation.play("enabled");
		youtube.scale.set(5.2, 5);
		youtube.updateHitbox();
		add(youtube);

		twitter = new FlxSprite(107, 445);
		twitter.frames = Paths.getSparrowAtlas("menus/credits/socials");
		twitter.animation.addByPrefix("enabled", "twitter0", 24, true);
		twitter.animation.addByPrefix("disabled", "twitterDisabled", 24, true);
		twitter.animation.play("enabled");
		twitter.scale.set(5, 5);
		twitter.updateHitbox();
		add(twitter);

		border = new FlxSprite().loadGraphic(Paths.image("menus/credits/select"));
		border.scale.set(5, 5);
		border.screenCenter();
		border.x -= 50;
		add(border);

		name = new FlxText(border.x + 146, border.y - 40, FlxG.width, "HUGGY WUGGY");
		name.font = Paths.font("3dBlast.ttf");
		name.alignment = "left";
		name.size = 28;
		add(name);

		seperator = new FlxSprite(border.x + 148, border.y).makeGraphic(371, 6, 0xFFFFFFFF);
		add(seperator);

		desc = new FlxText(border.x + 146, border.y + 10, FlxG.width, "- what one you favorite");
		desc.font = Paths.font("sonic2HUD.ttf");
		desc.alignment = "left";
		desc.size = 26;
		add(desc);

		for (i in [bsky, youtube, twitter, border, name, desc, seperator])
			i.x -= 70;

		for (i in 0...entries.length)
		{
			var icon:FlxSprite = new FlxSprite(border.x, border.y + i * 200).loadGraphic(Paths.image("credits/" + entries[i][0]));
			icon.scale.set(5, 5);
			icons.push(icon);
			add(icon);
		}

		up = new FlxSprite(550, 80).loadGraphic(Paths.image("menus/credits/arrow"));

		down = new FlxSprite(550, 580).loadGraphic(Paths.image("menus/credits/arrow"));
		down.flipY = true;

		for (i in [up, down])
		{
			i.scale.set(5, 5);
			i.updateHitbox();
			add(i);
		}

		endCredits = new FlxSprite(20, 150).loadGraphic(Paths.image("menus/credits/replayCreditsRoll"));
		endCredits.scale.set(2.6, 2.6);
		endCredits.updateHitbox();
		add(endCredits);

		add(menuTitle);

		customCursor = new FlxSprite(-100, -100);
		customCursor.frames = Paths.getSparrowAtlas("cursor");
		customCursor.animation.addByPrefix("default", "default", 24, false);
		customCursor.animation.addByPrefix("wait", "wait", 24, false);
		customCursor.animation.addByPrefix("hover", "hover", 24, false);
		customCursor.animation.play("default");
		customCursor.scale.set(1.5, 1.5);
		add(customCursor);

		blueFade = new FlxSprite(0, 0).makeGraphic(100, 100, 0xFF0000FF);
		blueFade.scale.set(100, 100);
		blueFade.screenCenter();
		blueFade.alpha = 0.001;
		add(blueFade);

		changeSelection(0);
	}

	function pushEntriesToCredits(folder:String)
	{
		var entriesFile:String = null;
		entriesFile = Paths.txt('credits');

		if (FileSystem.exists(entriesFile))
		{
			var firstarray:Array<String> = File.getContent(entriesFile).split('\n');

			for (i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				entries.push(arr);
			}
		}
	}

	function changeSelection(change)
	{
		if (!canChange)
			return;

		if (change != 0)
			FlxG.sound.play(Paths.sound("scrollMenu"), 0.8);

		var fuckOff:Bool = false;
		curSelected += change;

		if (curSelected > entries.length - 1)
		{
			curSelected = 0;
			for (i in 0...icons.length)
			{
				var tweenNum = border.y + i * 200;
				canChange = false;
				FlxTween.cancelTweensOf(icons[i]);
				FlxTween.tween(icons[i], {y: tweenNum, alpha: i == curSelected ? 1 : 0.5}, 0.15, {
					ease: FlxEase.cubeOut,
					onComplete: function(twn)
					{
						canChange = true;
					}
				});
				FlxTween.tween(icons[i].scale, {x: i == curSelected ? 5 : 4, y: i == curSelected ? 5 : 4}, 0.15, {ease: FlxEase.cubeOut});
			}
			fuckOff = true;
		}

		if (curSelected < 0)
		{
			curSelected = entries.length - 1;
			for (i in 0...icons.length)
			{
				var tweenNum = border.y + i * 200 - 200 * entries.length + 200;
				canChange = false;
				FlxTween.tween(icons[i], {y: tweenNum, alpha: i == curSelected ? 1 : 0.5}, 0.15, {
					ease: FlxEase.cubeOut,
					onComplete: function(twn)
					{
						canChange = true;
					}
				});
				FlxTween.tween(icons[i].scale, {x: i == curSelected ? 5 : 4, y: i == curSelected ? 5 : 4}, 0.15, {ease: FlxEase.cubeOut});
			}
			fuckOff = true;
		}

		name.text = entries[curSelected][0].toUpperCase();
		desc.text = entries[curSelected][1];
		bsky.animation.play(entries[curSelected][2] == "null" ? "disabled" : "enabled");
		youtube.animation.play(entries[curSelected][3] == "null" ? "disabled" : "enabled");
		twitter.animation.play(entries[curSelected][4] == "null" ? "disabled" : "enabled");

		if (fuckOff)
			return;

		for (i in 0...icons.length)
		{
			var tweenNum = icons[i].y - 200 * change;
			canChange = false;
			FlxTween.cancelTweensOf(icons[i]);
			FlxTween.tween(icons[i], {y: tweenNum, alpha: i == curSelected ? 1 : 0.5}, 0.15, {
				ease: FlxEase.cubeOut,
				onComplete: function(twn)
				{
					canChange = true;
				}
			});
			FlxTween.tween(icons[i].scale, {x: i == curSelected ? 5 : 4, y: i == curSelected ? 5 : 4}, 0.15, {ease: FlxEase.cubeOut});
		}
	}

	function onUpdate(e)
	{
		customCursor.x = FlxG.mouse.x;
		customCursor.y = FlxG.mouse.y;

		if (allowInput
			&& (FlxG.mouse.overlaps(up)
				|| FlxG.mouse.overlaps(down)
				|| FlxG.mouse.overlaps(bsky)
				&& bsky.animation.curAnim.name == "enabled"
				|| FlxG.mouse.overlaps(youtube)
				&& youtube.animation.curAnim.name == "enabled"
				|| FlxG.mouse.overlaps(twitter)
				&& twitter.animation.curAnim.name == "enabled"
				|| FlxG.mouse.overlaps(endCredits)
				|| FlxG.mouse.overlaps(back)))
		{
			customCursor.animation.play("hover", true);
		}
		else if (allowInput
			&& (!FlxG.mouse.overlaps(up) || !FlxG.mouse.overlaps(down) || !FlxG.mouse.overlaps(bsky) || !FlxG.mouse.overlaps(youtube)
				|| !FlxG.mouse.overlaps(twitter) || !FlxG.mouse.overlaps(endCredits)))
		{
			customCursor.animation.play("default");
		}
		else if (!allowInput)
		{
			customCursor.animation.play("wait");
		}

		if (!allowInput)
			return;

		if (Controls.UI_MOVE_UP || FlxG.mouse.justPressed && FlxG.mouse.overlaps(up))
			changeSelection(-1);
		if (Controls.UI_MOVE_DOWN || FlxG.mouse.justPressed && FlxG.mouse.overlaps(down))
			changeSelection(1);

		if (FlxG.mouse.justPressed
			&& (FlxG.mouse.overlaps(bsky) || FlxG.mouse.overlaps(youtube) || FlxG.mouse.overlaps(twitter) || FlxG.mouse.overlaps(endCredits)
				|| FlxG.mouse.overlaps(back)))
		{
			if (FlxG.mouse.overlaps(bsky) && bsky.animation.curAnim.name == "enabled")
			{
				CoolUtil.browserLoad(entries[curSelected][2]);
			}
			else if (FlxG.mouse.overlaps(youtube) && youtube.animation.curAnim.name == "enabled")
			{
				CoolUtil.browserLoad(entries[curSelected][3]);
			}
			else if (FlxG.mouse.overlaps(twitter) && twitter.animation.curAnim.name == "enabled")
			{
				CoolUtil.browserLoad(entries[curSelected][4]);
			}
			else if (FlxG.mouse.overlaps(endCredits))
			{
				switchState(TitleState.new, true);
			}
			else if (FlxG.mouse.overlaps(back))
			{
				switchState(TitleState.new, false);
			}
		}
	}

	function switchState(state:NextState, silent:Bool = false)
	{
		allowInput = false;
		if (!silent)
			FlxG.sound.play(Paths.sound("cancelMenu"));
		FlxG.camera.fade(0xFF000000, 0.9);
		FlxTween.tween(blueFade, {alpha: 1}, 0.6);
		new FlxTimer().start(0.95, function(tmr)
		{
			FlxG.switchState(state);
		});
	}
}
