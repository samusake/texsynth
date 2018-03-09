package texsynth;

import haxe.ds.Vector;

/**
 * stores pixels in a 2d Matrix
 * @author semmi
 */

// OPTIMIZATION: switch here to compare whats faster
typedef PixelMatrix<T> = PixelMatrixVector<T>;
//typedef PixelMatrix<T> = PixelMatrixArray<T>; // slower on cpp ???

class PixelMatrixVector<T>
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	
	var data:Vector<T>;
	
	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		data = new Vector<T>(width * height);
	}
	
	// --------------------------------------------------------

	public inline function getPixel(x:Int, y:Int):T {
		return data.get( y * width + x );
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:T) {
		data.set( y * width + x, pixel );
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):T {
		return getPixel(seamlessX(x), seamlessY(y));
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:T):Void {
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

class PixelMatrixArray<T> 
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	
	var data:Array<T>;
	
	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		data = new Array<T>();
	}
	
	public inline function randomize() {
		for (i in 0...data.length)
			data.push( cast ( Math.random()*0xffffff) );
	}
	
	// --------------------------------------------------------
	
	public inline function getPixel(x:Int, y:Int):T {
		return data[ y * width + x ];
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:T) {
		data[ y * width + x] = pixel;
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):T {
		return getPixel(seamlessX(x), seamlessY(y));
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:T):Void {
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