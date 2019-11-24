package;

import flixel.tweens.FlxEase;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.VarTween;

class Animator extends FlxBasic{
    public var inbox:Inbox;
    public var stack:Stack;
    public var outbox:Outbox;
    public var garbage:FlxSprite;
    public var funnel:Funnel;
    public var hatPool:HatPool;
    public var interpreter:Interpreter;
    var currentAnimation:VarTween;
    function play(obj:Moveable, endX:Float, endY:Float, duration:Float, type:EaseFunction, method:(Void -> Void)){
        currentAnimation = FlxTween.tween(obj, {x:endX, y:endY}, duration, {ease: type, onComplete:
            function(tween:FlxTween){
                method();
            }
        });
    }
    public function cancelAnimation() {
        if(currentAnimation == null){return;}
        currentAnimation.cancel();
    }
    public function a_in(){
        var hat = inbox.popHat();
        play(hat, stack.nextSpotX(), stack.nextSpotY(), 2, FlxEase.linear, 
            function(){
                stack.pushHat(hat);
                interpreter.clock();
            }
        );
    }
    public function a_out(){
        var hat = stack.popHat();
        play(hat, outbox.x, outbox.y, 2, FlxEase.linear, 
            function(){
                outbox.pushHat(hat);
                interpreter.clock();
            }
        );
    }
    public function a_del(){
        var hat = stack.popHat();
        play(hat, garbage.x + 100, garbage.y - 600, 2, FlxEase.linear, 
            function(){
                play(hat, garbage.x + 100, garbage.y, 2, FlxEase.linear, 
                    function(){
                        hat.kill();
                        interpreter.clock();
                    }
                );
            }
        );
    }
    public function a_funnel(method:String, cover:Int, values:Array<Int>){
        var funnelY = funnel.y;
        funnel.setLabel(method);
        play(funnel, funnel.x, stack.nElementY(cover) - funnel.sprite.height, 1, FlxEase.linear,
            function(){
                for (i in 0...cover){
                    stack.popHat().kill();
                }
                for (i in values){
                    stack.pushHat(hatPool.getHat(0,0,i));
                }
                play(funnel, funnel.x, funnelY, 1, FlxEase.linear, 
                function (){
                    funnel.resetLabel();
                    interpreter.clock();
                });
            }
        );
    }
    public function a_setPointer(val:Int){}
}