package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.system.FlxAssets;
import openfl.Assets;
import flixel.util.FlxSave;
/*
Implement robot arm
*/

class MainMenu extends FlxState{
    override function create() {
        var gameSave = new FlxSave();
        gameSave.bind("slot0");
        gameSave.data.problemId = 0;
        var str = Assets.getText("assets/data/gameData.json");
        var problems:Array<Dynamic> = haxe.Json.parse(str).problems;
        for(i in 0...problems.length){
            var button = new Button(0, i*100, 0, 0, problems[i].name,
                function (){
                    gameSave.data.problemId = i;
                    FlxG.switchState(new PlayState());
                });
            this.add(button);
        }
        super.create();
    }
}