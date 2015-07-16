package mint.render.luxe;

import mint.Types;
import mint.Renderer;

import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import luxe.Text;
import luxe.Color;
import luxe.Log.log;
import luxe.Log._debug;

class Label extends mint.render.Base {

    public var label : mint.Label;
    public var text : Text;

    public var hover_color: Int = 0x9dca63;
    public var normal_color: Int = 0xffffff;

    public function new( _render:Renderer, _control:mint.Label ) {

        super(_render, _control);
        label = _control;

        _debug('create / ${control.name}');
        text = new luxe.Text({
            bounds: Convert.rect(control.real_bounds),
            color: new Color(),
            text: label.text,
            bounds_wrap: label.options.bounds_wrap,
            align: Convert.text_align(label.options.align),
            align_vertical: Convert.text_align(label.options.align_vertical),
            point_size: label.options.point_size,
            depth: control.depth,
            visible: control.visible,
        });

        text.clip_rect = Convert.rect(control.clip_rect);

        connect();
        label.onchange.listen(ontext);
        control.mouseenter.listen(function(e,c){
            text.color.rgb(hover_color);
        });
        control.mouseleave.listen(function(e,c){
            text.color.rgb(normal_color);
        });
    }

    override function onbounds() {
        text.bounds = new luxe.Rectangle(control.real_bounds.x, control.real_bounds.y, control.real_bounds.w, control.real_bounds.h );
    }

    function ontext(_text:String) {
        text.text = _text;
    }

    override function ondestroy() {
        disconnect();
        label.onchange.remove(ontext);

        text.destroy();
        text = null;

        destroy();
    }

    override function onclip( _rect:Rect ) {
        _debug('clip / $_rect');
        if(_rect == null) text.clip_rect = null;
        else text.clip_rect = Convert.rect(_rect);
    } //onclip

    override function ontranslate( _x:Float=0.0, _y:Float=0.0, _offset:Bool=false ) {
        _debug('translate / $_x / $_y / $_offset');
        text.pos.add_xyz(_x, _y);
    } //ontranslate

    override function onvisible( _visible:Bool ) {
        _debug('visible / $_visible');
        text.visible = _visible;
    } //onvisible

    override function ondepth( _depth:Float ) {
        _debug('depth / $_depth');
        text.depth = _depth;
    } //ondepth

} //Label
