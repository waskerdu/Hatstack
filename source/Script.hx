package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
class Script extends FlxSprite{
    var orderPool:OrderPool;
    var interpreter:Interpreter;
    public var orders:Array<Order>;
    public var pointer:FlxSprite;
    public var held:Order = null;
    var orderHeight = 50;
    var gap = 0;

    public function new(x:Float, y:Float, orderPool:OrderPool, interpreter:Interpreter) {
        super(x,y);
        this.orderPool = orderPool;
        this.interpreter = interpreter;
        orders = new Array<Order>();
    }

    override function update(elapsed:Float) {
        handleDragDrop();
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

    function handleDragDrop() {
        setGap();
        if(FlxG.mouse.justPressedRight){
            if(held != null){release();}
        }
        else if(FlxG.mouse.justPressed){
            if(!mouseOver()){release();}
            else if (held == null){grab();}
            else{add();}
        }
    }

    function release() {
        if(held == null || FlxG.mouse.x > x){return;}
        held.selected = false;
        held.kill();
        held = null;
    }

    function add() {
        orders.insert(gap, held);
        held.selected = false;
        held = null;
        gap = orders.length;
        assemble();
    }

    function grab() {
        if(orders.length > getMouseOver()){
            held = orders[getMouseOver()];
            orders.remove(held);
            held.selected = true;
            held.setOffset();
            assemble();
        }
    }

    function mouseOver(){
        return FlxG.mouse.x > x 
        && FlxG.mouse.y > y 
        && FlxG.mouse.x < x + width
        && FlxG.mouse.y < y + height;
    }

    function getMouseOver() {
        var i = Math.floor((FlxG.mouse.y - y) / orderHeight);
        if(i > orders.length){i = orders.length;}
        return i;
    }

    function setGap() {
        if(mouseOver() && held != null){
            gap = Math.floor((FlxG.mouse.y - y) / orderHeight);
            if(gap>orders.length){gap = orders.length;}
        }
        else{gap = orders.length;}
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