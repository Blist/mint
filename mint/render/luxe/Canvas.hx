package mint.render.luxe;

import luxe.Vector;
import mint.Types;
import mint.Renderer;

import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import phoenix.geometry.QuadGeometry;
import luxe.Color;
import luxe.Log.log;
import luxe.Log._debug;

class Canvas extends mint.render.Base {

    var canvas : mint.Canvas;
    var visual : QuadGeometry;

    public function new( _render:Renderer, _control:mint.Canvas ) {

        super(_render, _control);
        canvas = _control;

        _debug('create / ${control.name}');
        visual = Luxe.draw.box({
            x:control.x,
            y:control.y,
            w:control.w,
            h:control.h,
            color: new Color(0,0,0,0.2).rgb(0x0c0c0c),
            depth: control.depth,
            visible: control.visible,
            clip_rect: Convert.bounds(control.clip_with),
        });

        connect();

    } //new

    override function ondestroy() {
        _debug('destroy');

        disconnect();

        visual.drop();
        visual = null;

        destroy();
    }

    override function onbounds() {
        visual.transform.pos.set_xy(control.x, control.y);
        visual.resize_xy(control.w, control.h);
    }

    override function onclip(_disable:Bool, _x:Float, _y:Float, _w:Float, _h:Float) {
        if(_disable) {
            visual.clip_rect = null;
        } else {
            visual.clip_rect = new luxe.Rectangle(_x, _y, _w, _h);
        }
    } //onclip


    override function onvisible( _visible:Bool ) {
        _debug('visible / $_visible');
        visual.visible = _visible;
    } //onvisible

    override function ondepth( _depth:Float ) {
        _debug('depth / $_depth');
        visual.depth = _depth;
    } //ondepth

} //Canvas
