package mint.render.luxe;

import mint.Types;
import mint.Renderer;

import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import luxe.Text;
import luxe.Color;
import luxe.Log.*;

private typedef LuxeMintLabelOptions = {
    var color_normal: Color;
    var color_hover: Color;
}

class Label extends mint.render.Base {

    public var label : mint.Label;
    public var text : Text;

    public var color_hover: Color;
    public var color_normal: Color;

    var render: LuxeMintRender;

    public function new( _render:LuxeMintRender, _control:mint.Label ) {

        label = _control;
        render = _render;

        super(render, _control);

        var _opt: LuxeMintLabelOptions = label.options.options;

        color_normal = def(_opt.color_normal, new Color().rgb(0xffffff));
        color_hover = def(_opt.color_hover, new Color().rgb(0x9dca63));

        text = new luxe.Text({
            batcher: render.options.batcher,
            bounds: new luxe.Rectangle(control.x, control.y, control.w, control.h),
            color: color_normal,
            text: label.text,
            bounds_wrap: label.options.bounds_wrap,
            align: Convert.text_align(label.options.align),
            align_vertical: Convert.text_align(label.options.align_vertical),
            point_size: label.options.text_size,
            depth: render.options.depth + control.depth,
            group: render.options.group,
            visible: control.visible,
        });

        text.clip_rect = Convert.bounds(control.clip_with);

        connect();

        label.onchange.listen(ontext);

        control.onmouseenter.listen(function(e,c){ text.color = color_hover; });
        control.onmouseleave.listen(function(e,c){ text.color = color_normal; });

    }

    override function onbounds() {
        text.bounds = new luxe.Rectangle(control.x, control.y, control.w, control.h);
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

    override function onclip(_disable:Bool, _x:Float, _y:Float, _w:Float, _h:Float) {
        if(_disable) {
            text.clip_rect = null;
        } else {
            text.clip_rect = new luxe.Rectangle(_x, _y, _w, _h);
        }
    } //onclip


    override function onvisible( _visible:Bool ) {
        text.visible = _visible;
    } //onvisible

    override function ondepth( _depth:Float ) {
        text.depth = render.options.depth + _depth;
    } //ondepth

} //Label
