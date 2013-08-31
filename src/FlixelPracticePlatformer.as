package
{
    import org.flixel.FlxGame;
    import com.jjin.PlayState;
    
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
    
    public class FlixelPracticePlatformer extends FlxGame
    {
	public function FlixelPracticePlatformer()
	{
	    super(320,240,PlayState,2);
	}
    }
}