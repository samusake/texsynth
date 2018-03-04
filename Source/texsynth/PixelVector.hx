package texsynth;

import haxe.ds.Vector;

/**
 * stores pixels in a 2d Matrix
 * @author semmi
 */

class PixelVector<T> 
{
	public var length(default, null):Int;
	
	var data:Vector<T>;
	
	public function new(maxLength:Int) {
		data = new Vector<T>(maxLength);
		reset();
	}
	
	public inline function getPixel(x:Int):T {
		return data.get(x);
	}
	
	public inline function setPixel(x:Int, pixel:T) {
		data.set(x, pixel);
	}
	
	public inline function getPixelSeamless(x:Int):T {
		x = x % length;  if (x < 0) x += length;
		return getPixel(x);
	}
	
	public inline function setPixelSeamless(x:Int, pixel:T) {
		x = x % length;  if (x < 0) x += length;
		setPixel(x, pixel);
	}
	
	public inline function push(pixel:T) {
		if (length == data.length) throw("out of bounds");
		setPixel(length++, pixel);
	}
	
	public inline function reset() {
		length = 0;
	}
	
	
	
}