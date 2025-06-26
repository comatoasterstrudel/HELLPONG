package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
class PlayState extends FlxState
{
	var bg:FlxSprite;
	var ball:FlxSprite;
	var paddle1:FlxSprite;
	var paddle2:FlxSprite;

	var speed:Float = 300;
	var ballspeed:Float = 150;

	var floortop:FlxSprite;
	var floorbottom:FlxSprite;

	var balls:Array<ShitBall> = [];

	var score:Int = 0;
	
	override public function create()
	{
		super.create();
		bgColor = 0xFF2D0000;

		bg = new FlxSprite().loadGraphic('assets/images/bg.png');
		bg.alpha = .5;
		add(bg);
		
		addBall();

		paddle1 = new FlxSprite(20).loadGraphic('assets/images/paddle.png');
		paddle1.color = 0xFF00FFAA;
		paddle1.screenCenter(Y);
		paddle1.immovable = true;
		add(paddle1);

		paddle2 = new FlxSprite(20).loadGraphic('assets/images/paddle.png');
		paddle2.color = 0xFF465FF0;
		paddle2.flipX = true;
		paddle2.x = FlxG.width - 35;
		paddle2.screenCenter(Y);
		paddle2.immovable = true;
		add(paddle2);

		floortop = new FlxSprite().makeGraphic(FlxG.width, 1, 0xFFB94343);
		floortop.y = 1;
		floortop.immovable = true;
		add(floortop);

		floorbottom = new FlxSprite().makeGraphic(FlxG.width, 1, 0xFFB94343);
		floorbottom.y = FlxG.height - 1;
		floorbottom.immovable = true;
		add(floorbottom);

		startBallMovement();
		FlxG.sound.playMusic('assets/music/FuckBalls.ogg', .3);

		FlxG.sound.play('assets/sounds/hello.ogg', .7);
	}

	override public function update(elapsed:Float)
	{
		paddle2.velocity.y = 0;

		if (FlxG.keys.pressed.UP && paddle2.y > -1)
		{
			paddle2.velocity.y = -speed;
		}
		else if (FlxG.keys.pressed.DOWN && paddle2.y + paddle2.height < FlxG.height)
		{
			paddle2.velocity.y = speed;
		}

		paddle1.velocity.y = 0;

		if (FlxG.keys.pressed.W && paddle1.y > -1)
		{
			paddle1.velocity.y = -speed;
		}
		else if (FlxG.keys.pressed.S && paddle1.y + paddle1.height < FlxG.height)
		{
			paddle1.velocity.y = speed;
		}
		
		super.update(elapsed);
		for (ball in balls)
		{
			if (FlxG.collide(paddle1, ball))
			{
				ball.speed += 0.1;
				if (ball.speed > 2)
				{
					ball.speed = 2;
				}

				ball.velocity.x = ball.velocity.x * 1.1;

				ball.velocity.y = (paddle1.velocity.y / 2) * ball.speed;

				score++;

				if (score % 5 == 0)
				{
					addBall();
					startBallMovement();
					FlxG.sound.music.pitch += 0.1;
				}
				FlxG.sound.play('assets/sounds/ballhit' + FlxG.random.int(1, 2) + '.ogg');
			}
			else if (FlxG.collide(paddle2, ball))
			{
				ball.speed += 0.1;
				if (ball.speed > 2)
				{
					ball.speed = 2;
				}

				ball.velocity.x = ball.velocity.x * 1.05;

				ball.velocity.y = (paddle2.velocity.y / 2) * ball.speed;

				score++;

				if (score % 5 == 0)
				{
					addBall();
					startBallMovement();
					FlxG.sound.music.pitch += 0.1;
				}
				FlxG.sound.play('assets/sounds/ballhit' + FlxG.random.int(1, 2) + '.ogg');
			}

			if (FlxG.collide(ball, floortop))
			{
				FlxG.sound.play('assets/sounds/wallhit' + FlxG.random.int(1, 3) + '.ogg');
			}
			if (FlxG.collide(ball, floorbottom))
			{
				FlxG.sound.play('assets/sounds/wallhit' + FlxG.random.int(1, 3) + '.ogg');
			}

			if (ball.x > FlxG.width || ball.x + ball.width < 0)
			{
				FlxG.switchState(new LossState());
			}

			for (ball2 in balls)
			{
				if (FlxG.collide(ball, ball2))
				{
					FlxG.sound.play('assets/sounds/ballhit' + FlxG.random.int(1, 2) + '.ogg');
				}
			}
		}
	}

	function startBallMovement():Void
	{
		for (ball in balls)
		{
			if (ball.velocity.x == 0)
				ball.velocity.x = (FlxG.random.bool(50) ? -ballspeed : ballspeed);
		}
	}

	function addBall():Void
	{
		var ball:ShitBall = new ShitBall();
		ball.loadGraphic('assets/images/ball.png');
		ball.screenCenter();
		ball.elasticity = 1;
		add(ball);

		if (balls.length > 0)
		{
			ball.y = FlxG.random.float(0, FlxG.height);
			FlxG.sound.play('assets/sounds/shitball.ogg', .7).pitch = FlxG.random.float(.5, 2);	
		}

		balls.push(ball);
	}
}
