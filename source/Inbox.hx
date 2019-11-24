package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Inbox extends FlxSprite{
    var hatPool:HatPool;
    public var hats:Array<Hat>;

    public function new(x:Float, y:Float, hatPool:HatPool) {
        super(x,y);
        this.hatPool = hatPool;
        hats = new Array<Hat>();
    }

    public function popHat() {
        if(hats.length == 0){
            trace("pop failed inbox empty");
            return null;
        }
        return hats.pop();
    }
    
    override function update(elapsed:Float) {
        for (i in 0...hats.length){
            hats[i].x = this.width - hats[0].width * (hats.length - i);
            hats[i].y = y;
        }
        super.update(elapsed);
    }

    public function flash(state:Array<Int>) {
        hats.resize(0); // clears hats
        for (val in state){
            hats.push(hatPool.getHat(0, 0, val));
        }
    }
}