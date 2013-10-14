package com.jjin
{
    import org.flixel.FlxSprite;
    import org.flixel.FlxObject;
    import org.flixel.FlxG;

    public class Bullet extends FlxSprite
    {
	private var mBulletSpeed:int; // TODO: not in use, make it set by Player

	public function getBulletSpeed():int {
	    return mBulletSpeed;
xb	}

	public function Bullet(bulletImage:Class, bulletSpeed:int):void {
	    super();
	    loadGraphic(bulletImage, false);
	    exists = false;
	    mBulletSpeed = bulletSpeed;
	}

	override public function update():void {
	    if (getScreenXY().x < -64 || getScreenXY().x > FlxG.width+64)
	    kill();

	    if (!alive && finished) exists = false;
	    else super.update();
	}

	// override public function hitSide(Contact:FlxObject,
	//     Velocity:Number):void {
	//     kill();
	// }

	// override public function hitBottom(Contact:FlxObject,
	//     Velocity:Number):void {
	//     kill();
	// }

	// override public function hitUp(Contact:FlxObject,
	//     Velocity:Number):void {
	//     kill();
	// }

	public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):void {
	    super.reset(X, Y);
	    velocity.x = VelocityX;
	    velocity.y = VelocityY;
	}
    }
}