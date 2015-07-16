package mint;


@:enum
abstract TextAlign(Int) from Int to Int {
    var unknown = 0;
    var left = 1;
    var right = 2;
    var center = 3;
    var top = 4;
    var bottom = 5;
}

/** A typed state for mouse, touch, or pressed/similar */
@:enum
abstract InteractState(Int) from Int to Int {

/** An unknown state */
    var unknown = 0;
/** An none state */
    var none = 1;
/** In a pressed state */
    var down = 2;
/** In a released state */
    var up = 3;
/** In a moving state */
    var move = 4;
/** A mouse wheel state */
    var wheel = 5;
/** A gamepad axis state */
    var axis = 6;

} //InteractState

/** A typed mouse button id */
@:enum
abstract MouseButton(Int) from Int to Int {

/** no mouse buttons */
    var none = -1;
/** left mouse button */
    var left = 0;
/** middle mouse button */
    var middle = 1;
/** right mouse button */
    var right = 2;
/** extra button pressed  */
    var extra1 = 3;
/** extra button pressed  */
    var extra2 = 4;

} //MouseButton

/** A typed key id */
@:enum
abstract KeyCode(Int) from Int to Int {

/** no known key */
    var unknown = -1;
/** left arrow key */
    var left = 0;
/** right arrow key */
    var right = 1;
/** up arrow key */
    var up = 2;
/** down arrow key */
    var down = 3;
/** the backspace key */
    var backspace = 4;
/** the tab key */
    var tab = 5;
/** the delete key */
    var delete = 6;
/** the enter key */
    var enter = 7;

} //KeyCode

/** Input modifier state */
typedef ModState = {

        /** no modifiers are down */
    var none : Bool;
        /** left shift key is down */
    var lshift : Bool;
        /** right shift key is down */
    var rshift : Bool;
        /** left ctrl key is down */
    var lctrl : Bool;
        /** right ctrl key is down */
    var rctrl : Bool;
        /** left alt/option key is down */
    var lalt : Bool;
        /** right alt/option key is down */
    var ralt : Bool;
        /** left windows/command key is down */
    var lmeta : Bool;
        /** right windows/command key is down */
    var rmeta : Bool;
        /** numlock is enabled */
    var num : Bool;
        /** capslock is enabled */
    var caps : Bool;
        /** mode key is down */
    var mode : Bool;
        /** left or right ctrl key is down */
    var ctrl : Bool;
        /** left or right shift key is down */
    var shift : Bool;
        /** left or right alt/option key is down */
    var alt : Bool;
        /** left or right windows/command key is down */
    var meta : Bool;

} //ModState


typedef MouseEvent = {

        /** The time in seconds when this mouse event occurred, useful for deltas */
    var timestamp : Float;
        /** The state this event is in */
    var state : InteractState;
        /** The button id, if the event `state` is `down` or `up` */
    var button : MouseButton;
        /** The x position in the window of the mouse event */
    var x : Int;
        /** The y position in the window of the mouse event */
    var y : Int;
        /** The relative x position if `state` is `move` or a window has grabbed state */
    var xrel : Int;
        /** The relative y position if `state` is `move` or a window has grabbed state */
    var yrel : Int;
        /** Whether or not the event should bubble further. set to false to stop propagation */
    var bubble : Bool;

} //MouseEvent

/** A mint specific key event */
typedef KeyEvent = {

        /** The time in seconds when this key event occurred, useful for deltas */
    var timestamp : Float;
        /** The raw keycode of the event */
    var keycode : Int;
        /** The typed mint key for the event */
    var key : KeyCode;
        /** The modifier state */
    var mod : ModState;

} //KeyEvent

/** Information about a text input event */
typedef TextEvent = {

        /** The text that this event has generated */
    var text : String;
        /** The type of text event */
    var type : TextEventType;
        /** The time in seconds when this touch event occurred, use for deltas */
    var timestamp : Float;
        /** The start position, if the `type` is `edit` */
    var start : Int;
        /** The length position, if the `type` is `edit` */
    var length : Int;

} //TextEvent

/** A typed text event type */
enum TextEventType {

/** An unknown event */
    unknown;
/** An edit text typing event */
    edit;
/** An input text typing event */
    input;

} //TextEventType


class Utils {
    static public function clamp (value:Float, a:Float, b:Float) : Float {
        return ( value < a ) ? a : ( ( value > b ) ? b : value );
    }
}

class Point {

	public var x : Float;
	public var y : Float;

	public function new( _x:Float = 0, _y:Float = 0) {

		x = _x;
		y = _y;

	} //new

	public function set( ?_x:Float, ?_y:Float ) : Point {

		var _setx = x;
		var _sety = y;

				//assign new values
			if(_x != null) _setx = _x;
			if(_y != null) _sety = _y;

		x = _setx;
		y = _sety;

		return this;

	} //set

	public function clone() : Point {

		return new Point(x,y);

	} //clone

	public function toString() : String {

		return "{ x:"+x + ", y:" + y + " }" ;

	} //toString

} //Point

class Rect {

    public var x:Float;
    public var y:Float;
    public var w:Float;
    public var h:Float;

    public function new( ?_x:Float = 0,?_y:Float = 0,?_w:Float = 0,?_h : Float = 0 ) {

        x = _x;
        y = _y;
        w = _w;
        h = _h;

    } //new

    public function set( ?_x:Float, ?_y:Float, ?_w:Float, ?_h:Float ) : Rect  {

        var _setx = x;
        var _sety = y;
        var _setw = w;
        var _seth = h;

	            //assign new values
	        if(_x != null) _setx = _x;
	        if(_y != null) _sety = _y;
	        if(_w != null) _setw = _w;
	        if(_h != null) _seth = _h;

        x = _setx;
        y = _sety;
        w = _setw;
        h = _seth;

        return this;

    } //set


    public function clone() : Rect {

        return new Rect(x,y,w,h);

    } //clone

    public function point_inside( _p:Point ) : Bool {

	        if(_p.x < x) return false;
	        if(_p.y < y) return false;
	        if(_p.x > x+w) return false;
	        if(_p.y > y+h) return false;

        return true;

    } //point_inside


    public function toString() : String {

        return "{ x:"+x + ", y:" + y + ", w:" + w  + ", h:" + h  + " }" ;

    } //toString


}
