package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.system.FlxAssets;
import openfl.Assets;
import flixel.util.FlxSave;
/* TO DO
Instruction map
Mouse manager
Headless interpreter
Interpreter save states/reverse feature
Speed slider
Save solutions
Solution slot gui
Problem version gui (lights, black means untested, red means failed, green means passed, yellow means testing)
(Checks, crosses, and question marks for the colorblind. box around the currently viewed)
Bytecode to script pointer map
Comments
Labels and jumps (how to display conditionals? measuring? scanning?)
Variables
Implement robot arm
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
	var problems:String;
	var notepad:Moveable;
	var problemId:Int = 0;
	var gameSave:FlxSave;
	override public function create():Void
	{
		//var order = new Order(100, 100, Order.inst, 3, "ADD", this);
		gameSave = new FlxSave();
        gameSave.bind("slot0");
		hatPool = new HatPool();
		orderPool = new OrderPool();
		animator = new Animator();
		interpreter = new Interpreter(animator);
		interpreter.errorCallback = error;
		interpreter.clearCallback = levelClear;
		preVis();
		add(hatPool);
		animator.inbox = inbox;
		animator.stack = stack;
		animator.outbox = outbox;
		animator.garbage = garbage;
		animator.funnel = funnel;
		animator.hatPool = hatPool;
		animator.interpreter = interpreter;
		reset();
		add(garbage);
		add(funnel);
		add(new Button(step.x, step.y-20, 0, 0, "RUN", interpreter.start));
		add(new Button(step.x + 100, step.y-20, 0, 0, "STEP", interpreter.step));
		add(new Button(step.x, step.y + 30, 0, 0, "STOP", reset));
		add(new Button(step.x + 100, step.y + 30, 0, 0, "MENU", function(){FlxG.switchState(new MainMenu());} ));
		//FlxG.switchState(new PlayState());
		
		add(new Button(1920 - 300, 100, 0, 0, "IN", 
			function(){
				//script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
				if(script.held != null){script.held.selected = false; script.held.kill();}
				script.held = orderPool.getOrder(0,0,0,"IN",0);
				script.held.selected = true;
				script.held.setOffset();
			}
		));
		add(new Button(1920 - 300, 200, 0, 0, "OUT", 
			function(){
				//script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
				if(script.held != null){script.held.selected = false; script.held.kill();}
				script.held = orderPool.getOrder(0,0,0,"OUT",1);
				script.held.selected = true;
				script.held.setOffset();
			}
		));
		add(new Button(1920 - 300, 300, 0, 0, "DUPE", 
			function(){
				//script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
				if(script.held != null){script.held.selected = false; script.held.kill();}
				script.held = orderPool.getOrder(0,0,0,"DUPE",2);
				script.held.selected = true;
				script.held.setOffset();
			}
		));
		add(new Button(1920 - 300, 400, 0, 0, "ADD", 
			function(){
				//script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
				if(script.held != null){script.held.selected = false; script.held.kill();}
				script.held = orderPool.getOrder(0,0,0,"ADD",3);
				script.held.selected = true;
				script.held.setOffset();
			}
		));
		add(new Button(1920 - 300, 500, 0, 0, "DEL", 
			function(){
				//script.pushOrder(orderPool.getOrder(0,0,0,"IN",0));
				if(script.held != null){script.held.selected = false; script.held.kill();}
				script.held = orderPool.getOrder(0,0,0,"DEL",4);
				script.held.selected = true;
				script.held.setOffset();
			}
		));
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

	function reset() {
		problemId = gameSave.data.problemId;
		animator.cancelAnimation();
		var str = Assets.getText("assets/data/gameData.json");
		var runId = 1;
		var problem = haxe.Json.parse(str).problems[problemId];
		notepad.sprite.makeGraphic(500,500,FlxColor.GREEN);
		notepad.txt.text = problem.description;
		interpreter.reset();
		interpreter.input = problem.fixed[runId].input.reverse();
		interpreter.stack = problem.fixed[runId].stack;
		interpreter.output = new Array<Int>();
		interpreter.valid = problem.fixed[runId].valid;
		flashTableau();
	}

	function levelClear(programSize:Int, steps:Int) {
		notepad.sprite.makeGraphic(500,500,FlxColor.GREEN);
		notepad.txt.text = "All tests passing!\nProgram size: "+programSize+"\nSteps taken: "+steps;
	}

	function saveProgram(program:Array<Int>){
		gameSave.data.programs[problemId] = program;
	}

	function error(error:String) {
		notepad.sprite.makeGraphic(500,500,FlxColor.RED);
		notepad.txt.text = error;
	}

	function preVis(){
		inbox = new Inbox(0,0, hatPool);
		inbox.makeGraphic(800, 100);

		notepad = new Moveable(0,100,"",FlxColor.BLACK);
		notepad.sprite.makeGraphic(500,500,FlxColor.GREEN);
		notepad.txt.text = "Note";
		notepad.moving = false;
		notepad.txt.y = 100;
		notepad.txt.fieldWidth = 500;

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
		add(notepad);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
