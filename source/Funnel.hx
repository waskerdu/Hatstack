package;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Funnel extends Moveable{
    var value:Int;
    var label:String = "FUNNEL";
    public function new(x:Float, y:Float) {
        super(x, y, 'assets/images/hat.png', FlxColor.WHITE);
        txt.text = label;
    }

    override function positionChildren() {
        super.positionChildren();
        txt.y = y + sprite.height - txt.height - 10;
    }

    public function resetLabel() {
        txt.text = label;
    }

    public function setLabel(s:String) {
        txt.text = s;
    }
}