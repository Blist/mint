
[![Logo](../../../images/logo.png)](../../../api/index.html)

<hr/>
<a href="#" id="search_bar" onclick="return;"><div> search API <em>(or start typing anywhere)</em> </div></a>
<hr/>

<script src="../../../js/omnibar.js"> </script>
<link rel="stylesheet" type="text/css" href="../../../css/omnibar.css" media="all">

<div id="omnibar"> <a href="#" onclick="return" id="omnibar_close"></a> <input id="omnibar_text" type="text" placeholder="search types..."></input></div>
<script  id="typelist" data-relpath="../../../" data-types="mint.Button,mint.ButtonOptions,mint.Canvas,mint.CanvasOptions,mint.Checkbox,mint.CheckboxOptions,mint.ChildBounds,mint.Control,mint.ControlOptions,mint.Dropdown,mint.DropdownOptions,mint.Image,mint.ImageOptions,mint.KeySignal,mint.Label,mint.LabelOptions,mint.List,mint.ListOptions,mint.MouseSignal,mint.Panel,mint.PanelOptions,mint.Progress,mint.ProgressOptions,mint.Scroll,mint.ScrollOptions,mint.Slider,mint.SliderOptions,mint.TextEdit,mint.TextEditOptions,mint.TextSignal,mint.Window,mint.WindowOptions,mint.core.DebugError,mint.core.Macros,mint.core.Signal,mint.core.unifill.CodePoint,mint.core.unifill.CodePointIter,mint.core.unifill.Exception,mint.core.unifill.InternalEncoding,mint.core.unifill.InternalEncodingBackwardIter,mint.core.unifill.InternalEncodingIter,mint.core.unifill.Unicode,mint.core.unifill.Unifill,mint.core.unifill.Utf16,mint.core.unifill.Utf32,mint.core.unifill.Utf8,mint.core.unifill._CodePoint.CodePoint_Impl_,mint.core.unifill._InternalEncoding.UtfX,mint.core.unifill._Utf16.StringU16,mint.core.unifill._Utf16.StringU16Buffer,mint.core.unifill._Utf16.StringU16Buffer_Impl_,mint.core.unifill._Utf16.StringU16_Impl_,mint.core.unifill._Utf16.Utf16Impl,mint.core.unifill._Utf16.Utf16_Impl_,mint.core.unifill._Utf32.Utf32_Impl_,mint.core.unifill._Utf8.StringU8,mint.core.unifill._Utf8.StringU8_Impl_,mint.core.unifill._Utf8.Utf8Impl,mint.core.unifill._Utf8.Utf8_Impl_,mint.focus.Focus,mint.layout.margins.AnchorType,mint.layout.margins.Layouts,mint.layout.margins.MarginTarget,mint.layout.margins.MarginType,mint.layout.margins.Margins,mint.layout.margins.SizeTarget,mint.layout.margins._Margins.Anchor,mint.layout.margins._Margins.AnchorType_Impl_,mint.layout.margins._Margins.Margin,mint.layout.margins._Margins.MarginTarget_Impl_,mint.layout.margins._Margins.MarginType_Impl_,mint.layout.margins._Margins.SizeTarget_Impl_,mint.layout.margins._Margins.Sizer,mint.render.Render,mint.render.Renderer,mint.render.Rendering,mint.render.luxe.Button,mint.render.luxe.Canvas,mint.render.luxe.Checkbox,mint.render.luxe.Convert,mint.render.luxe.Dropdown,mint.render.luxe.Image,mint.render.luxe.Label,mint.render.luxe.List,mint.render.luxe.LuxeMintRender,mint.render.luxe.Panel,mint.render.luxe.Progress,mint.render.luxe.Scroll,mint.render.luxe.Slider,mint.render.luxe.TextEdit,mint.render.luxe.Window,mint.render.luxe._Button.LuxeMintButtonOptions,mint.render.luxe._Canvas.LuxeMintCanvasOptions,mint.render.luxe._Checkbox.LuxeMintCheckboxOptions,mint.render.luxe._Dropdown.LuxeMintDropdownOptions,mint.render.luxe._Image.LuxeMintImageOptions,mint.render.luxe._Label.LuxeMintLabelOptions,mint.render.luxe._List.LuxeMintListOptions,mint.render.luxe._Panel.LuxeMintPanelOptions,mint.render.luxe._Progress.LuxeMintProgressOptions,mint.render.luxe._Scroll.LuxeMintScrollOptions,mint.render.luxe._Slider.LuxeMintSliderOptions,mint.render.luxe._TextEdit.LuxeMintTextEditOptions,mint.render.luxe._Window.LuxeMintWindowOptions,mint.types.Helper,mint.types.InteractState,mint.types.KeyCode,mint.types.KeyEvent,mint.types.ModState,mint.types.MouseButton,mint.types.MouseEvent,mint.types.TextAlign,mint.types.TextEvent,mint.types.TextEventType,mint.types._Types.InteractState_Impl_,mint.types._Types.KeyCode_Impl_,mint.types._Types.MouseButton_Impl_,mint.types._Types.TextAlign_Impl_"></script>


