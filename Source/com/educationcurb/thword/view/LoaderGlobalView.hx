package com.educationcurb.thword.view;

import starling.text.TextField;
import com.educationcurb.thword.utils.Border;
import starling.utils.Color;
import starling.display.Quad;
import starling.events.Event;
import starling.display.Sprite;

class LoaderGlobalView extends Sprite
{
    private var settings:Settings = Settings.getInstance();

    private var loaderBorder:Border;
    private var loaderBar:Quad;

    private var barWidth:Float = 1;
    private var barTotalWidth:Float;
    private var barTxt:TextField;

    public function new()
    {
        super();
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
        var quad:Quad = new Quad(settings.stageWidth, settings.stageHeight, Color.RED);
        quad.alpha = 0;
        this.addChild(quad);
    }

    public function init():Void
    {
        buildLoader();
    }

    private function buildLoader():Void
    {
        var borderWidth:Int = 2;

        loaderBorder = new Border(settings.stageWidth*0.8, 30, borderWidth, 0x000000);
        this.addChild(loaderBorder);
        loaderBorder.x = Std.int(settings.stageWidth/2 - loaderBorder.width/2);
        loaderBorder.y = Std.int(settings.stageHeight/2 - loaderBorder.height/2);

        barTotalWidth = loaderBorder.width - borderWidth*3;
        loaderBar = new Quad(loaderBorder.width - borderWidth*3, loaderBorder.height - borderWidth*3, 0x512727);
        this.addChild(loaderBar);
        loaderBar.x = loaderBorder.x + borderWidth + borderWidth/2;
        loaderBar.y = loaderBorder.y + borderWidth + borderWidth/2;
        loaderBar.width = barWidth;

        barTxt = new TextField(Std.int(loaderBorder.width), 20, "Loading Assets: 0%");
        barTxt.x = Std.int(settings.stageWidth/2 - barTxt.width/2);
        barTxt.y = Std.int(loaderBorder.y - barTxt.height - borderWidth);
        this.addChild(barTxt);
    }

    public function setPercentage(percent:Float):Void
    {
        loaderBar.width = barTotalWidth * percent / 100;
        barTxt.text = "Loading Assets: " + Std.string(Std.int(percent)) + "%";
    }

    private function destroy():Void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
}
