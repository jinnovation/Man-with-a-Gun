package com.jjin
{
    import org.flixel.FlxSprite;
    import org.flixel.FlxEmitter;
    import org.flixel.FlxCamera;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;

    import com.jjin.Character;
    import com.jjin.Bullet;
    import com.jjin.PlayState;

    public class Player extends Character
    {
	// IMAGES
	[Embed(source="../../../asset/sprite/helmetguy.png")]public var iHelmetGuy:Class;
	[Embed(source="../../../asset/sprite/helmetguy_gibs.png")]public var iGibs:Class;
	[Embed(source="../../../asset/sprite/helmetguy_bullet.png")]public var iBullet:Class;

	// SOUNDS
	[Embed(source="../../../asset/sound/fx/playerJump.mp3")]public var sJump:Class;
	[Embed(source="../../../asset/sound/fx/playerDie.mp3")]public var sDie:Class;

	protected static const mBulletLimit:int = 4;
	protected static const mBulletSpeed_Player:int = 400;
	protected static const mShootDelay:Number = 0.4;
	protected var mShootCooldown:Number;
	
	protected var mGibs:FlxEmitter;
	protected var mBullets:FlxGroup = new FlxGroup();
	protected var mBulletHolder:Bullet;

	public function getGibs():FlxEmitter {
	    return mGibs;
	}

	public function getBullets():FlxGroup {
	    return mBullets;
	}

	public function Player(X:int, Y:int):void {
	    super(X,Y);
	    
	    mRunSpeed = 150;
	    mGravity = 450;
	    mJumpSpeed = 200;
	    mShootCooldown = mShootDelay;

	    mMovingAnimation = new Array(1,2);
	    mIdleAnimation = new Array(0);
	    
	    loadGraphic(iHelmetGuy, true, true);
	    addAnimation("walking", mMovingAnimation, 12, true);
	    addAnimation("idle", mIdleAnimation);

	    drag.x = mRunSpeed * 8;
	    acceleration.y = mGravity;
	    maxVelocity.x = mRunSpeed;
	    maxVelocity.y = mJumpSpeed;

	    // TODO: set height and width w/ mTileDim from PlayState
	    height = 16;
	    width = 16;
	    offset.x = 2;
	    offset.y = 4;

	    mGibs = new FlxEmitter;
	    mGibs.setXSpeed(-150,150);
	    mGibs.setYSpeed(-200,0);
	    mGibs.setRotation(-720,720);
	    mGibs.makeParticles(iGibs, 50, 15, true, 0.5);

	    var i:int;
	    for (i=0 ; i<mBulletLimit ; i++) {
	    	mBullets.add(new Bullet(iBullet, mBulletSpeed_Player));
	    }
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
		&& !velocity.y) {
		FlxG.play(sJump);
	        velocity.y = -mJumpSpeed;
	    }

	    if (FlxG.keys.X) {
	    	shootBullet();
	    }
	    
	    
	    if (velocity.x != 0) {
		play("walking");
	    } else if (!velocity.x) {
		play("idle");
	    }

	    mShootCooldown += FlxG.elapsed;

	    super.update();
	}

	public override function kill():void {
	    if (!alive) return;

	    super.kill();

	    FlxG.camera.shake(0.005, 0.35);
	    FlxG.camera.flash(0xffDB3624, 0.35);
	    FlxG.play(sDie);

	    if (mGibs != null) {
		mGibs.at(this);
		mGibs.start(true, 2.80);
	    }
	}

	
	protected function shootBullet():void {
	    var bulletX:int = x;
	    var bulletY:int = y+4;
	    var bulletVelocityX:int = 0;
	    var bulletVelocityY:int = 0;

	    if (mShootCooldown >= mShootDelay
		&&
		(mBulletHolder = mBullets.getFirstAvailable() as Bullet)) {
		if (facing == LEFT) {
		    bulletX -= mBulletHolder.width; // nudge to side so doesn't emerge
                                                    // from middle of Player
		    bulletVelocityX = -1 * mBulletHolder.getBulletSpeed();
		} else {
		    bulletX += width; // start on right side of Player
		    bulletVelocityX = mBulletHolder.getBulletSpeed();
		}
		mBulletHolder.shoot(bulletX, bulletY, bulletVelocityX,
		    bulletVelocityY);
		mShootCooldown = 0;
	    }
	}
    }
}