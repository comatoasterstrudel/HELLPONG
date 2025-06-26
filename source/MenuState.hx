package;

import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
class MenuState extends FlxState
{
    var spaceToPlay:FlxText;
    
	override public function create()
	{
		super.create();
        
		bgColor = 0xFF341717;

		spaceToPlay = new FlxText(100, 300, 0,
			'PRESS SPACE TO PLAY HELLPONG\n\nPRESS CONTROL TO VIEW CREDITS\n\nPRESS ESCAPE TO LEAVE FOREVER AND NOT COME BACK', 15);
		spaceToPlay.color = 0xFFFFFFFF;
		spaceToPlay.alignment = CENTER;
		spaceToPlay.screenCenter(X);
		add(spaceToPlay);   
		FlxG.mouse.visible = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justReleased.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
		if (FlxG.keys.justReleased.ESCAPE)
		{
			Sys.exit(1);
		}
	}
}
