package  
{
	import org.flixel.*;
	/**
	 * Base class for all levels
	 * @author Cody Sandahl
	 */
	public class TopDownLevel extends FlxGroup
	{
		/**
		 * Map
		 */
		public var state:FlxState; // state displaying the level
		public var levelSize:FlxPoint; // width and height of level (in pixels)
		public var tileSize:FlxPoint; // default width and height of each tile (in pixels)
		public var numTiles:FlxPoint; // how many tiles are in this level (width and height)
		public var floorGroup:FlxGroup; // floor (rendered beneath the walls - no collisions)
		public var wallGroup:FlxGroup; // all the map blocks (with collisions)
		public var guiGroup:FlxGroup; // gui elements
		
		/**
		 * Player
		 */
		public var player:TopDownEntity;
		public var playerStart:FlxPoint = new FlxPoint(120, 120);
		
		/**
		 * Constructor
		 * @param	state		State displaying the level
		 * @param	levelSize	Width and height of level (in pixels)
		 * @param	blockSize	Default width and height of each tile (in pixels)
		 */
		public function TopDownLevel(state:FlxState, levelSize:FlxPoint, tileSize:FlxPoint):void {
			super();
			this.state = state;
			this.levelSize = levelSize;
			this.tileSize = tileSize;
			if (levelSize && tileSize)
				this.numTiles = new FlxPoint(Math.floor(levelSize.x / tileSize.x), Math.floor(levelSize.y / tileSize.y));
			// setup groups
			this.floorGroup = new FlxGroup();
			this.wallGroup = new FlxGroup();
			this.guiGroup = new FlxGroup();
			// create the level
			this.create();
		}
		
		/**
		 * Create the whole level, including all sprites, maps, blocks, etc
		 */
		public function create():void {
			createMap();
			createPlayer();
			createGUI();
			addGroups();
			createCamera();
		}
		
		/**
		 * Create the map (walls, decals, etc)
		 */
		protected function createMap():void {
		}
		
		/**
		 * Create the player, bullets, etc
		 */
		protected function createPlayer():void {
			player = new TopDownEntity(playerStart.x, playerStart.y);
		}
		
		/**
		 * Create text, buttons, indicators, etc
		 */
		protected function createGUI():void {
		}
		
		/**
		 * Decide the order of the groups. They are rendered in the order they're added, so last added is always on top.
		 */
		protected function addGroups():void {
			add(floorGroup);
			add(wallGroup);
			add(player);
			add(guiGroup);
		}
		
		/**
		 * Create the default camera for this level
		 */
		protected function createCamera():void {
			FlxG.worldBounds = new FlxRect(0, 0, levelSize.x, levelSize.y);
			FlxG.camera.setBounds(0, 0, levelSize.x, levelSize.y, true);
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
		}
		
		/**
		 * Update each timestep
		 */
		override public function update():void {
			super.update();
			FlxG.collide(wallGroup, player);
		}
	}
}
