package;

#if windows
import Discord.DiscordClient;
#end
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
		#if windows
		DiscordClient.initialize();
		#end
	}
}
