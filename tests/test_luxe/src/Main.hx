
import luxe.Color;
import luxe.Vector;
import luxe.Input;
import luxe.Text;

import mint.Types;
import mint.Control;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

class Main extends luxe.Game {

    var canvas: mint.Canvas;
    var label: mint.Label;
    var check: mint.Checkbox;
    var button: mint.Button;
    var image: mint.Image;
    var scroll: mint.ScrollArea;
    var panel: mint.Panel;
    var list: mint.List;
    var window: mint.Window;
    var window2: mint.Window;

    var render: LuxeMintRender;

    var debug : Bool = false;
    var td : Text;

    override function ready() {

        var load = Luxe.resources.load_texture('assets/960.png');
            load.then(function(grid) {
                new luxe.Sprite({ texture:grid, centered:false, depth:-1 });
            });

        Luxe.renderer.clear_color.rgb(0x161619);

        render = new LuxeMintRender();
        canvas = new mint.Canvas({
            renderer: render,
            x: 0, y:0, w: 960, h: 640
        });

        td = new Text({
            text: 'debug',
            point_size: 14,
            pos: new Vector(950, 10),
            align: right,
            depth: 999,
            color: new Color()
        });

        test0();
        test1();

    }

    function test0() {

        list = new mint.List({
            parent: canvas,
            name: 'list',
            x: 460, y: 120, w: 140, h: 140
        });

        for(i in 0 ... 20) {
            list.add_item(
                label = new mint.Label({
                    parent: list,
                    name: 'label$i',
                    w:140, h:20,
                    text: 'label $i',
                    point_size: 14,
                    onclick: function(e,c) { trace('label $i! ${Luxe.time}'); }
                }),
                0, i == 0 ? 0 : 10
            );
        }

    }

    function test1() {

        var te = Luxe.resources.load_texture('assets/transparency.png');
        te.then(function(t) {

            label = new mint.Label({
                parent: canvas,
                name: 'label1',
                x:10, y:10, w:100, h:32,
                text: 'hello mint',
                point_size: 14,
                onclick: function(e,c) {trace('hello mint! ${Luxe.time}' );}
            });

            check = new mint.Checkbox({
                parent: canvas,
                name: 'check1',
                x: 120, y: 16, w: 24, h: 24
            });

            button = new mint.Button({
                parent: canvas,
                name: 'button1',
                x: 10, y: 52, w: 100, h: 32,
                text: 'mint button',
                point_size: 14,
                onclick: function(e,c) {trace('mint button! ${Luxe.time}' );}
            });

            image = new mint.Image({
                parent: canvas,
                name: 'image1',
                x: 10, y: 102, w: 64, h: 64,
                path: 'assets/transparency.png'
            });

            panel = new mint.Panel({
                parent: canvas,
                name: 'panel1',
                x:84, y:102, w:64, h: 64,
            });

            scroll = new mint.ScrollArea({
                parent: canvas,
                name: 'scroll1',
                x:10, y:180, w: 128, h: 128,
            });

            new mint.Image({
                parent: scroll,
                name: 'image2',
                x:0, y:100, w:256, h: 256,
                path: 'assets/transparency.png'
            });


            window = new mint.Window({
                parent: canvas,
                name: 'window1',
                title: 'window',
                x:200, y:10, w:256, h: 400
            });

            window2 = new mint.Window({
                parent: canvas,
                name: 'window2',
                title: 'window',
                x:460, y:10, w:256, h: 95
            });

            new mint.TextEdit({
                parent: window2,
                name: 'textedit1',
                text: 'type anything',
                x: 10, y:32, w: 256-10-10, h: 22
            });

            new mint.TextEdit({
                parent: window2,
                name: 'textnumbersonly',
                text: 'numbers only',
                x: 10, y:32+22+10, w: 256-10-10, h: 22,
                filter: new EReg('[0-9]+','gi'),
            });

            list = new mint.List({
                parent: window,
                name: 'list1',
                x: 4, y: 28, w: 248, h: 400-28-4
            });

            for(i in 0 ... 5) {
                list.add_item( create_block(i) );
            } //for

        });


    } //ready

