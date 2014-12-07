package mint;

import mint.Types;
import mint.Control;


class Button extends Control {

    public var label : Label;

    public function new(_options:Dynamic) {

            //create the base control
        super(_options);
            //buttons can be clicked
        mouse_enabled = true;
            //create the label
        label = new Label({
            parent : this,
            bounds : _options.bounds.clone().set(0,0),
            text:_options.text,
            point_size:_options.point_size,
            name : name + '.label'
        });

        if(_options.onclick != null) {
            mousedown.listen(_options.onclick);
        }

        renderer.button.init( this, _options );

        //now that we are all created, we ensure that the clip rect is set
        set_clip( clip_rect );

    } //new

    public override function translate(?_x:Float = 0, ?_y:Float = 0, ?_offset:Bool = false ) {
        super.translate( _x, _y, _offset );
        renderer.button.translate( this, _x, _y, _offset );
    }

    public override function set_clip( ?_clip_rect:Rect = null ) {

        super.set_clip(_clip_rect);
        renderer.button.set_clip(this,_clip_rect);

        if(label != null) {
            label.set_clip(_clip_rect);
        }
    }

    public override function set_visible( ?_visible:Bool = true ) {
        super.set_visible(_visible);
        renderer.button.set_visible(this,_visible);
    } //set_visible


    private override function set_depth( _depth:Float ) : Float {

        super.set_depth(_depth);

        renderer.button.set_depth(this, _depth);

        return depth;

    } //set_depth

    public override function onmousedown(e) {
        super.onmousedown(e);
    }

    public override function onmouseup(e) {
        super.onmouseup(e);
    }

}