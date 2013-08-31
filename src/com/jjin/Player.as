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
	
	// protected static const RUN_SPEED:int = 150;
	// protected static const GRAVITY:int = 450;
	// protected static const JUMP_SPEED:int = 200;

	protected var mGibs:FlxEmitter;

	public function getGibs():FlxEmitter {
	    return mGibs;
	}

	public function Player(X:int, Y:int):void {
	    super(X,Y);

	    mRunSpeed = 150;
	    mGravity = 450;
	    mJumpSpeed = 200;
	    
	    loadGraphic(helmetGuy, true, true);
	    addAnimation("walking", [1,2], 12, true);
	    addAnimation("idle", [0]);

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