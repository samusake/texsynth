package texsynth;

import haxe.ds.Vector;

/**
 * stores pixels in a 2d Matrix
 * @author semmi
 */

// OPTIMIZATION: switch here to compare whats faster
typedef PixelMatrix<T> = PixelMatrixVector<T>;

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
	
	public inline function randomize() {
		for (i in 0...data.length)
			data.set(i, cast ( Math.random()*0xffffff) );
	}
	
	public inline function getPixel(x:Int, y:Int):T {
		return data.get( y * width + x );
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:T) {
		data.set( y * width + x, pixel );
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):T {
		x = x % width;  if (x < 0) x += width;
		y = y % height; if (y < 0) y += height;
		return getPixel(x, y);
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:T) {
		x = x % width;  if (x < 0) x += width;
		y = y % height; if (y < 0) y += height;
		setPixel(x, y, pixel);
	}
	
}

// slower on cpp ???
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
	
	public inline function getPixel(x:Int, y:Int):T {
		return data[ y * width + x ];
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:T) {
		data[ y * width + x] = pixel;
	}
	
	public inline function getPixelSeamless(x:Int, y:Int):T {
		x = x % width;  if (x < 0) x += width;
		y = y % height; if (y < 0) y += height;
		return getPixel(x, y);
	}
	
	public inline function setPixelSeamless(x:Int, y:Int, pixel:T) {
		x = x % width;  if (x < 0) x += width;
		y = y % height; if (y < 0) y += height;
		setPixel(x, y, pixel);
	}
	
}