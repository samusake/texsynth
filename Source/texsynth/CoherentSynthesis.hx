package texsynth;

import haxe.ds.Vector;
import haxe.Constraints;
import haxe.ds.ObjectMap;
//import haxe.macro.Expr;

typedef Pixel = RGB;

class CoherentSynthesis {

	public static function render(input:PixelData<Pixel>, output:PixelData<Pixel>,
	                              neighborsX:Int = 1, neighborsY:Int = 2,  neighborsOutside:Bool = false,
								  passes:Int = 1):PixelData<Pixel> {

		var ixStart:Int = (neighborsOutside) ? 0 : neighborsX;
		var iyStart:Int = (neighborsOutside) ? 0 : neighborsY;

		var bestx:Int = 0;
		var besty:Int = 0;

		var bestd:Float;
		var tempd:Float;


		var pixellocinOutput:Map<Int, Vector<Int>> = new Map<Int, Vector<Int>>(); //Pixelloc output -> Pixelloc input
		var curloc:Vector<Int>=new haxe.ds.Vector(2);
		var candidate:Vector<Int>=new haxe.ds.Vector(2);


		//randomize pixellocinOutput
		for(y in 0...output.height){
			for(x in 0...output.width){
				candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
				candidate[1]=cast(Std.random(input.height - neighborsY));
				pixellocinOutput.set((x << 16) | y, candidate.copy());
			}
		}



		for (p in 0...passes) {

			// for every pixel in output image
			for (y in neighborsY...output.height) { trace('render line $y');
				curloc[1]=y;
				for (x in neighborsX...output.width-neighborsX) {

					curloc[0]=x;

					bestd = Pixel.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
					for (cx in 1...neighborsX+1) {
						tempd=0;

						candidate = pixellocinOutput.get((curloc[0] - cx) << 16 | curloc[1]).copy();
						candidate[0] = candidate[0] + cx;
						if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
								candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
								candidate[1]=cast(Std.random(input.height - neighborsY));
						}

						for (nx in 1...neighborsX + 1)
							tempd += input.getPixel(candidate[0] - nx, candidate[1]).absErrorNorm2(output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1)
							for (ny in 1...neighborsY + 1)
								tempd += input.getPixel(candidate[0] - nx, candidate[1] - ny).absErrorNorm2(output.getPixelSeamless(x - nx, y - ny));

						if (tempd < bestd) {
							bestd = tempd;
							bestx = candidate[0];
							besty = candidate[1];
						}

					}
					for (cx in (0-neighborsX)...neighborsX+1) {
						for (cy in 1...neighborsY + 1) {
							tempd=0;
							candidate = pixellocinOutput.get((curloc[0] - cx) << 16 | curloc[1] - cy).copy();
							candidate[0] = candidate[0] + cx;
							candidate[1] = candidate[1] + cy;
							if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
									candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
									candidate[1]=cast(Std.random(input.height - neighborsY));
							}

							for (nx in 1...neighborsX + 1)
								tempd += input.getPixel(candidate[0] - nx, candidate[1]).absErrorNorm2(output.getPixelSeamless(x - nx, y));
							for (nx in (0-neighborsX)...neighborsX+1)
								for (ny in 1...neighborsY + 1)
									tempd += input.getPixel(candidate[0] - nx, candidate[1] - ny).absErrorNorm2(output.getPixelSeamless(x - nx, y - ny));

							if (tempd < bestd) {
								bestd = tempd;
								bestx = candidate[0];
								besty = candidate[1];
							}

						}
					}
					output.setPixel(x, y, input.getPixel(bestx, besty));

					candidate[0]=bestx;
					candidate[1]=besty;

					pixellocinOutput.set((curloc[0] << 16) | curloc[1],candidate.copy());
				}
			}
		}

		return output;
	}

	// macro to enroll for-loops at compiletime
	/*
	public static macro function absErrorNorm2Enrolled(neighborsX:Int,neighborsY:Int, neighborsOutside:Bool)
	{
		trace(neighborsX, neighborsY, neighborsOutside);

		var e = [
			for (nx in 1...neighborsX + 1)
				if (neighborsOutside)
					macro tempd += input.getPixelSeamless(ix - $v{nx}, iy).absErrorNorm2(output.getPixelSeamless(x - $v{nx}, y))
				else macro tempd += input.getPixel(ix - $v{nx}, iy).absErrorNorm2(output.getPixelSeamless(x - $v{nx}, y))
		];
		e = e.concat([
			for (nx in (0-neighborsX)...neighborsX+1)
				for (ny in 1...neighborsY + 1)
					if (neighborsOutside)
						macro tempd += input.getPixelSeamless(ix - $v{nx}, iy - $v{ny}).absErrorNorm2(output.getPixelSeamless(x - $v{nx}, y - $v{ny}))
					else macro tempd += input.getPixel(ix - $v{nx}, iy - $v{ny}).absErrorNorm2(output.getPixelSeamless(x - $v{nx}, y - $v{ny}))
		]);

		return macro $b{e};
	}
	*/
}
