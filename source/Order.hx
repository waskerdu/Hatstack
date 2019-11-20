package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.input.mouse.FlxMouseEventManager;
class Order extends FlxSprite{
    static public inline var inst = 0;
    static public inline var literal = 0;
    static public inline var label = 0;
    var type:Int;
    var value:Int;
    var txt:FlxText;
    public function new(x:Float, y:Float, type:Int, value:Int, textString:String, scene:PlayState) {
        super(x,y);
        loadGraphic('assets/images/instruction.png');
        this.value = value;
        this.type = type;
        txt = new FlxText(0, 0, 0, textString, 12);
        txt.x = x + this.width/2 - txt.width/2;
        txt.y = y + this.height/2 - txt.height/2;
        txt.color = FlxColor.BLACK;
        scene.add(this);
        scene.add(txt);
    }
}