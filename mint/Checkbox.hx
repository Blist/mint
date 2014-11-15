package mint;

import mint.Types;
import mint.Control;

class Checkbox extends Control {

    public function new(_options:Dynamic) {

            //create the base control
        super(_options);

        renderer.checkbox.init( this, _options );

            //now that we are all created, we ensure that the clip rect is set
        set_clip( clip_rect );

    } //new

    public override function translate(?_x:Float = 0, ?_y:Float = 0, ?_offset:Bool = false ) {
        super.translate( _x, _y, _offset );
        renderer.checkbox.translate( this, _x, _y, _offset );
    }

    public override function set_clip( ?_clip_rect:Rect = null ) {

        super.set_clip(_clip_rect);
        renderer.checkbox.set_clip(this,_clip_rect);

    }

    public override function set_visible( ?_visible:Bool = true ) {
        super.set_visible(_visible);
        renderer.checkbox.set_visible(this,_visible);
    } //set_visible

    private override function set_depth( _depth:Float ) : Float {

        super.set_depth(_depth);

        renderer.checkbox.set_depth(this, _depth);

        return depth;

    } //set_depth

} //Panel