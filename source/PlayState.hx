package;

import WiggleShader.WiggleEffectType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class PlayState extends FlxState
{
	var bg:FlxSprite;
	var wiggleShader:WiggleShader;
	
	var ball:FlxSprite;
	var paddle1:FlxSprite;
	var paddle2:FlxSprite;

	var paddle1Pos:Bool = false;
	var paddle2Pos:Bool = true;
	
	var speed:Float = 300;
	var ballspeed:Float = 150;

	var floortop:FlxSprite;
	var floorbottom:FlxSprite;

	var balls:Array<ShitBall> = [];

	var score:Int = 0;
	
	var scorecounter:FlxText;

	var paddleTarget1:Float = 0;
	var paddleTarget2:Float = 0;

	public static var thescore:Int = 0;
	
	override public function create()
	{
		super.create();
		bgColor = 0xFF2D0000;

		bg = new FlxSprite().loadGraphic('assets/images/bg.png');
		bg.alpha = .5;
		add(bg);
		
		wiggleShader = new WiggleShader();
		wiggleShader.effectType = WiggleEffectType.DREAMY;
		wiggleShader.waveAmplitude = 0.028;
		wiggleShader.waveFrequency = 2;
		wiggleShader.waveSpeed = 1.8; // fasto
		wiggleShader.shader.uTime.value = [500]; // from 4mbr0s3 2
		wiggleShader.shader.uAlpha.value = [0.5];
		bg.shader = wiggleShader.shader;

		scorecounter = new FlxText(100, 100, 0, '', 60);
		scorecounter.color = 0xFFFF0000;
		scorecounter.font = 'assets/fonts/HelpMe-Yz7Lq.ttf';
		scorecounter.alignment = CENTER;
		scorecounter.y = 0;
		scorecounter.alpha = .5;
		add(scorecounter);

		FlxTween.tween(scorecounter, {y: FlxG.height - 100}, 10, {ease: FlxEase.smoothStepInOut, type: PINGPONG});
		FlxTween.tween(scorecounter, {x: FlxG.width - 100}, 6, {ease: FlxEase.smoothStepInOut, type: PINGPONG});

		FlxG.mouse.visible = false;
		
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

		paddleTarget1 = paddle1.x;
		paddleTarget2 = paddle2.x;

		floortop = new FlxSprite().makeGraphic(FlxG.width, 1, 0xFFB94343);
		floortop.y = 1;
		floortop.immovable = true;
		add(floortop);

		floorbottom = new FlxSprite().makeGraphic(FlxG.width, 1, 0xFFB94343);
		floorbottom.y = FlxG.height - 1;
		floorbottom.immovable = true;
		add(floorbottom);

		startBallMovement();
		FlxG.sound.playMusic('assets/music/FuckBalls.ogg', .2);

		FlxG.sound.play('assets/sounds/hello.ogg', .7);
	}

	override public function update(elapsed:Float)
	{
		paddle2.velocity.y = 0;

		if (Controls.getControl('UP2', 'HOLD') && paddle2.y > -1)
		{
			paddle2.velocity.y = -speed;
		}
		else if (Controls.getControl('DOWN2', 'HOLD') && paddle2.y + paddle2.height < FlxG.height)
		{
			paddle2.velocity.y = speed;
		}

		if (!paddle1Pos && Controls.getControl('RIGHT', 'RELEASE'))
		{
			paddleTarget1 = paddleTarget1 + 40;
			paddle1Pos = true;

			FlxG.sound.play('assets/sounds/fling' + FlxG.random.int(1, 4) + '.ogg', .35);
		}
		else if (paddle1Pos && Controls.getControl('LEFT', 'RELEASE'))
		{
			paddleTarget1 = paddleTarget1 - 40;
			paddle1Pos = false;

			FlxG.sound.play('assets/sounds/pull' + FlxG.random.int(1, 2) + '.ogg', .35);
		}

		if (!paddle2Pos && Controls.getControl('RIGHT2', 'HOLD'))
		{
			paddleTarget2 = paddleTarget2 + 40;
			paddle2Pos = true;
			FlxG.sound.play('assets/sounds/pull' + FlxG.random.int(1, 2) + '.ogg', .35);
		}
		else if (paddle2Pos && Controls.getControl('LEFT2', 'RELEASE'))
		{
			paddleTarget2 = paddleTarget2 - 40;
			paddle2Pos = false;
			FlxG.sound.play('assets/sounds/fling' + FlxG.random.int(1, 4) + '.ogg', .35);
		}
		
		paddle1.velocity.y = 0;

		if (Controls.getControl('UP', 'HOLD') && paddle1.y > -1)
		{
			paddle1.velocity.y = -speed;
		}
		else if (Controls.getControl('DOWN', 'HOLD') && paddle1.y + paddle1.height < FlxG.height)
		{
			paddle1.velocity.y = speed;
		}
		
		scorecounter.text = Std.string(score);

		wiggleShader.update(elapsed);
		wiggleShader.waveAmplitude = 0.028 + (0.002 * score);

		paddle1.x = FlxMath.lerp(paddleTarget1, paddle1.x, boundTo(1 - (elapsed * (paddle1Pos ? 20 : 5)), 0, 1));
		paddle2.x = FlxMath.lerp(paddleTarget2, paddle2.x, boundTo(1 - (elapsed * (paddle2Pos ? 5 : 20)), 0, 1));
		
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

				ball.velocity.y += FlxG.random.float(-30, 30);

				if (ball.speed >= 1.7)
				{
					popball(ball);
				}
				score++;

				if (score % 5 == 0)
				{
					addBall(paddle1);
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

				ball.velocity.y += FlxG.random.float(-30, 30);
				
				if (ball.speed >= 1.7)
				{
					popball(ball);
				}
				score++;

				if (score % 5 == 0)
				{
					addBall(paddle2);
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
				thescore = score;
				FlxG.switchState(new LossState());
			}

			for (ball2 in balls)
			{
				if (FlxG.collide(ball, ball2))
				{
					FlxG.sound.play('assets/sounds/ballhit' + FlxG.random.int(1, 2) + '.ogg');
					ball.velocity.y += FlxG.random.float(-50, 50);
					ball2.velocity.y += FlxG.random.float(-50, 50);
				}
			}
		}
		super.update(elapsed);
	}

	function startBallMovement():Void
	{
		for (ball in balls)
		{
			if (ball.velocity.x == 0)
				ball.velocity.x = (FlxG.random.bool(50) ? -ballspeed : ballspeed);
		}
	}

	function addBall(?paddle:FlxSprite):Void
	{
		var ball:ShitBall = new ShitBall();
		ball.loadGraphic('assets/images/ball.png');
		ball.screenCenter();
		ball.elasticity = 1;
		add(ball);

		if (balls.length > 0)
		{
			ball.y = paddle.y + paddle.height / 2 - ball.height / 2 + FlxG.random.float(-60, 60);
			if (ball.y < 1)
				ball.y = 1;
			if (ball.y + ball.height > FlxG.height)
				ball.y = FlxG.height - ball.height;
			
			FlxG.sound.play('assets/sounds/shitball.ogg', .7).pitch = FlxG.random.float(.5, 2);	
			var fun = new FlxSprite().loadGraphic('assets/images/spawn.png');
			fun.setPosition(ball.x, ball.y);
			fun.alpha = .5;
			add(fun);

			fun.scale.set(1.5, 1.5);

			FlxTween.tween(fun.scale, {x: 0, y: 0}, 1, {ease: FlxEase.quartOut});
			FlxTween.tween(fun, {alpha: 0}, 1, {
				ease: FlxEase.quartOut,
				onComplete: function(f):Void
				{
					fun.destroy();
				}
			});
		}
		add(ball);

		balls.push(ball);
	}
	function popball(ball:ShitBall):Void
	{
		var fun = new FlxSprite().loadGraphic('assets/images/spawn.png');
		fun.color = 0xFFFF0000;
		fun.setPosition(ball.x, ball.y);
		fun.alpha = .35;
		add(fun);

		fun.scale.set(1.3, 1.3);

		FlxTween.tween(fun.scale, {x: 0, y: 0}, 1, {ease: FlxEase.quartOut});
		FlxTween.tween(fun, {alpha: 0}, 1, {
			ease: FlxEase.quartOut,
			onComplete: function(f):Void
			{
				fun.destroy();
			}
		});

		ball.destroy();
		balls.remove(ball);

		FlxG.sound.play('assets/sounds/headpop.ogg').pitch = FlxG.random.float(.5, 2);
	}
	
	function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}
}
