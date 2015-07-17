package mint;

import mint.Types;
import mint.Signal;
import mint.Renderer;
import mint.Macros.*;
import mint.Types.Utils.in_rect;

typedef ControlOptions = {

        /** The control name */
    @:optional var name: String;

        /** The control x position, relative to its container */
    @:optional var x: Float;
        /** The control y position, relative to its container */
    @:optional var y: Float;
        /** The control width */
    @:optional var w: Float;
        /** The control height */
    @:optional var h: Float;

        /** The control parent, if any */
    @:optional var parent: Control;
        /** The control depth. Usually set internally */
    @:optional var depth: Float;
        /** Whether or not the control is visible at creation */
    @:optional var visible: Bool;
        /** Whether or not the control responds to mouse input */
    @:optional var mouse_input: Bool;
        /** Whether or not the control responds to key input */
    @:optional var key_input: Bool;
        /** Whether or not the control emits render signals from the canvas render call */
    @:optional var does_render: Bool;

} //ControlOptions

/** An empty control.
    Base class for all controls
    handles propogation of events,
    mouse handling, layout and so on */
@:allow(mint.ControlRenderer)
class Control {

        /** The name of this control. default: 'control'*/
    public var name : String = 'control';
        /** Root canvas that this element belongs to */
    public var canvas : Canvas;
        /** the top most control below the canvas that holds us */
    public var closest_to_canvas : Control;

        /** The x position of the control bounds, world coordinate */
    @:isVar public var x (default, set) : Float;
        /** The y position of the control bounds, world coordinate */
    @:isVar public var y (default, set) : Float;
        /** The width of the control bounds */
    @:isVar public var w (default, set) : Float;
        /** The height of the control bounds */
    @:isVar public var h (default, set) : Float;

        /** The x position of the control bounds, relative to its container */
    @:isVar public var x_local (get, set) : Float;
        /** The y position of the control bounds, relative to its container */
    @:isVar public var y_local (get, set) : Float;

        //the clipping rectangle for this control
    public var clip_rect : Rect;
        //the list of children added to this control
    public var children : Array<Control>;

        //if the control is under the mouse
    public var isfocused : Bool = false;
        //if the control is under the mouse
    public var ishovered : Bool = false;
        //if the control accepts mouse events
    public var mouse_input : Bool = false;
        //if the control accepts key events
    public var key_input : Bool = false;
        //if the control emits a render signal
    public var does_render : Bool = false;

        //if the control is visible
    @:isVar public var visible (default, set) : Bool = true;
        //a getter for the bounds information about the children and their children in this control
    @:isVar public var children_bounds (get,null) : ChildBounds;


    public var onrender     : Signal<Void->Void>;
    public var onbounds     : Signal<Void->Void>;
    public var ondestroy    : Signal<Void->Void>;
    public var onvisible    : Signal<Bool->Void>;
    public var ondepth      : Signal<Float->Void>;
    public var onclip       : Signal<Rect->Void>;
    public var onchild      : Signal<Control->Void>;
    public var onmousedown  : Signal<MouseSignal>;
    public var onmouseup    : Signal<MouseSignal>;
    public var onmousemove  : Signal<MouseSignal>;
    public var onmousewheel : Signal<MouseSignal>;
    public var onmouseenter : Signal<MouseSignal>;
    public var onmouseleave : Signal<MouseSignal>;
    public var onkeydown    : Signal<KeySignal>;
    public var onkeyup      : Signal<KeySignal>;
    public var ontextinput  : Signal<TextSignal>;


        //the parent control, null if no parent
    @:isVar public var parent(get,set) : Control;
        //the depth of this control
    @:isVar public var depth(get,set) : Float = 0.0;
        //The concrete renderer for this control instance
    public var renderinst : mint.Renderer.ControlRenderer;

    var ctrloptions : ControlOptions;

