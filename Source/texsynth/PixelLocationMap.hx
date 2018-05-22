package texsynth;

import haxe.ds.IntMap;
import haxe.ds.Vector;

/**
 * Map like class in order to find the origins of output pixels
 *
 *
 */

class PixelLocationMap
{
	public var map:IntMap<Vector<Int>>;
	//height and width from outputImage
	var width:Int;
	var height:Int;

	public inline function new(lwidth:Int, lheight:Int) {
		map = new IntMap<Vector<Int>>();
		width=lwidth;
		height=lheight;
	}

	public function setLocInOutput(outLoc:Vector<Int>, inLoc:Vector<Int>){
		map.set((seamlessX(outLoc[0]) << 16) | seamlessY(outLoc[1]), inLoc.copy());
	}

	inline public function getLocInOutput(outLoc:Vector<Int>){
		return map.get((seamlessX(outLoc[0]) << 16) | seamlessY(outLoc[1])).copy();
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
