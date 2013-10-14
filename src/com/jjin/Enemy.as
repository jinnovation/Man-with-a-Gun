package com.jjin
{
    import org.flixel.*;
    import com.jjin.Character;

    public class Enemy extends Character
    {
	[Embed(source="../../../asset/sprite/ghost.png")]public var iGhost:Class;

	private static const mTrackingRadius:int = 65000;

	protected var mPlayer:Player;

	public function Enemy(X:int, Y:int, ThePlayer:Player):void
	{
	    super(X,Y);

	    health = 3;

	    mMovingAnimation = new Array(0,1);
	    mIdleAnimation = new Array(0);

	    loadGraphic(iGhost, true, true);
	    addAnimation("walking", mMovingAnimation, 10, true);
	    addAnimation("idle", mIdleAnimation);

	    mRunSpeed = 30;
	    mGravity = 0;
	    mJumpSpeed = 30;

	    drag.x = mRunSpeed * 7;
	    drag.y = mJumpSpeed * 7;
	    acceleration.y = mGravity;
	    maxVelocity.x = mRunSpeed;
	    maxVelocity.y = mJumpSpeed;

	    mPlayer = ThePlayer;
	}

	public override function update():void
	{
	    acceleration.x = acceleration.y = 0;

	    var xDistance:Number = mPlayer.x - x;
	    var yDistance:Number = mPlayer.y - y;
	    var squareDistance:Number = xDistance*xDistance +
	    yDistance*yDistance;

	    if (squareDistance < mTrackingRadius) { // TODO: better number
		if (mPlayer.x < x) {
		    facing = RIGHT; // counters sprite file facing opposite dir
		    acceleration.x = -drag.x;
		} else if (mPlayer.x > x) {
		    facing = LEFT; // likewise
		    acceleration.x = drag.x;
		}
		if (mPlayer.y < y) acceleration.y = -drag.y;
		else if (mPlayer.y > y) acceleration.y = drag.y;
	    }

	    if (isIdle()) play("idle");
	    else play("walking");

	    super.update();
	}

	override public function hurt(Damage:Number):void {
	    // knockback
	    if (facing == RIGHT) velocity.x = drag.x * 4;
	    else if (facing == LEFT) velocity.x = -drag.x * 4;
	    // TODO: move mKnockbackSpeed to Character class

	    flicker(0.5);
	    super.hurt(Damage);
	}
    }
}