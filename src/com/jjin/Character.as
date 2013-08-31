package com.jjin
{
    import org.flixel.FlxSprite;

    public class Character extends FlxSprite
    {
	protected var mMovingAnimation:Array;
	protected var mIdleAnimation:Array;

	protected var mRunSpeed:int;
	protected var mJumpSpeed:int;
	protected var mGravity:int;

	protected function isIdle():Boolean {
	    return (!velocity.x && !velocity.y) ? true : false;
	}

	public function Character(X:int, Y:int) {
	    super(X,Y);
	}
    }
}