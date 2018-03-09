package texsynth;

// this is part from Color Sample ( see haxe cookbook: https://code.haxe.org/category/abstract-types/color.html )

abstract RGB(Int) from Int to Int {

	inline function new(rgb : Int) this = rgb;
	
	public static inline function fromRGB(r : Int, g : Int, b : Int) : RGB {
		return new RGB((r << 16) | (g << 8) | b);
	}

	public var r(get, set):Int;
	public var g(get, set):Int;
	public var b(get, set):Int;

	inline function get_r() return (this >> 16) & 0xff;
	inline function get_g() return (this >>  8) & 0xff;
	inline function get_b() return this & 0xff;

	inline function set_r(r:Int) { this = fromRGB(r, g, b); return r; }
	inline function set_g(g:Int) { this = fromRGB(r, g, b); return g; }
	inline function set_b(b:Int) { this = fromRGB(r, g, b); return b; }
	
	public static inline var absErrorNorm2Max:Int = 255*255*3;
	public inline function absErrorNorm2(with:RGB):Float {
		return (with.r - r) * (with.r - r) +
		       (with.g - g) * (with.g - g) +
		       (with.b - b) * (with.b - b);
	}
	
	public static inline function newRandomPixelData(width:Int, height:Int):PixelData<RGB> {
		return randomize(new PixelData<RGB>(width, height));
	}
	
	public static inline function randomize(pixelData:PixelData<RGB>):PixelData<RGB> {
		for (x in 0...pixelData.width)
			for (y in 0...pixelData.height)
				pixelData.setPixel(x, y, Std.random(0x1000000));
		return pixelData;
	}
	
}
