package;

import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class OrderPool extends FlxTypedGroup<Order>{

    public function getOrder(x:Float, y:Float, value:Int, label:String, ins:Int):Order {
        var order = getFirstAvailable();
        if (order == null){
            order = new Order(x, y, value, label, ins);
            add(order);
        } 
        else {
            order.revive();
        }
        return order;
    }
}