
import luxe.Color;
import luxe.Vector;
import luxe.Input;

import mint.Types;
import mint.render.LuxeMintRender;
import mint.render.Convert;

class Main extends luxe.Game {

    var canvas: mint.Canvas;
    var label: mint.Label;
    var button: mint.Button;
    var image: mint.Image;
    var scroll: mint.ScrollArea;
    var panel: mint.Panel;
    var list: mint.List;

    var render: LuxeMintRenderer;

    override function ready() {

        Luxe.renderer.clear_color.rgb(0x373737);

        var t = Luxe.loadTexture('assets/transparency.png');
        t.onload = function(_) {

            render = new LuxeMintRenderer();
            canvas = new mint.Canvas({
                renderer: render,
                bounds: new Rect(10,10,512,512)
            });

            label = new mint.Label({
                parent: canvas,
                name: 'label1',
                bounds: new Rect(10,10,100,32),
                text: 'hello mint',
                point_size: 14,
                onclick: function(e,c) {trace('hello mint! ${Luxe.time}' );}
            });

            button = new mint.Button({
                parent: canvas,
                name: 'button1',
                bounds: new Rect(10,52,100,32),
                text: 'mint button',
                point_size: 14,
                onclick: function(e,c) {trace('mint button! ${Luxe.time}' );}
            });

            image = new mint.Image({
                parent: canvas,
                name: 'image1',
                bounds: new Rect(10,102,64,64),
                path: 'assets/transparency.png'
            });

            panel = new mint.Panel({
                parent: canvas,
                name: 'panel1',
                bounds: new Rect(84,102,64,64),
            });

            scroll = new mint.ScrollArea({
                parent: canvas,
                name: 'scroll1',
                bounds: new Rect(10, 180, 128, 128),
            });

            new mint.Image({
                parent: scroll,
                name: 'image2',
                bounds: new Rect(0,0,256,256),
                path: 'assets/transparency.png'
            });

            list = new mint.List({
                parent: canvas,
                name: 'list1',
                bounds: new Rect(160,10,128,256)
            });

            for(i in 0 ... 3) {
                list.add_item(
                    new mint.Button({
                        name: 'list_item_${i*2}',
                        text: 'list_item_${i*2}',
                        parent: list,
                        mouse_enabled:true,
                        point_size: 16,
                        bounds: new Rect(0,0,128,32),
                        path: 'assets/transparency.png'
                    })
                );

                list.add_item(
                    new mint.Image({
                        name: 'list_item_${i*2+1}',
                        parent: list,
                        mouse_enabled:true,
                        bounds: new Rect(0,0,128,128),
                        path: 'assets/transparency.png'
                    })
                );
            } //for

            trace(canvas.nodes);

        }


    } //ready

    override function onmousemove(e) {
        if(canvas!=null) canvas.onmousemove( Convert.mouse_event(e) );
    }

    override function onmousewheel(e) {
        if(canvas!=null) canvas.onmousewheel( Convert.mouse_event(e) );
    }

    override function onmouseup(e) {
        if(canvas!=null) canvas.onmouseup( Convert.mouse_event(e) );
    }

    override function onmousedown(e) {
        if(canvas!=null) canvas.onmousedown( Convert.mouse_event(e) );
    }

    override function onkeyup(e:KeyEvent) {

        if(e.keycode == Key.right) {
            if(canvas!=null) canvas.translate(100,0);
        }
        if(e.keycode == Key.left) {
            if(canvas!=null) canvas.translate(-100,0);
        }

        if(e.keycode == Key.key_v) {
            if(canvas!=null) canvas.visible = !canvas.visible;
        }

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {
        if(canvas!=null) canvas.update(dt);
    } //update

    override function ondestroy() {
    } //shutdown

} //Main


