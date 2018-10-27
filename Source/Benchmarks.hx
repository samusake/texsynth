package;
import haxe.Timer;
import texsynth.PixelData;

/**
 * performance tests for PixelData
 * 
 **/

class Benchmarks
{
	static function main()
	{
		var image:PixelData;
		/*
		image = new PixelData(1024, 1024);
		setPixelPerformance(image, 32);
		getPixelPerformance(image, 32);
		
		image = new PixelData(2048, 2048);
		setPixelPerformance(image, 8);
		getPixelPerformance(image, 8);
		*/
		image = new PixelData(4096, 4096);
		setPixelPerformance(image, 2);
		getPixelPerformance(image, 2);
	}

	static function setPixelPerformance(image:PixelData, loops:Int)
	{
		var a:Int = 0;
		var time = Timer.stamp();
		
		for (i in 0...loops) {
			for (x in 0...image.width)
				for (y in 0...image.height)
					image.setPixel(x, y, a);
		}
		time = Timer.stamp() - time;
		trace('PixelData setpixel (${image.width}x${image.height}):\t' + Std.int(time*1000));
	}
	
	static function getPixelPerformance(image:PixelData, loops:Int)
	{
		var a:Int = 0;
		var time = Timer.stamp();
		
		for (i in 0...loops) {
			for (x in 0...image.width)
				for (y in 0...image.height)
					a = image.getPixel(x, y);
		}
		time = Timer.stamp() - time;
		trace('PixelData getpixel (${image.width}x${image.height}):\t' + Std.int(time*1000));

		if (a != 0) trace("ERROR"); // this need because of DCE on cpp
	}	
	
}
