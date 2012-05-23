package 
{
	import org.flixel.*;
	
	/**
	 * A moveable object in the game (player, enemy, NPC, etc)
	 * @author Cody Sandahl
	 */
	public class TopDownEntity extends FlxSprite
	{
		/**
		 * Constants
		 */
		public static const RUNSPEED:int = 80;
		public static const SIZE:FlxPoint = new FlxPoint(16, 18); // size in pixels
		
		/**
		 * Constructor
		 * @param	X	X location of the entity
		 * @param	Y	Y location of the entity
		 */
		public function TopDownEntity(X:Number = 100, Y:Number = 100):void {
			super(X, Y);
			makeGraphic(SIZE.x, SIZE.y, 0xFFFF0000); // use this if you want a generic box graphic by default
			// movement
			maxVelocity = new FlxPoint(RUNSPEED, RUNSPEED);
			drag = new FlxPoint(RUNSPEED * 4, RUNSPEED * 4); // decelerate to a stop within 1/4 of a second
			// animations
			createAnimations();
		}
		
		/**
		 * Create the animations for this entity
		 * NOTE: these will be different if your art is different
		 */
		protected function createAnimations():void {
			addAnimation("idle_up", [1]);
			addAnimation("idle_right", [5]);
			addAnimation("idle_down", [9]);
			addAnimation("idle_left", [13]);
			addAnimation("walk_up", [0, 1, 2], 12); // 12 = frames per second for this animation
			addAnimation("walk_right", [4, 5, 6], 12);
			addAnimation("walk_down", [8, 9, 10], 12);
			addAnimation("walk_left", [12, 13, 14], 12);
			addAnimation("attack_up", [16, 17, 18, 19], 12, false); // false = don't loop the animation
			addAnimation("attack_right", [20, 21, 22, 23], 12, false);
			addAnimation("attack_down", [24, 25, 26, 27], 12, false);
			addAnimation("attack_left", [28, 29, 30, 31], 12, false);
		}

		/**
		 * Update each timestep
		 */
		public override function update():void {
			updateControls();
			updateAnimations();
			super.update();
		}
		
		/**
		 * Based on current state, show the correct animation
		 * FFV: use state machine if it gets more complex than this
		 */
		protected function updateAnimations():void {
			// use abs() so that we can animate for the dominant motion
			// ex: if we're moving slightly up and largely right, animate right
			var absX:Number = Math.abs(velocity.x);
			var absY:Number = Math.abs(velocity.y);
			// determine facing
			if (velocity.y < 0 && absY >= absX)
				facing = UP;
			else if (velocity.y > 0 && absY >= absX)
				facing = DOWN;
			else if (velocity.x > 0 && absX >= absY)
				facing = RIGHT;
			else if (velocity.x < 0 && absX >= absY)
				facing = LEFT
			// up
			if (facing == UP) {
				if (velocity.y != 0 || velocity.x != 0)
					play("walk_up");
				else
					play("idle_up");
			}
			// down
			else if (facing == DOWN) {
				if (velocity.y != 0 || velocity.x != 0)
					play("walk_down");
				else
					play("idle_down");
			}
			// right
			else if (facing == RIGHT) {
				if (velocity.x != 0)
					play("walk_right");
				else
					play("idle_right");
			}
			// left
			else if (facing == LEFT) {
				if (velocity.x != 0)
					play("walk_left");
				else
					play("idle_left");
			}
		}
		
		/**
		 * Check keyboard/mouse controls
		 */
		protected function updateControls():void {
			acceleration.x = acceleration.y = 0; // no gravity or drag by default
		}
		
		/**
		 * Move entity left
		 */
		public function moveLeft():void {
			facing = LEFT;
			acceleration.x = -RUNSPEED * 4; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move entity right
		 */
		public function moveRight():void {
			facing = RIGHT;
			acceleration.x = RUNSPEED * 4; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move entity up
		 */
		public function moveUp():void {
			facing = UP;
			acceleration.y = -RUNSPEED * 4; // accelerate to top speed in 1/4 of a second
		}
		
		/**
		 * Move playe rdown
		 */
		public function moveDown():void {
			facing = DOWN;
			acceleration.y = RUNSPEED * 4; // accelerate to top speed in 1/4 of a second
		}
	}
}
