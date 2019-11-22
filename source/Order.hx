package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.input.mouse.FlxMouseEventManager;
class Order extends Moveable{
    public var value:Int;
    public var ins:Int;
    public function new(x:Float, y:Float, value:Int, label:String, ins:Int) {
        super(x,y,'assets/images/instruction.png', FlxColor.BLACK);
        txt.text = label;
        this.ins = ins;
        this.value = value;
    }
}