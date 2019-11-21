package;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Hat extends FlxGroup{
    var value:Int;
    var txt:FlxText;
    public var position:FlxPoint;
    public var width = 100.0;
    var sprite:FlxSprite;
    public function new(x:Float, y:Float, value:Int) {
        super();
        position = new FlxPoint(x, y);
        sprite = new FlxSprite(x, y);
        sprite.loadGraphic('assets/images/hat.png');
        txt = new FlxText(0, 0, 0, "", 16);
        setValue(value);
        txt.color = FlxColor.WHITE;
        add(sprite);
        add(txt);
    }
    override public function update(elapsed:Float) {
        setPosition();
        super.update(elapsed);
    }
    public function setValue(value:Int) {
        this.value = value;
        txt.text = Std.string(value);
    }
    public function setPosition() {
        sprite.x = position.x + (width - sprite.width)/2;
        sprite.y = position.y + (width - sprite.width)/2;
        txt.x = sprite.x + sprite.width/2 - txt.width/2;
        txt.y = sprite.y + sprite.height/2 - 10;
    }
}