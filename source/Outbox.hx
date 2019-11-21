package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Outbox extends FlxSprite{
    var hatPool:HatPool;
    var hats:Array<Hat>;

    public function new(x:Float, y:Float, hatPool:HatPool) {
        super(x,y);
        this.hatPool = hatPool;
        hats = new Array<Hat>();
    }

    public function pushHat(hat:Hat) {
        hats.push(hat);
    }

    public function loadHats() {
        for (i in 0...4){
            var hat = hatPool.getHat(0,0,0);
            hat.setValue(i);
            hats.push(hat);
        }
    }
    
    override function update(elapsed:Float) {
        for (i in 0...hats.length){
            //hats[i].position.x = this.width - hats[0].width * (hats.length - i);
            hats[i].position.x = x + hats[0].width * (hats.length - i);
        }
        super.update(elapsed);
    }
}