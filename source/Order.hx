package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Order extends Moveable{
    public var value:Int;
    public var ins:Int;
    public var offsetX:Float = 0;
    public var offsetY:Float = 0;
    public var selected:Bool = false;
    public function new(x:Float, y:Float, value:Int, label:String, ins:Int) {
        super(x,y,'assets/images/instruction.png', FlxColor.BLACK);
        txt.text = label;
        this.ins = ins;
        this.value = value;
    }

    public function setOffset() {
        //offsetX = x - FlxG.mouse.x;
        //offsetY = y - FlxG.mouse.y;
    }

    override function update(elapsed:Float) {
        if(selected){
            x = FlxG.mouse.x + offsetX;
            y = FlxG.mouse.y + offsetY;
        }
        super.update(elapsed);
    }
}