    function create_block(idx:Int) {

        var titles = ['Sword of Extraction', 'Fortitude', 'Wisdom stone', 'Cursed Blade', 'Risen Staff' ];
        var desc = ['Steals 30% life of every hit from the target',
                    '3 second Invulnerability', 'Passive: intelligence +5',
                    'Each attack deals 1 damage to the weilder', 'Undead staff deals 3x damage to human enemies' ];

        var _panel = new mint.Panel({
            parent: list,
            name: 'panel_${idx}',
            x:2, y:4, w:236, h:96,
        });

        new mint.Image({
            name: 'icon_${idx}',
            parent: _panel,
            mouse_enabled:true,
            x:8, y:8, w:80, h:80,
            path: 'assets/transparency.png'
        });

        new mint.Label({
            name: 'label_${idx}',
            parent: _panel,
            mouse_enabled:true,
            x:96, y:8, w:148, h:18,
            point_size: 16,
            align: TextAlign.left,
            align_vertical: TextAlign.top,
            text: titles[idx]
        });

        new mint.Label({
            name: 'desc_${idx}',
            parent: _panel,
            mouse_enabled:true,
            bounds_wrap: true,
            x:96, y:30, w:132, h:18,
            point_size: 12,
            align: TextAlign.left,
            align_vertical: TextAlign.top,
            text: desc[idx]
        });

        return _panel;
    }

    override function onmousemove(e) {

        if(canvas!=null) {
            canvas.onmousemove( Convert.mouse_event(e) );

            var s = 'debug:\n';

            s += 'canvas nodes: ' + (canvas != null ? '${canvas.nodes}' : 'none');
            s += '\n';
            s += 'canvas depth_seq: ' + (canvas != null ? @:privateAccess canvas.depth_seq + '' : 'none');
            s += '\n';
            s += 'focused: ' + (canvas.focused != null ? canvas.focused.name : 'none');
            s += (canvas.focused != null ? ' / depth: '+canvas.focused.depth : '');
            s += '\n';
            s += 'modal: ' + (canvas.modal != null ?  canvas.modal.name : 'none');
            s += '\n';
            s += 'dragged: ' + (canvas.dragged != null ? canvas.dragged.name : 'none');
            s += '\n';

            td.text = s;

        }

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

    override function onkeydown(e:luxe.Input.KeyEvent) {
        if(canvas!=null) canvas.onkeydown( Convert.key_event(e) );
    }

    override function ontextinput(e:luxe.Input.TextEvent) {
        if(canvas!=null) canvas.ontextinput( Convert.text_event(e) );
    }

    override function onkeyup(e:luxe.Input.KeyEvent) {

        if(e.keycode == Key.key_1) {
            if(window != null) window.open();
        }
        if(e.keycode == Key.key_2) {
            if(window2 != null) window2.open();
        }

        if(e.keycode == Key.key_d && e.mod.ctrl) {
            debug = !debug;
        }

        if(e.keycode == Key.key_v && e.mod.ctrl) {
            if(canvas!=null) canvas.visible = !canvas.visible;
        }

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

        if(canvas!=null) canvas.onkeyup( Convert.key_event(e) );

    } //onkeyup

    function drawc(control:Control) {

        if(!control.visible) return;

        Luxe.draw.rectangle({
            depth: 1000,
            x: control.x,
            y: control.y,
            w: control.w,
            h: control.h,
            color: new Color(1,0,0,0.5),
            immediate: true
        });

        for(c in control.children) {
            drawc(c);
        }

    } //drawc

    override function update(dt:Float) {
        if(canvas!=null) {
            canvas.update(dt);
        }

        if(debug) {
            for(c in canvas.children) {
                drawc(c);
            }
        }
    } //update

    override function ondestroy() {
    } //shutdown

} //Main


