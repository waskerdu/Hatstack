package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.input.mouse.FlxMouseEventManager;
class Button extends Moveable{
    var type:Int;
    var value:Int;
    var method:(Void -> Void);
    public function new(x:Float, y:Float, type:Int, value:Int, textString:String, method:(Void -> Void)) {
        super(x,y,'assets/images/instruction.png', FlxColor.BLACK);
        txt.text = textString;
        this.method = method;
        this.type = type;
        this.value = value;
        FlxMouseEventManager.add(sprite, onDown, null, null, null);
    }

    function onDown(object:FlxObject){method();}
}