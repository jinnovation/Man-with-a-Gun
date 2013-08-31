package com.jjin
{
    import org.flixel.*;

    public class Background extends FlxTilemap
    {
	public function setParallax(index:FlxPoint):void {
	    scrollFactor = index;
	}
    }
}