    public function new( _options:ControlOptions ) {

        ctrloptions = _options;

        onrender     = new Signal();
        onbounds     = new Signal();
        ondestroy    = new Signal();
        onvisible    = new Signal();
        ondepth      = new Signal();
        onclip       = new Signal();
        onchild      = new Signal();
        onmousedown  = new Signal();
        onmouseup    = new Signal();
        onmousemove  = new Signal();
        onmousewheel = new Signal();
        onmouseleave = new Signal();
        onmouseenter = new Signal();
        onkeydown    = new Signal();
        onkeyup      = new Signal();
        ontextinput  = new Signal();

        children = [];

        // bounds = ctrloptions.bounds == null ? new Rect(0,0,32,32) : ctrloptions.bounds;

        x = def(ctrloptions.x, 0);
        y = def(ctrloptions.y, 0);
        w = def(ctrloptions.w, 32);
        h = def(ctrloptions.h, 32);

        x_local = x;
        y_local = y;

        name = def(ctrloptions.name, 'control');

        if(ctrloptions.mouse_input != null) mouse_input = ctrloptions.mouse_input;
        if(ctrloptions.key_input != null) key_input = ctrloptions.key_input;

        children_bounds = {
            x:0,
            y:0,
            right:0,
            bottom:0,
            real_x : 0,
            real_y : 0,
            real_w : 0,
            real_h : 0
        };

        if(ctrloptions.parent != null) {

            canvas = ctrloptions.parent.canvas;
            depth = canvas.next_depth();
            ctrloptions.parent.add(this);

        } else { //parent != null

            if( !Std.is(this, Canvas) && canvas == null) {
                throw "Control without a canvas " + ctrloptions;
            } //canvas

        }

        closest_to_canvas = find_top_parent();


        if(ctrloptions.does_render != null) {
            does_render = ctrloptions.does_render;
        } else {
            if(canvas != null) {
                does_render = canvas.does_render;
            }
        }

        if(ctrloptions.visible != null) visible = ctrloptions.visible;

    } //new

    public function topmost_child_at_point( _x:Float, _y:Float ) : Control {

            //if we have no children, we are the topmost child
        if(children.length == 0) return this;

            //if we have children, we look at each one, looking for the highest one
            //after we have the highest one, we ask it to return it's own highest child

        var highest_child : Control = this;
        var highest_depth : Float = 0;

        for(_child in children) {
            if(_child.contains(_x, _y) && _child.mouse_input && _child.visible) {

                if(_child.depth >= highest_depth) {
                    highest_child = _child;
                    highest_depth = _child.depth;
                } //highest_depth

            } //child contains point
        } //child in children

        if(highest_child != this && highest_child.children.length != 0) {
            return highest_child.topmost_child_at_point(_x, _y);
        } else {
            return highest_child;
        }

    } //topmost_child_at_point

    public function contains( _x:Float, _y:Float ) {

        var inside = in_rect(_x, _y, x, y, w, h);

        if(clip_rect == null) return inside;

        return inside && in_rect(_x, _y, clip_rect.x, clip_rect.y, clip_rect.w, clip_rect.h);

    } //contains

    function clip_with_closest_to_canvas() {
        if(closest_to_canvas != null) {
            clip_with( closest_to_canvas );
        }
    } //clip_with_closest_to_canvas


    public function clip_with( ?_control:Control ) {
        if(_control != null) {
            set_clip( new Rect(_control.x, _control.y, _control.w, _control.h) );
        } else {
            set_clip();
        }
    } //clip_with

    public function set_clip( ?_clip_rect:Rect = null ) {
        //temporarily, all children clip by their parent clip

        clip_rect = _clip_rect.clone();
        onclip.emit(clip_rect);

        for(_child in children) {
            _child.set_clip( clip_rect );
        }

    } //set clip

    function set_visible( _visible:Bool) {

        visible = _visible;
        onvisible.emit(visible);

        canvas.focus_invalid = true;

        for(_child in children) {
            _child.visible = visible;
        }

        return visible;

    } //set visible

