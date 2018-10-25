package texsynth;

/**
 * stores pixels in a 2d Matrix with different backends
 * @author semmi
 */

class PixelMatrix
{
	public var width(default, null):Int;
	public var height(default, null):Int;
	
	#if PixelMatrixUseArray
	var data:Array<Pixel>;
	#elseif PixelMatrixUseUInt32Array
	var data:haxe.io.UInt32Array;
	#elseif PixelMatrixUseBytes
	var data:haxe.io.Bytes;
	#else
	var data:haxe.ds.Vector<Pixel>;
	#end
	
	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		#if PixelMatrixUseArray
		data = new Array<Pixel>();
		for (i in 0...width * height) data.push(0);
		#elseif PixelMatrixUseUInt32Array
		data = new haxe.io.UInt32Array(width * height);
		#elseif PixelMatrixUseBytes
		data = haxe.io.Bytes.alloc(width * height * 4);
		#else
		data = new haxe.ds.Vector<Pixel>(width * height);
		#end
	}
	
	// --------------------------------------------------------

	public inline function getPixel(x:Int, y:Int):Pixel {
		#if CheckPixelBounds
		if (x<0 || x >= width)  throw('x $x is out of bounds');
		if (y<0 || y >= height) throw('y $y is out of bounds');
		#end
		
		#if PixelMatrixUseArray
		return data[ y * width + x ];
		
		#elseif PixelMatrixUseUInt32Array
		return data.get( y * width + x );
		
		#elseif PixelMatrixUseBytes
		return data.getInt32( (y * width + x) * 4 )
		;
		#else
		return data.get( y * width + x );
		#end
	}
	
	public inline function setPixel(x:Int, y:Int, pixel:Pixel):Void {
		#if CheckPixelBounds
		if (x<0 || x >= width)  throw('x $x is out of bounds');
		if (y<0 || y >= height) throw('y $y is out of bounds');
		#end

		#if PixelMatrixUseArray
		data[ y * width + x] = pixel;
		
		#elseif PixelMatrixUseUInt32Array
		data.set( y * width + x, pixel );
		
		#elseif PixelMatrixUseBytes
		data.setInt32( (y * width + x) * 4, pixel);
		
		#else
		data.set( y * width + x, pixel );
		#end
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
