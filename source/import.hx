#if !macro
#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end
import flixel.*;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.*;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.*;
import flixel.util.*;
import lime.utils.Assets;
import menus.*;
import objects.*;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.system.System;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;

using StringTools;

#if flxanimate
import flxanimate.*;
#end
#end
