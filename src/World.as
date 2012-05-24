package 
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Michael Elderhorst
	 */
	public class World extends TopDownLevel
	{
		protected static var FLOORS:Array = null;
		protected static var WALLS:Array = null;
		
		protected var decalGroup:FlxGroup;
		protected var objectGroup:FlxGroup;
		
		public function World()
		{
			createFloor();
			createWalls();
		}
		
		private function createFloor()
		{
			
		}
		
		private function createWalls()
		{
			
		}
	}
	
}