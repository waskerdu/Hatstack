package;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Hat extends Moveable{
    var value:Int;
    public function new(x:Float, y:Float, value:Int) {
        super(x, y, 'assets/images/hat.png', FlxColor.WHITE);
        setValue(value);
    }
    public function setValue(value:Int) {
        this.value = value;
        txt.text = Std.string(value);
    }
}