    function find_top_parent( ?_from:Control = null ) {

        var _target = (_from == null) ? this : _from;

        if(_target == null || _target.parent == null) {
            return null;
        }

            //if the parent of the target is not canvas,
            //keep escalating until it is
        if( Std.is( _target.parent, Canvas ) ) {
            return _target;
        } else { //is
            return parent.find_top_parent( this );
        }

    } //find_top_parent

    public var nodes : Int = 0;
    public function add( child:Control ) {

        if(child.parent != null) {
            child.parent.remove(child);
            child.parent = null;
        }

        if(child.parent != this) {
            child.parent = this;
            children.push(child);

            if(parent != null || canvas == this) {
                var _nodes = child.nodes + 1;
                nodes += _nodes;
                if(parent != null) parent.nodes += _nodes;
            }

            onchild.emit(child);
        }
    }

    public function remove( child:Control ) {
        if(child.parent == this) {
            children.remove(child);

            if(parent != null || canvas == this) {
                var _nodes = child.nodes + 1;
                nodes -= _nodes;
                if(parent != null) parent.nodes -= _nodes;
            }

            onchild.emit(child);
        }
    }

    //:todo: getters?
    public inline function right() return x_local + w;
    public inline function bottom() return y_local + h;

    function get_children_bounds() : ChildBounds {

        if(children.length == 0) {

            children_bounds.x = 0;
            children_bounds.y = 0;
            children_bounds.right = 0;
            children_bounds.bottom = 0;
            children_bounds.real_x = 0;
            children_bounds.real_y = 0;
            children_bounds.real_w = 0;
            children_bounds.real_h = 0;

            return children_bounds;

        } //no children

        var _first_child = children[0];

        var _current_x : Float = _first_child.x_local;
        var _current_y : Float = _first_child.y_local;
        var _current_r : Float = _first_child.right();
        var _current_b : Float = _first_child.bottom();

        var _real_x : Float = _first_child.x;
        var _real_y : Float = _first_child.y;

        for(child in children) {

            _current_x = Math.min( child.x_local, _current_x );
            _current_y = Math.min( child.y_local, _current_y );
            _current_r = Math.max( _current_r, child.right() );
            _current_b = Math.max( _current_b, child.bottom() );

            _real_x = Math.min( child.x, _real_x );
            _real_y = Math.min( child.y, _real_y );

        } //child in children

        children_bounds.x = _current_x;
        children_bounds.y = _current_y;
        children_bounds.right = _current_r;
        children_bounds.bottom = _current_b;
        children_bounds.real_x = _real_x;
        children_bounds.real_y = _real_y;
        children_bounds.real_w = _current_r;
        children_bounds.real_h = _current_b;

        return children_bounds;

    } //children_bounds

    public function render() {

        if(does_render) onrender.emit();

        for(child in children) child.render();

    } //render

    public function keyup( e:KeyEvent ) {

        onkeyup.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.keyup(e);
        }

    } //keyup

    public function keydown( e:KeyEvent ) {

        onkeydown.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.keydown(e);
        }

    } //keydown

    public function textinput( e:TextEvent ) {

        ontextinput.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.textinput(e);
        }

    } //textinput

    public function mousemove( e:MouseEvent ) {

        onmousemove.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.mousemove(e);
        }

    } //mousemove

    public function mouseup( e:MouseEvent ) {

        onmouseup.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.mouseup(e);
        }

    } //mouseup

    public function mousewheel( e:MouseEvent ) {

        onmousewheel.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.mousewheel(e);
        }

    } //mousewheel

    public function mousedown( e:MouseEvent ) {

        onmousedown.emit(e, this);

        if( parent != null &&
            parent != canvas &&
            canvas != this &&
            e.bubble )
        {
            parent.mousedown(e);
        }

    } //mousedown

    public function mouseenter( e:MouseEvent ) {

        onmouseenter.emit(e, this);

    } //mouseenter

    public function mouseleave( e:MouseEvent ) {

        onmouseleave.emit(e, this);

    } //mouseleave

    public function destroy() {

        canvas.focus_invalid = true;

        if(parent != null) {
            parent.remove(this);
        }

        ondestroy.emit();

    } //destroy

    public function update(dt:Float) {

    } //update

    var updating = false;
    function bounds_changed(_dx:Float=0.0, _dy:Float=0.0, _dw:Float=0.0, _dh:Float=0.0, ?_offset:Bool = false ) {

        if(updating) return;

        if(_dx != 0.0 || _dy != 0.0) {
            for(child in children) {
                child.set_pos(child.x + _dx, child.y + _dy);
                if(child.clip_rect != null && !_offset) {
                    child.clip_rect.x += _dx;
                    child.clip_rect.y += _dy;
                    child.set_clip(child.clip_rect);
                }
            }
        }

        onbounds.emit();

    } //bounds_changed

