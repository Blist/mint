package mint.render.luxe;

import mint.Types;
import mint.Renderer;

import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import luxe.Color;
import luxe.Sprite;
import luxe.Vector;
import luxe.Log.log;
import luxe.Log._debug;

class Button extends mint.render.Base {

    var button : mint.Button;
    var visual : Sprite;

    public function new( _render:Renderer, _control:mint.Button ) {

        super(_render, _control);
        button = _control;

        _debug('create / ${control.name}');
        visual = new luxe.Sprite({
            centered: false,
            pos: new Vector(control.real_bounds.x, control.real_bounds.y),
            size: new Vector(control.real_bounds.w, control.real_bounds.h),
            color: new Color().rgb(0x373737),
            depth: control.depth,
            visible: control.visible,
        });

        visual.clip_rect = Convert.rect(control.clip_rect);

        button.mouseenter.listen(function(e,c) { visual.color.rgb(0x445158); });
        button.mouseleave.listen(function(e,c) { visual.color.rgb(0x373737); });
        button.mousedown.listen(function(e,c) { visual.color.rgb(0x444444); });
        button.mouseup.listen(function(e,c) { visual.color.rgb(0x445158); });

        connect();
    }


    override function onbounds() {
        visual.transform.pos.set_xy(control.real_bounds.x, control.real_bounds.y);
        visual.geometry_quad.resize_xy( control.real_bounds.w, control.real_bounds.h );
    }

    override function ondestroy() {
        disconnect();

        visual.destroy();
        visual = null;

        destroy();
    }

    override function onclip( _rect:Rect ) {
        _debug('clip / $_rect');
        if(_rect == null) visual.clip_rect = null;
        else visual.clip_rect = Convert.rect(_rect);
    } //onclip

    override function ontranslate( _x:Float=0.0, _y:Float=0.0, _offset:Bool=false ) {
        _debug('translate / $_x / $_y / $_offset');
        visual.pos.add_xyz(_x, _y);
    } //ontranslate

    override function onvisible( _visible:Bool ) {
        _debug('visible / $_visible');
        visual.visible = _visible;
    } //onvisible

    override function ondepth( _depth:Float ) {
        _debug('depth / $_depth');
        visual.depth = _depth;
    } //ondepth

} //Button
