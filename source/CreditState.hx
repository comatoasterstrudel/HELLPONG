package;

import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
class CreditState extends FlxState
{
    var spaceToPlay:FlxText;
    
	var bg:FlxSprite;

	public static var shit:Bool = false;
	
	var tortute:FlxSprite;
	
	override public function create()
	{
		super.create();
        
		shit = true;
		
		bg = new FlxSprite().loadGraphic('assets/images/credits.png');
		bg.alpha = .23;
		add(bg);
		
		bgColor = 0xFF070707;

		spaceToPlay = new FlxText(100, 300, 0,
			'HELLPONG CREDITS\n\nCode by comatoasterstrudel\nMenu music and art by TuneInToAbacas\nGameplay music and sfx by Quiva\n\nFont: Help Me by GGBotNet (fontspace.com)\n\nPRESS ESCAPE TO RETURN TO MENU', 15);
		spaceToPlay.color = 0xFFFFFFFF;
		spaceToPlay.font = 'assets/fonts/HelpMe-Yz7Lq.ttf';
		spaceToPlay.alignment = CENTER;
		spaceToPlay.screenCenter();
		spaceToPlay.y = 0;
		add(spaceToPlay);   
		FlxG.mouse.visible = false;
		
		tortute = new FlxSprite().loadGraphic('assets/images/tortute.png');
		tortute.screenCenter(X);
		tortute.y = FlxG.height - tortute.height * 1.1;
		add(tortute);
		
		FlxG.sound.play('assets/sounds/die' + FlxG.random.int(1, 4) + '.ogg', .7);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
