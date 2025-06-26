package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class ShitBall extends FlxSprite // i love ball logic
{
    public var speed:Float = 1;
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (velocity.x > 0)
		{
			angularVelocity = 100 * speed;
		}
		else if (velocity.x < 0)
		{
			angularVelocity = -100 * speed;
		}

		color = FlxColor.fromRGB(255, 100, 100).getDarkened(speed / 3);
	}
}