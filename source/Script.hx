package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
class Script extends FlxSprite{
    var orderPool:OrderPool;
    var interpreter:Interpreter;
    public var orders:Array<Order>;
    public var pointer:FlxSprite;
    var orderHeight = 50;
    var gap = 0;

    public function new(x:Float, y:Float, orderPool:OrderPool, interpreter:Interpreter) {
        super(x,y);
        this.orderPool = orderPool;
        this.interpreter = interpreter;
        orders = new Array<Order>();
    }

    override function update(elapsed:Float) {
        gap = orders.length;
        pointer.x = x;
        pointer.y = y + interpreter.ip * orderHeight;
        for (i in 0...orders.length){
            var order = orders[i];
            order.x = x + 100;
            order.y = y + orderHeight * i;
            if(i>=gap){order.y += orderHeight;}
        }
        super.update(elapsed);
    }

    function assemble() {
        interpreter.setProgram(
            orders.map(
                function (order){
                    return order.ins;
                }
            )
        );
    }

    public function pushOrder(order:Order) {
        orders.push(order);
        assemble();
    }

    public function popOrder() {
        var order = orders.pop();
        assemble();
        return order;
    }
}