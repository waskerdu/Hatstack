package;

import flixel.FlxBasic;

class Interpreter extends FlxBasic{
    var animator:Animator;
    public var input:Array<Int>;
    public var output:Array<Int>;
    public var stack:Array<Int>;
    var program:Array<Int>;
    public var ip:Int = 0;

    var paused = true;
    var inCycle = false;
    var launched = false;

    var instructions:Array<(Void -> Void)>;

    public function i_in(){
        animator.a_in();
        stack.push(input.pop());
    }
    public function i_out(){
        animator.a_out();
        output.push(stack.pop());
    }
    public function i_dupe(){
        var val = stack[stack.length-1];
        animator.a_funnel("DUPE", 1, [val, val]);
        stack.push(val);
    }
    public function i_add(){
        var val = stack.pop() + stack.pop();
        animator.a_funnel("ADD", 2, [val]);
        stack.push(val);
    }
    public function i_del(){
        stack.pop();
        animator.a_del();
    }
    public function start(){
        if(paused){
            paused = false;
            clock();
        }
        else{paused = true;}
    }
    public function step() {
        paused = true;
        if(inCycle){return;}
        paused = false;
        clock();
        paused = true;
    }
    public function clock() {
        inCycle = false;
        if(paused){return;}
        if(ip == program.length){return;}
        var order = program[ip];
        ip++;
        instructions[order]();
        inCycle = true;
    }

    public function setProgram(program:Array<Int>) {
        this.program = program;
    }

    public function new(animator:Animator) {
        super();
        this.animator = animator;
        input = new Array<Int>();
        output = new Array<Int>();
        stack = new Array<Int>();
        //program = new Array<Int>();
        program = [0,0,3,2,3,1];
        instructions = [
            i_in,
            i_out, 
            i_dupe,
            i_add,
            i_del,
        ];
    }
}