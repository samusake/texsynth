package texsynth;

abstract Pixel(Int) from Int to Int {

	inline function new(argb:Int) this = argb;
	
	public static inline function fromARGB(a:Int, r:Int, g:Int, b:Int):Pixel {
		return new Pixel((a << 24) | (r << 16) | (g << 8) | b);
	}

	public var a(get,set):Int;
	public var r(get,set):Int;
	public var g(get,set):Int;
	public var b(get,set):Int;

	inline function get_a() return (this >> 24) & 0xff; // binary ops did not work on neko here
	inline function get_r() return (this >> 16) & 0xff;
	inline function get_g() return (this >>  8) & 0xff;
	inline function get_b() return this & 0xff;

	inline function set_a(a:Int) {this = fromARGB(a,r,g,b); return a;}
	inline function set_r(r:Int) {this = fromARGB(a,r,g,b); return r;}
	inline function set_g(g:Int) {this = fromARGB(a,r,g,b); return g;}
	inline function set_b(b:Int) {this = fromARGB(a,r,g,b); return b;}
	
	public static inline function random():Pixel {
		return (Std.int(Math.random()*256) << 24) | Std.random(0x1000000);
	}
	
}
