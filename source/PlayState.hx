package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.system.scaleModes.RelativeScaleMode;
/* TO DO
Write hat pool DONE
Write inbox/outbox classes DONE
Write stack
Implement animator methods
Impliment funnel (animation driven)
Write toolshelf class (make instructions clickable)
LATER
Write order pool
Write script class
Implement robot arm
Implement control buttons (including reverse?)
*/

class PlayState extends FlxState
{
	var hats:FlxTypedGroup<Hat>;
	var hatPool:HatPool;
	var stack:Stack;
	var inbox:Inbox;
	var outbox:Outbox;
	var garbage:FlxSprite;
	var animator:Animator;
	override public function create():Void
	{
		//var order = new Order(100, 100, Order.inst, 3, "ADD", this);
		hatPool = new HatPool();
		animator = new Animator();
		preVis();
		add(hatPool);
		animator.inbox = inbox;
		animator.stack = stack;
		animator.outbox = outbox;
		animator.garbage = garbage;
		animator.a_in();
		add(garbage);
		super.create();
	}

	function preVis(){
		inbox = new Inbox(0,0, hatPool);
		inbox.makeGraphic(800, 100);
		inbox.loadHats();
		outbox = new Outbox(0,0, hatPool);
		outbox.makeGraphic(800, 100);
		outbox.x = 1920-outbox.width;
		var toolShelf = new FlxSprite();
		toolShelf.makeGraphic(300, 1080-100, FlxColor.BROWN);
		toolShelf.x = 1920-toolShelf.width;
		toolShelf.y = 100;
		var script = new FlxSprite();
		script.makeGraphic(200, 1080-200, FlxColor.BLUE);
		script.x = 1920-script.width - toolShelf.width -50;
		script.y = 150;
		garbage = new FlxSprite();
		garbage.makeGraphic(300, 150, FlxColor.PURPLE);
		garbage.x = 800-garbage.width;
		garbage.y = 1080-garbage.height;
		stack = new Stack(hatPool);
		stack.makeGraphic(320, 1080, FlxColor.YELLOW);
		stack.x = 800;
		var funnel = new FlxSprite();
		funnel.makeGraphic(200, 1080, FlxColor.GRAY);
		funnel.x = 860;
		funnel.y = -1000;
		var step = new FlxSprite();
		step.makeGraphic(200, 120, FlxColor.GREEN);
		step.x = 800-garbage.width*2 - step.width + 50;
		step.y = 1080-step.height - 15;
		add(inbox);
		add(outbox);
		add(toolShelf);
		add(script);
		//add(garbage);
		add(stack);
		add(funnel);
		add(step);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