<h1>ModState</h1>
<small>`mint.types.ModState`</small>

Input modifier state

<hr/>

`typedef`
<hr/>


&nbsp;
&nbsp;




<h3>Members</h3> <hr/><span class="member apipage">
                <a name="shift"><a class="lift" href="#shift">shift</a></a><div class="clear"></div>
                <code class="signature apipage">shift : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left or right shift key is down</span><br/><span class="member apipage">
                <a name="rshift"><a class="lift" href="#rshift">rshift</a></a><div class="clear"></div>
                <code class="signature apipage">rshift : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">right shift key is down</span><br/><span class="member apipage">
                <a name="rmeta"><a class="lift" href="#rmeta">rmeta</a></a><div class="clear"></div>
                <code class="signature apipage">rmeta : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">right windows/command key is down</span><br/><span class="member apipage">
                <a name="rctrl"><a class="lift" href="#rctrl">rctrl</a></a><div class="clear"></div>
                <code class="signature apipage">rctrl : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">right ctrl key is down</span><br/><span class="member apipage">
                <a name="ralt"><a class="lift" href="#ralt">ralt</a></a><div class="clear"></div>
                <code class="signature apipage">ralt : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">right alt/option key is down</span><br/><span class="member apipage">
                <a name="num"><a class="lift" href="#num">num</a></a><div class="clear"></div>
                <code class="signature apipage">num : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">numlock is enabled</span><br/><span class="member apipage">
                <a name="none"><a class="lift" href="#none">none</a></a><div class="clear"></div>
                <code class="signature apipage">none : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">no modifiers are down</span><br/><span class="member apipage">
                <a name="mode"><a class="lift" href="#mode">mode</a></a><div class="clear"></div>
                <code class="signature apipage">mode : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">mode key is down</span><br/><span class="member apipage">
                <a name="meta"><a class="lift" href="#meta">meta</a></a><div class="clear"></div>
                <code class="signature apipage">meta : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left or right windows/command key is down</span><br/><span class="member apipage">
                <a name="lshift"><a class="lift" href="#lshift">lshift</a></a><div class="clear"></div>
                <code class="signature apipage">lshift : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left shift key is down</span><br/><span class="member apipage">
                <a name="lmeta"><a class="lift" href="#lmeta">lmeta</a></a><div class="clear"></div>
                <code class="signature apipage">lmeta : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left windows/command key is down</span><br/><span class="member apipage">
                <a name="lctrl"><a class="lift" href="#lctrl">lctrl</a></a><div class="clear"></div>
                <code class="signature apipage">lctrl : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left ctrl key is down</span><br/><span class="member apipage">
                <a name="lalt"><a class="lift" href="#lalt">lalt</a></a><div class="clear"></div>
                <code class="signature apipage">lalt : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left alt/option key is down</span><br/><span class="member apipage">
                <a name="ctrl"><a class="lift" href="#ctrl">ctrl</a></a><div class="clear"></div>
                <code class="signature apipage">ctrl : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left or right ctrl key is down</span><br/><span class="member apipage">
                <a name="caps"><a class="lift" href="#caps">caps</a></a><div class="clear"></div>
                <code class="signature apipage">caps : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">capslock is enabled</span><br/><span class="member apipage">
                <a name="alt"><a class="lift" href="#alt">alt</a></a><div class="clear"></div>
                <code class="signature apipage">alt : [Bool](http://api.haxe.org/Bool.html)</code><br/></span>
            <span class="small_desc_flat">left or right alt/option key is down</span><br/>



<hr/>

&nbsp;
&nbsp;
&nbsp;
&nbsp;