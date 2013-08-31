package minterface;

import luxe.Rectangle;
import luxe.Vector;
import luxe.Color;

import minterface.MIControl;

class MICanvas extends MIControl {

	public var focused : MIControl;
	public var _child_depth : Float = 0;

	public function new( _options:Dynamic ) {

		if(_options == null) throw "No options given to canvas, at least a MIRenderer is required.";
		if(_options.renderer == null) throw "No renderer given to MICanvas, cannot create this way.";
		if(_options.name == null) _options.name = 'canvas';
		if(_options.bounds == null) _options.bounds = new Rectangle(0, 0, Luxe.screen.w, Luxe.screen.h );

		renderer = _options.renderer;

		super(_options);
		if(_options.parent == null) {
			canvas = this;
		} else {
			canvas = _options.parent;
		} //parent null

		mouse_enabled = true;
		focused = null;
		depth = _options.depth;

		debug_color = new Color(0.5,0,0,0.5);		

		renderer.canvas.init( this, _options );

	} //new

	public override function set_visible( ?_visible:Bool = true ) {
		super.set_visible(_visible);
		renderer.canvas.set_visible(this, _visible);
	} //set_visible


	public function next_depth() {
		depth++;
		return depth;
	} //next_depth

	public override function add( child:MIControl ) {
		super.add(child);		
	} //add

	public function update(dt:Float) {
		_debug();
	} //update

	public function destroy(){

	} //destroy

} //MICanvas