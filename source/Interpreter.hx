package;

import flixel.FlxBasic;

class Interpreter extends FlxBasic{
    var input:Array<Int>;
    var output:Array<Int>;
    var stack:Array<Int>;
    var program:Array<Int>;
    var ip:Int = 0;

    var paused = true;
    var launched = false;

    var instructions;

    function in(){}
    function out(){}
    function dupe(){}
    function add(){}
    function del(){}

    public function new() {
        super();
        input = new Array<Int>();
        output = new Array<Int>();
        stack = new Array<Int>();
        program = new Array<Int>();
        instructions = [
            0 => in,
            1 => out,
            2 => dupe,
            3 => add,
            4 => del,
        ];
    }
}