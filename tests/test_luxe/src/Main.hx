
import luxe.Color;
import luxe.Rectangle;
import luxe.Text;
import luxe.Vector;
import luxe.Input;
import luxe.Sprite;

import phoenix.BitmapFont.TextAlign;
import phoenix.Rectangle;

import minterface.MIControl;
import minterface.MICanvas;
import minterface.MIButton;
import minterface.MIImage;
import minterface.MIScrollArea;
import minterface.MIList;
import minterface.MIWindow;
import minterface.MIDropdown;

import MILuxeRenderer;

class Main extends luxe.Game {

    public var renderer : MILuxeRenderer;

    public var canvas : MICanvas;
    public var button : MIButton;
    public var button1 : MIButton;
    public var image : MIImage;
    public var scroller : MIScrollArea;
    public var scroller1 : MIScrollArea;
    public var itemlist : MIList;
    public var window : MIWindow;
    public var selector : MIDropdown;
    public var selector2 : MIDropdown;

    var s : Sprite;

    public function ready() {
        
        Luxe.renderer.clear_color.set(1,1,1);

        renderer = new MILuxeRenderer();

        canvas  = new MICanvas({
            bounds : new Rectangle( 0, 0, Luxe.screen.w, Luxe.screen.h ),
            renderer : renderer,
            depth : 100
        });

        button = new MIButton({
            parent : canvas,
            name : 'click',
            bounds : new Rectangle( 10, 10, 100, 35 ),
            text : 'click me',
            text_size : 15,
            onclick : function(){ trace('hello world'); }
        });

        itemlist = new MIList({
            parent : canvas,
            name : 'list1',
            bounds : new Rectangle(10,50, 100,380)
        });

        itemlist.add_item('items one');     
        itemlist.add_items(['item','blah','some more','longer item','short','when do','iam','one','two','three','four','five','six','seven','eight','nine']);

        scroller = new MIScrollArea({
            parent : canvas,
            name : 'scrollarea',
            bounds : new Rectangle( 120, 10, 300, 360 )
        });        

        scroller1 = new MIScrollArea({
            parent : canvas,
            name : 'scrollarea1',
            bounds : new Rectangle( 430, 10, 300, 360 )
        });

        image = new MIImage({
            parent : scroller1,
            name : 'image',
            bounds : new Rectangle( 0, 0, 1280, 720 ),
            texture : Luxe.loadTexture('assets/image.png'),
        });

        scroller1.scrolly(-360);

        for(i in 0 ... 5) {
            var l = new MIButton({
                parent : scroller,
                name : 'button' + (i+1),
                bounds : new Rectangle(50, i * 100, 100, 100 ),
                text : 'click me + '+ (i+1),
                text_size : 18,
                onclick : function(){ trace('click me + '+ (i+1)); }
            });
        }

        window = new MIWindow({
            parent : canvas,
            name : 'inspector',
            title : 'inspector',
            title_size : 15,
            bounds : new Rectangle(750, 20, 200, 300)
        });

        button1 = new MIButton({
            parent : window,
            name : 'click1',
            bounds : new Rectangle( 10, 30, 100, 35 ),
            text : 'clicked',
            text_size : 15,
            onclick : function(){ trace('window 1'); }
        });

        selector = new MIDropdown({
            parent : window,
            name : 'selector',
            bounds : new Rectangle(10, 70, 180, 30),
            text : 'Select output target'
        });

        selector2 = new MIDropdown({
            parent : window,
            name : 'selector2',
            bounds : new Rectangle( 10, 110, 180, 30 ),
            text : 'Select build format'
        });

        selector.add_items(['Mac', 'Windows', 'Linux', 'HTML5', 'Android', 'iOS']);
        selector2.add_items(['zip', 'folder']);


    } //ready
    
    public function onmousemove(e) {
        canvas.onmousemove(e);
    }

    public function onmouseup(e) {
        canvas.onmouseup(e);
    }

    public function onmousedown(e) {        
        canvas.onmousedown(e);
    }

    public function onkeyup(e) {
        if(e.value == Input.Keys.escape) {
            Luxe.shutdown();
        }
    } //onkeyup

    public function update(dt:Float) {
        canvas.update(dt);
    } //update

    public function shutdown() {

    } //shutdown
}


