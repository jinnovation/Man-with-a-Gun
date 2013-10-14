package com.jjin
{
    import org.flixel.*;

    import com.jjin.Player;
    import com.jjin.Enemy;

    public class PlayState extends FlxState
    {
	[Embed(source="../../../asset/map/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")]public var mapLevel:Class;
	[Embed(source="../../../asset/map/mapCSV_Group1_Map1props.csv", mimeType="application/octet-stream")]public var mapProps:Class;
	[Embed(source="../../../asset/map/mapCSV_Group1_Map1bg.csv", mimeType="application/octet-stream")]public var mapBg:Class;
	[Embed(source="../../../asset/map/mapCSV_Group1_Map1bg1.csv", mimeType="application/octet-stream")]public var mapBg1:Class;

	[Embed(source="../../../asset/tile/forest.png")]public var tilesLevel:Class;

	[Embed(source="../../../asset/sound/music/8-bit_Freeride.mp3")]public var mMusic:Class;

	public var mPlayer:Player;
	private var mPlayerBullets:FlxGroup;

	public var mEnemy:Enemy;
	public var mEnemies:FlxGroup = new FlxGroup;
	
	public var mMap:FlxTilemap = new FlxTilemap;
	public var mBgLayer:Background = new Background;
	public var mBgLayer1:Background = new Background;
	public var mProps:FlxTilemap = new FlxTilemap;

	private var mCollideables:FlxGroup = new FlxGroup;

	private var mTileDim:int = 16;

	private var mStartLocation_player:FlxPoint = new FlxPoint(10,10);
	private var mStartLocation_enemy:FlxPoint = new FlxPoint(200,20);

	override public function create():void {
	    super.create();

	    FlxG.visualDebug = true;

	    FlxG.playMusic(mMusic, 0.5);
	    FlxG.bgColor = 0xffaaaaaa;

	    // MAP SETUP
	    add(mBgLayer1.loadMap(new mapBg1, tilesLevel, mTileDim, mTileDim));
	    add(mBgLayer.loadMap(new mapBg, tilesLevel, mTileDim, mTileDim));
	    add(mProps.loadMap(new mapProps, tilesLevel, mTileDim, mTileDim));
	    add(mMap.loadMap(new mapLevel, tilesLevel, mTileDim, mTileDim));

	    mCollideables.add(mMap);

	    mBgLayer.setParallax(new FlxPoint(0.5,0.5));
	    mBgLayer1.setParallax(new FlxPoint(0.25,0.25));

	    // SPRITES SETUP
	    mPlayer = new Player(mStartLocation_player.x,
		mStartLocation_player.y);
	    mEnemies.add(new Enemy(mStartLocation_enemy.x,
		    mStartLocation_enemy.y, mPlayer));
	    mEnemies.add(new Enemy(200,40,mPlayer));

	    mPlayerBullets = mPlayer.getBullets();

	    // CAMERA SETUP
	    FlxG.camera.setBounds(0,0,mMap.width,mMap.height);
	    FlxG.worldBounds = new FlxRect(0,0,mMap.width,mMap.height);
	    FlxG.camera.follow(mPlayer, FlxCamera.STYLE_PLATFORMER);
	    
	    // ADD SPRITES
	    add(mPlayer);
	    add(mEnemies);
	    add(mPlayer.getGibs());
	    add(mPlayerBullets);
	}

	override public function update():void
	{
	    super.update();
	    FlxG.collide(mCollideables, mPlayer);
	    FlxG.collide(mCollideables, mEnemies);
	    FlxG.overlap(mPlayer, mEnemies, overlapped);
	    FlxG.overlap(mPlayerBullets, mEnemies, hitEnemy);
	}

	protected function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void {
	    sprite1.kill();
	}

	protected function hitEnemy(Bullet:FlxObject, Monster:FlxObject):void {
	    Bullet.kill();
	    Monster.hurt(1);
	}
    }
}
