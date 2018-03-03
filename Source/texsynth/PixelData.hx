package texsynth;

import openfl.display.BitmapData;

/**
 * Stores PixelData in a PixelMatrix (haxe.ds.Vector abstract)
 * 
 * autoconverts on demand for BitmapData (OpenFl)
 * 
 * @author semmi
 * 
 */

@:forward( width, height, getPixel, setPixel, randomize)
abstract PixelData<T>(PixelMatrix<T>) from PixelMatrix<T> to PixelMatrix<T>
{
	public inline function new<T>(width:Int, height:Int) {
		this = new PixelMatrix<T>( width, height);
	}
	
	@:from static public function fromBitmapData<T>(bitmapdata:BitmapData):PixelData<T> {
		var pixeldata = new PixelData<T>(bitmapdata.width, bitmapdata.height);
		for (x in 0...bitmapdata.width)
			for (y in 0...bitmapdata.height)
				pixeldata.setPixel(x, y, cast bitmapdata.getPixel(x, y));
		return pixeldata;
	}
	
	@:to inline public function toBitmapData():BitmapData {
		var bitmapdata = new BitmapData(this.width, this.height);
		for (x in 0...this.width)
			for (y in 0...this.height)
				bitmapdata.setPixel(x, y, cast this.getPixel(x, y));
		return bitmapdata;
	}

}

