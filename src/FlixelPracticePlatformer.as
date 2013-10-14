package
{
    import org.flixel.*;
    import com.jjin.PlayState;
    
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
    
    public class FlixelPracticePlatformer extends FlxGame
    {
	public function FlixelPracticePlatformer()
	{
	    FlxG.visualDebug = true; 	// comment for production
	    super(320,240,PlayState,2);
	}
    }
}