package;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Moveable extends FlxGroup{
    public var txt:FlxText;
    public var x:Float;
    public var y:Float;
    public var width = 100.0;
    public var sprite:FlxSprite;
    public var moving=true;
    public function new(x:Float, y:Float, spriteName:String, color:FlxColor) {
        super();
        this.x=x;
        this.y=y;
        sprite = new FlxSprite(x, y);
        sprite.loadGraphic(spriteName);
        txt = new FlxText(0, 0, 0, "", 16);
        txt.color = color;
        add(sprite);
        add(txt);
    }
    override public function update(elapsed:Float) {
        positionChildren();
        super.update(elapsed);
    }
    function positionChildren() {
        if(!moving){return;}
        sprite.x = this.x + (width - sprite.width)/2;
        sprite.y = this.y + (width - sprite.width)/2;
        txt.x = sprite.x + sprite.width/2 - txt.width/2;
        txt.y = sprite.y + sprite.height/2 - 10;
    }
}