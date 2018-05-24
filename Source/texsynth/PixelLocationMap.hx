package texsynth;

import haxe.ds.IntMap;

/**
 * Map like class in order to find the origins of output pixels
 *
 *
 */

class PixelLocationMap
{
	public var map:IntMap<Vec2<Int>>;
	
	// height and width from outputImage
	var width :Int;
	var height:Int;

	public inline function new(width:Int, height:Int) {
		this.width  = width;
		this.height = height;
		map = new IntMap<Vec2<Int>>();
	}

	public inline function setLocInOutput(outLoc:Vec2<Int>, inLoc:Vec2<Int>):Void {
		map.set((seamlessX(outLoc.x) << 16) | seamlessY(outLoc.y), inLoc.copy()); // TODO: bitshifting did not work on neko
	}

	public inline function getLocInOutput(outLoc:Vec2<Int>):Vec2<Int> {
		return map.get((seamlessX(outLoc.x) << 16) | seamlessY(outLoc.y)).copy(); // TODO: bitshifting did not work on neko
	}

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
