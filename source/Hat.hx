package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Hat extends FlxSprite{
    var value:Int;
    var txt:FlxText;
    public function new(x:Float, y:Float, value:Int, scene:PlayState) {
        super(x,y);
        loadGraphic('assets/images/hat.png');
        this.value = value;
        txt = new FlxText(0, 0, 0,Std.string(value));
        txt.x = x + this.width/2 - txt.width/2;
        txt.y = y + this.height/2;
        txt.color = FlxColor.WHITE;
        scene.add(this);
        scene.add(txt);
    }
}