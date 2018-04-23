package texsynth;

import haxe.ds.Vector;

/**
 * stores pixels in a 2d Matrix
 * @author semmi
 */

// OPTIMIZATION: switch here to compare whats faster
typedef PixelMatrix = PixelMatrixVector;
//typedef PixelMatrix = PixelMatrixArray; // slower on cpp ???

class PixelMatrixVector
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	
	var data:Vector<Pixel>;
	
	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		data = new Vector<Pixel>(width * height);
	}
	
	// --------------------------------------------------------

	public inline function getPixel(x:Int, y:Int):Pixel {
		return data.get( y * width + x );
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:Pixel) {
		data.set( y * width + x, pixel );
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):Pixel {
		return getPixel(seamlessX(x), seamlessY(y));
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:Pixel):Void {
		setPixel(seamlessX(x), seamlessY(y), pixel);
	}
	
	// --------------------------------------------------------

	inline function seamlessX(x:Int):Int {
		x = x % width;
		if (x < 0) x += width;
		return x;
	}
	
	inline function seamlessY(y:Int):Int {
		y = y % height;
		if (y < 0) y += height;
		return y;
	}
	
}

// --------------------------------------------------------
// --------------------------------------------------------

class PixelMatrixArray 
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	
	var data:Array<Pixel>;
	
	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		data = new Array<Pixel>();
	}
	
	// --------------------------------------------------------
	
	public inline function getPixel(x:Int, y:Int):Pixel {
		return data[ y * width + x ];
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:Pixel) {
		data[ y * width + x] = pixel;
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):Pixel {
		return getPixel(seamlessX(x), seamlessY(y));
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:Pixel):Void {
		setPixel(seamlessX(x), seamlessY(y), pixel);
	}
	
	// --------------------------------------------------------

	inline function seamlessX(x:Int):Int {
		x = x % width;
		if (x < 0) x += width;
		return x;
	}
	
	inline function seamlessY(y:Int):Int {
		y = y % height;
		if (y < 0) y += height;
		return y;
	}
	
}