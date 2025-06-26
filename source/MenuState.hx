package;

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
        
		spaceToPlay = new FlxText(100, 300, 0, 'PRESS SPACE TO PLAY HELLPONG\n\nPRESS CONTROL TO VIEW CREDITS', 20);
		spaceToPlay.color = 0xFFFFFFFF;
		spaceToPlay.screenCenter(X);
        add(spaceToPlay);    
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justReleased.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
	}
}
