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

@:forward( width, height, getPixel, setPixel, getPixelSeamless, setPixelSeamless)
abstract PixelData(PixelMatrix) from PixelMatrix to PixelMatrix
{
	public inline function new(width:Int, height:Int) {
		this = new PixelMatrix( width, height);
	}

	@:from static public function fromBitmapData(bitmapdata:BitmapData):PixelData {
		var pixeldata = new PixelData(bitmapdata.width, bitmapdata.height);
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

	inline public function randomize() {
		for (x in 0...this.width)
			for (y in 0...this.height)
				this.setPixel(x, y, Pixel.random());
	}

	//TODO: FIX THIS FUNCTION (Or is my Picture just not right?)
	inline public function randomizeAlpha() {
		for (x in 0...this.width){
			for (y in 0...this.height) {
				if (this.getPixel(x,y).get_a() == 0)
					this.setPixel(x, y, Pixel.random());
			}
		}
	}

}
