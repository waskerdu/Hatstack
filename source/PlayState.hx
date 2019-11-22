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
Write stack DONE
Implement animator methods DONE
Impliment funnel (animation driven) 
Write toolshelf class (make instructions clickable) DONE
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
	var orderPool:OrderPool;
	var stack:Stack;
	var inbox:Inbox;
	var outbox:Outbox;
	var garbage:FlxSprite;
	var step:FlxSprite;
	var animator:Animator;
	var toolShelf:FlxSprite;
	var interpreter:Interpreter;
	var script:Script;
	var funnel:Funnel;
	var pointer:FlxSprite;
	override public function create():Void
	{
		//var order = new Order(100, 100, Order.inst, 3, "ADD", this);
		hatPool = new HatPool();
		orderPool = new OrderPool();
		animator = new Animator();
		interpreter = new Interpreter(animator);
		preVis();
		add(hatPool);
		animator.inbox = inbox;
		animator.stack = stack;
		animator.outbox = outbox;
		animator.garbage = garbage;
		animator.funnel = funnel;
		animator.hatPool = hatPool;
		animator.interpreter = interpreter;
		for (i in 0...4){
			interpreter.input.push(i);
		}
		flashTableau();
		add(garbage);
		add(funnel);
		add(new Button(step.x, step.y, 0, 0, "STEP", interpreter.step));
		add(new Button(step.x + 100, step.y, 0, 0, "RUN", interpreter.start));
		
		add(new Button(1920 - 300, 100, 0, 0, "IN", 
			function(){
				script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
			}
		));
		add(new Button(1920 - 300, 200, 0, 0, "OUT", 
			function(){
				script.pushOrder(orderPool.getOrder(0,0,0,"OUT",1));
			}
		));
		add(new Button(1920 - 300, 300, 0, 0, "DUPE", 
			function(){
				script.pushOrder(orderPool.getOrder(0,0,0,"DUPE",2));
			}
		));
		add(new Button(1920 - 300, 400, 0, 0, "ADD", 
			function(){
				script.pushOrder(orderPool.getOrder(0,0,0,"ADD",3));
			}
		));
		add(new Button(1920 - 300, 500, 0, 0, "DEL", 
			function(){
				script.pushOrder(orderPool.getOrder(0,0,0,"DEL",4));
			}
		));
		/*add(new Button(1920 - 300, 100, 0, 0, "IN", interpreter.i_in));
		add(new Button(1920 - 300, 200, 0, 0, "OUT", interpreter.i_out));
		add(new Button(1920 - 300, 300, 0, 0, "DEL", interpreter.i_del));
		add(new Button(1920 - 300, 400, 0, 0, "DUPE", interpreter.i_dupe));
		add(new Button(1920 - 300, 500, 0, 0, "ADD", interpreter.i_add));*/
		add(orderPool);
		add(pointer);
		script.pointer = pointer;
		super.create();
	}

	function flashTableau(){
		hatPool.forEach(function(hat){hat.kill();});
		inbox.flash(interpreter.input);
		stack.flash(interpreter.stack);
		outbox.flash(interpreter.output);
	}

	function preVis(){
		inbox = new Inbox(0,0, hatPool);
		inbox.makeGraphic(800, 100);

		outbox = new Outbox(0,0, hatPool);
		outbox.makeGraphic(800, 100);
		outbox.x = 1920-outbox.width;

		toolShelf = new FlxSprite();
		toolShelf.makeGraphic(300, 1080-100, FlxColor.BROWN);
		toolShelf.x = 1920-toolShelf.width;
		toolShelf.y = 100;

		script = new Script(0, 0, orderPool, interpreter);
		script.makeGraphic(200, 1080-200, FlxColor.BLUE);
		script.x = 1920-script.width - toolShelf.width -50;
		script.y = 150;

		pointer = new FlxSprite();
		pointer.makeGraphic(30, 10, FlxColor.YELLOW);

		garbage = new FlxSprite();
		garbage.makeGraphic(300, 150, FlxColor.PURPLE);
		garbage.x = 800-garbage.width;
		garbage.y = 1080-garbage.height;

		stack = new Stack(hatPool);
		stack.makeGraphic(320, 1080, FlxColor.YELLOW);
		stack.x = 800;

		funnel = new Funnel(0,0);
		funnel.width = 200;
		funnel.sprite.makeGraphic(200, 1080, FlxColor.GRAY);
		funnel.x = 860;
		funnel.y = -1000;

		step = new FlxSprite();
		step.makeGraphic(200, 120, FlxColor.GREEN);
		step.x = 800-garbage.width*2 - step.width + 50;
		step.y = 1080-step.height - 15;
		add(inbox);
		add(outbox);
		add(toolShelf);
		add(script);
		//add(garbage);
		add(stack);
		add(step);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
