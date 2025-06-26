package;

import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
class LossState extends FlxState
{
    var spaceToPlay:FlxText;
    
	override public function create()
	{
		super.create();
        
		bgColor = 0xFF000000;
		
		spaceToPlay = new FlxText(100, 300, 0,
		'FUCK.', 20);
		spaceToPlay.color = 0xFF980202;
		spaceToPlay.alignment = CENTER;
		spaceToPlay.screenCenter();
		add(spaceToPlay);   
		FlxG.sound.music.stop();

		new FlxTimer().start(3, function(d):Void
		{
			FlxG.switchState(new MenuState());
		});
	}
}
