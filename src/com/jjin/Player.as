package com.jjin
{
    import org.flixel.FlxSprite;
    import org.flixel.FlxEmitter;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;

    import com.jjin.Character;

    public class Player extends Character
    {
	[Embed(source="../../../asset/sprite/helmetguy.png")]public var helmetGuy:Class;
	[Embed(source="../../../asset/sprite/helmetguy_gibs.png")]public var iGibs:Class;

	protected var mGibs:FlxEmitter;

	public function getGibs():FlxEmitter {
	    return mGibs;
	}

	public function Player(X:int, Y:int):void {
	    super(X,Y);

	    mRunSpeed = 150;
	    mGravity = 450;
	    mJumpSpeed = 200;

	    mMovingAnimation = new Array(1,2);
	    mIdleAnimation = new Array(0);
	    
	    loadGraphic(helmetGuy, true, true);
	    addAnimation("walking", mMovingAnimation, 12, true);
	    addAnimation("idle", mIdleAnimation);

	    drag.x = mRunSpeed * 8;
	    acceleration.y = mGravity;
	    maxVelocity.x = mRunSpeed;
	    maxVelocity.y = mJumpSpeed;

	    mGibs = new FlxEmitter;
	    mGibs.setXSpeed(-150,150);
	    mGibs.setYSpeed(-200,0);
	    mGibs.setRotation(-720,720);
	    mGibs.makeParticles(iGibs, 50, 15, true, 0.5);
	}

	public override function update():void {
	    acceleration.x = 0;

	    if (FlxG.keys.LEFT) {
		facing = LEFT;
		acceleration.x = -drag.x;
	    } else if (FlxG.keys.RIGHT) {
		facing = RIGHT;
		acceleration.x = drag.x;
	    }

	    if ((FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("SPACE"))
		&& !velocity.y)
	        velocity.y = -mJumpSpeed;

	    if (velocity.x != 0) {
		play("walking");
	    } else if (!velocity.x) {
		play("idle");
	    }

	    super.update();
	}

	public override function kill():void {
	    if (!alive) return;

	    super.kill();

	    FlxG.camera.shake(0.005, 0.35);
	    FlxG.camera.flash(0xffDB3624, 0.35);

	    if (mGibs != null) {
		mGibs.at(this);
		mGibs.start(true, 2.80);
	    }
	}
    }
}