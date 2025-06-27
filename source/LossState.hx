package;

import Discord.DiscordClient;
import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class LossState extends FlxState
{
    var spaceToPlay:FlxText;
    
	var bg:FlxSprite;
	
	override public function create()
	{
		super.create();
        
		bgColor = 0xFF000000;
		
		bg = new FlxSprite().loadGraphic('assets/images/lossbg.png');
		bg.alpha = .5;
		add(bg);

		if (FlxG.random.bool(8))
		{ // jerma easter egg
			spaceToPlay = new FlxText(100, 300, 0, 'JERMA.', 20);
			spaceToPlay.color = 0xFF980202;
			spaceToPlay.alignment = CENTER;
			spaceToPlay.screenCenter();
			spaceToPlay.font = 'assets/fonts/HelpMe-Yz7Lq.ttf';
			add(spaceToPlay);

			var jerma = new FlxSprite().loadGraphic('assets/images/jerma.png');
			add(jerma);
			jerma.screenCenter(X);
			jerma.y = FlxG.height - jerma.height;
			FlxG.sound.play('assets/sounds/jerma.ogg');
			DiscordClient.changePresence('JERMA', null);
		}
		else
		{
			spaceToPlay = new FlxText(100, 300, 0, 'FUCK.', 20);
			spaceToPlay.color = 0xFF980202;
			spaceToPlay.alignment = CENTER;
			spaceToPlay.screenCenter();
			spaceToPlay.font = 'assets/fonts/HelpMe-Yz7Lq.ttf';
			add(spaceToPlay);
			FlxG.sound.music.stop();

			FlxG.sound.play('assets/sounds/fuck.ogg');
			DiscordClient.changePresence('FUCK', null);
		}

		spaceToPlay.text += '\n\n(' + PlayState.thescore + ')';

		FlxG.sound.music.stop();
		new FlxTimer().start(3, function(d):Void
		{
			FlxG.switchState(new MenuState());
		});
	}
}
