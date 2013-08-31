package com.jjin
{
    import org.flixel.FlxSprite;
    import org.flixel.FlxObject;

    public class Bullet extends FlxSprite
    {
	[Embed(source="../../../asset/sprite/helmetguy_bullet.png")]private var iBullet:Class;

	public function Bullet():void {
	    super();
	    loadGraphic(iBullet, false);
	    exists = false;
	}

	override public function update():void {
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