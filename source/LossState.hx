package;

import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
class LossState extends FlxState
{
    var spaceToPlay:FlxText;
    
	override public function create()
	{
		super.create();
        
		bgColor = 0xFF000000;
		
		spaceToPlay = new FlxText(100, 300, 0,
			'FUCK.', 10);
		spaceToPlay.color = 0xFF980202;
		spaceToPlay.alignment = CENTER;
		spaceToPlay.screenCenter();
		add(spaceToPlay);   
	}

	override public function update(elapsed:Float)
	{
		if(FlxG.keys.justPressed.ANY){
			FlxG.switchState(new MenuState());
		}
	}
}
