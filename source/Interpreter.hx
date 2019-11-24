package;

import flixel.FlxBasic;

class Interpreter extends FlxBasic{
    var animator:Animator;
    public var input:Array<Int>;
    public var output:Array<Int>;
    public var stack:Array<Int>;
    public var valid:Array<Int>;
    var program:Array<Int>;
    public var ip:Int = 0;
    public var errorCallback:(String->Void);
    public var clearCallback:( (Int,Int) -> Void);
    var steps = 0;

    var paused = true;
    var inCycle = false;
    var launched = false;

    var instructions:Array<(Void -> Void)>;

    function i_in(){
        if(input.length > 0){
            animator.a_in();
            stack.push(input.pop());
        }
        else{
            paused = true;
            validate();
        }
    }
    function i_out(){
        if(stack.length == 0){error("Cannot outbox from an empty stack!");return;}
        animator.a_out();
        output.push(stack.pop());
        check();
    }
    function i_dupe(){
        if(stack.length == 0){error("Cannot dupe from an empty stack!");return;}
        var val = stack[stack.length-1];
        animator.a_funnel("DUPE", 1, [val, val]);
        stack.push(val);
    }
    function i_add(){
        if(stack.length < 2){error("Cannot add with fewer than two hats in the stack!");return;}
        var val = stack.pop() + stack.pop();
        animator.a_funnel("ADD", 2, [val]);
        stack.push(val);
    }
    function i_del(){
        if(stack.length == 0){error("Cannot delete from an empty stack!");return;}
        stack.pop();
        animator.a_del();
    }

    function validate() {
        if(valid.length > output.length){
            error("Not enough hats in the outbox!");
        }
        else if(check()){
            clearCallback(program.length, steps);
        }
    }

    function check():Bool {
        var lenDiff = valid.length - output.length;
        trace(lenDiff);
        if(lenDiff < 0){error("Too many hats in the outbox!"); return false;}
        for (i in 0...output.length){
            if(output[i] != valid[i]){
                error("Invalid hat in the outbox!");
                return false;
            }
        }
        return true;
    }

    function error(message:String)
    {
        paused = true;
        errorCallback(message);
    }
    public function reset() {
        ip = 0;
        paused = true;
        inCycle = false;
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
        var order = program[ip];
        ip++;
        steps++;
        instructions[order]();
        inCycle = true;
        if(ip == program.length){ip = 0;}
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
        program = new Array<Int>();
        valid = new Array<Int>();
        //program = [0,0,3,2,3,1];
        //program = [0,0,0,1,1,1];
        instructions = [
            i_in,
            i_out, 
            i_dupe,
            i_add,
            i_del,
        ];
    }
}