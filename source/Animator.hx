package;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Animator extends FlxBasic{
    public var inbox:Inbox;
    public var stack:Stack;
    public var outbox:Outbox;
    public var garbage:FlxSprite;
    public function a_in(){
        var hat = inbox.popHat();
        FlxTween.tween(hat, {"position.x":stack.nextSpotX(), "position.y":stack.nextSpotY()}, 2, {onComplete: 
        function(tween:FlxTween){
            stack.pushHat(hat);
            a_del();
        }
        });
    }
    public function a_out(){
        var hat = stack.popHat();
        FlxTween.tween(hat, {"position.x":outbox.x, "position.y":outbox.y}, 2, {onComplete: 
        function(tween:FlxTween){
            outbox.pushHat(hat);
        }
        });
    }
    public function a_del(){
        var hat = stack.popHat();
        FlxTween.tween(hat, {"position.x":garbage.x + 100, "position.y":garbage.y - 600}, 2, {onComplete: 
        function(tween:FlxTween){
            FlxTween.tween(hat, {"position.x":garbage.x + 100, "position.y":garbage.y}, 2, {onComplete:
            function(tween:FlxTween){
                hat.kill();
            }});
        }
        });
    }
    public function funnel(method:String, cover:Int, values:Array<Int>){}
    public function setPointer(val:Int){}
}