//Properties

//Spatial properties

    function set_pos(_x:Float, _y:Float, ?_offset:Bool = false ) {

        updating = true;

        var _dx = _x - x;
        var _dy = _y - y;

        x = _x;
        y = _y;

        updating = false;

        bounds_changed(_dx, _dy, 0, 0, _offset);

    } //set_pos

    function set_size(_w:Float, _h:Float) {

        updating = true;

        var _dw = _w - w;
        var _dh = _h - h;

        w = _w;
        h = _h;

        updating = false;

        bounds_changed(0,0, _dw, _dh);

    } //set_size

    function set_x(_x:Float) : Float {

        var _dx = _x - x;

        x = _x;

        bounds_changed(_dx);

        return x;

    } //set_x

    function set_y(_y:Float) : Float {

        var _dy = _y - y;
        y = _y;

        bounds_changed(0, _dy);

        return y;

    } //set_y

    function set_w(_w:Float) : Float {

        var _dw = _w - w;
        w = _w;
        bounds_changed(0,0, _dw);

        return w;

    } //set_w

    function set_h(_h:Float) : Float {

        var _dh = _h - h;
        h = _h;
        bounds_changed(0,0,0, _dh);

        return h;

    } //set_h

    function set_x_local(_x:Float) : Float {

        x_local = _x;

        if(parent != null) {
            x = parent.x + x_local;
        } else {
            x = x_local;
        }

        return x_local;

    } //set_x_local

    function set_y_local(_y:Float) : Float {

        y_local = _y;

        if(parent != null) {
            y = parent.y + y_local;
        } else {
            y = y_local;
        }

        return y_local;

    } //set_y_local

    function get_x_local() : Float {

        return x_local;

    } //get_x_local

    function get_y_local() : Float {

        return y_local;

    } //get_y_local

//Depth properties

    inline function get_depth() : Float {

        return depth;

    } //get_depth

    function set_depth( _depth:Float ) : Float {

        depth = _depth;
        ondepth.emit(depth);

        if(canvas != this) {
            for(child in children) {
                child.depth = _depth+0.001;
            }
        }

        return depth;

    } //set_depth

//Parent properties

    function set_parent(p:Control) {

        if(parent != null) {
            x -= parent.x;
            y -= parent.y;
        }

        // x_local = x;
        // y_local = y;

        if(p != null) {
            x = p.x + x_local;
            y = p.y + y_local;
        }

        return parent = p;

    } //set_parent

    inline function get_parent() {

        return parent;

    } //get_parent

} //Control


typedef ChildBounds = {

    var x : Float;
    var y : Float;
    var bottom : Float;
    var right : Float;

    var real_y : Float;
    var real_x : Float;
    var real_w : Float;
    var real_h : Float;

} //ChildBounds


    /** A signal for mouse input events */
typedef MouseSignal = MouseEvent->Control->Void;
    /** A signal for key input events */
typedef KeySignal   = KeyEvent->Control->Void;
    /** A signal for text input events */
typedef TextSignal  = TextEvent->Control->Void;
