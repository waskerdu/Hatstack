package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Stack extends FlxSprite{
    var hats:Array<Hat>;
    var hatPool:HatPool;
    var hatWidth = 100;
    public function new(hatPool:HatPool) {
        super(0, 0);
        hats = new Array<Hat>();
        this.hatPool = hatPool;
    }

    override function update(elapsed:Float) {
        for (i in 0...hats.length){
            hats[i].position.x = spotX(i);
            hats[i].position.y = spotY(i);
        }
        super.update(elapsed);
    }

    public function popHat() {
        return hats.pop();
    }

    public function pushHat(hat:Hat) {
        hats.push(hat);
    }

    function spotX(i:Int){
        return x + (width - hatWidth)/2;
    }

    function spotY(i:Int){
        return y + height - (i+1) * hatWidth;
    }

    public function nextSpotX() {
        return spotX(0);
    }

    public function nextSpotY() {
        return spotY(hats.length);
    }
}