package;

import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class HatPool extends FlxTypedGroup<Hat>{

    public function getHat(x:Float, y:Float, value:Int):Hat {
        var hat = getFirstAvailable();
        if (hat == null){
            hat = new Hat(x, y, value);
            add(hat);
        } 
        else {
            hat.setValue(value);
            hat.revive();
        }
        return hat;
    }
}