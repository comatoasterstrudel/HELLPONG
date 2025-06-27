package;

import Discord.DiscordClient;
import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class MenuState extends FlxState
{
    var spaceToPlay:FlxText;
    
	var bg:FlxSprite;

	var logo:FlxSprite;
	
	var busy:Bool = true;
	
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
			'PRESS SPACE TO PLAY HELLPONG\n\nPRESS CONTROL TO VIEW CREDITS\n\nPRESS ESCAPE TO LEAVE FOREVER AND NOT COME BACK', 15);

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			spaceToPlay.text = 'PRESS A TO PLAY HELLPONG\n\nPRESS Y TO VIEW CREDITS\n\nPRESS B TO LEAVE FOREVER AND NOT COME BACK';
		}
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
		new FlxTimer().start(0.1, function(d):Void
		{
			busy = false;
		});

		DiscordClient.changePresence('MENU', null);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!busy)
		{
			if (Controls.getControl('ACCEPT', 'RELEASE'))
			{
				FlxG.switchState(new PlayState());
			}
			if (Controls.getControl('CREDITS', 'RELEASE'))
			{
				FlxG.switchState(new CreditState());
			}
			#if windows
			if (Controls.getControl('BACK', 'RELEASE'))
			{
				Sys.exit(1);
			}
			#end	
		}
	}
}
