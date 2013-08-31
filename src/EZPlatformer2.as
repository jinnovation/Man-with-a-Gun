package
{
    import org.flixel.*;
    import com.jjin.PlayState;
    
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
    
    public class EZPlatformer2 extends FlxGame
    {
	public function EZPlatformer2()
	{
	    super(320,240,PlayState,2);
	}
    }
}