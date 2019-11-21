package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Inbox extends FlxSprite{
    var hatPool:HatPool;
    var hats:Array<Hat>;

    public function new(x:Float, y:Float, hatPool:HatPool) {
        super(x,y);
        this.hatPool = hatPool;
        hats = new Array<Hat>();
    }

    public function loadHats() {
        for (i in 0...4){
            var hat = hatPool.getHat(0,0,0);
            hat.setValue(i);
            hats.push(hat);
        }
        //trace(Std.string(hats.length));
    }

    public function popHat() {
        return hats.pop();
    }
    
    override function update(elapsed:Float) {
        for (i in 0...hats.length){
            hats[i].position.x = this.width - hats[0].width * (hats.length - i);
        }
        super.update(elapsed);
    }
}