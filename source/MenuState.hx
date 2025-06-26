package;

import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
class MenuState extends FlxState
{
    var spaceToPlay:FlxText;
    
	var bg:FlxSprite;

	var logo:FlxSprite;
	
	override public function create()
	{
		super.create();
        
		bg = new FlxSprite().loadGraphic('assets/images/menubg.png');
		bg.alpha = .5;
		add(bg);
		
		logo = new FlxSprite().loadGraphic('assets/images/logo.png');
		logo.screenCenter(X);
		logo.y = 20;
		add(logo);
		
		bgColor = 0xFF341717;

		spaceToPlay = new FlxText(100, 300, 0,
		'PRESS SPACE TO PLAY HELLPONG\n\nPRESS CONTROL TO VIEW CREDITS', 15);
		#if windows
		spaceToPlay.text += '\n\nPRESS ESCAPE TO LEAVE FOREVER AND NOT COME BACK';
		#end
		spaceToPlay.color = 0xFFFFFFFF;
		spaceToPlay.font = 'assets/fonts/HelpMe-Yz7Lq.ttf';
		spaceToPlay.alignment = CENTER;
		spaceToPlay.screenCenter(X);
		add(spaceToPlay);   
		FlxG.mouse.visible = false;
		if (!CreditState.shit)
		{
			FlxG.sound.playMusic('assets/music/ShitBalls.ogg');			
		}
		else
		{
			CreditState.shit = false;
		}
		FlxG.sound.play('assets/sounds/hellpong.ogg');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justReleased.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
		if (FlxG.keys.justReleased.CONTROL)
		{
			FlxG.switchState(new CreditState());
		}
		#if windows
		if (FlxG.keys.justReleased.ESCAPE)
		{
			Sys.exit(1);
		}
		#end
	}
}
