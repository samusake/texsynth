package texsynth;

//import haxe.macro.Expr;

typedef Pixel = RGB;

class FullSynthesisSimple {
	
	public static function render(input:PixelData<Pixel>, output:PixelData<Pixel>,
	                              neighborsX:Int = 1, neighborsY:Int = 2,  neighborsOutside:Bool = false,
								  passes:Int = 1):PixelData<Pixel> {
		
		var ixStart:Int = (neighborsOutside) ? 0 : neighborsX;
		var iyStart:Int = (neighborsOutside) ? 0 : neighborsY;
				
		var bestx:Int = 0;
		var besty:Int = 0;
		
		var bestd:Float;
		var tempd:Float;
		
		for (p in 0...passes) {

			// for every pixel in output image
			for (y in 0...output.height) { trace('render line $y');
				for (x in 0...output.width) {
					
					bestd = Pixel.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
					
					// for every pixel in input image
					for (iy in iyStart...input.height) {
						for (ix in ixStart...input.width - ixStart) {
							
							tempd = 0;
							
							//absErrorNorm2Enrolled(2, 3, false);
							if (neighborsOutside) 
							{
								for (nx in 1...neighborsX + 1)
									tempd += input.getPixelSeamless(ix - nx, iy).absErrorNorm2(output.getPixelSeamless(x - nx, y));
								for (nx in (0-neighborsX)...neighborsX+1)
									for (ny in 1...neighborsY + 1)
										tempd += input.getPixelSeamless(ix - nx, iy - ny).absErrorNorm2(output.getPixelSeamless(x - nx, y - ny));
							}
							else {
								for (nx in 1...neighborsX + 1)
									tempd += input.getPixel(ix - nx, iy).absErrorNorm2(output.getPixelSeamless(x - nx, y));
								for (nx in (0-neighborsX)...neighborsX+1)
									for (ny in 1...neighborsY + 1)
										tempd += input.getPixel(ix - nx, iy - ny).absErrorNorm2(output.getPixelSeamless(x - nx, y - ny));
							}
															
							// store pixel if neighbors of input and output is more simmiliar 
							if (tempd < bestd) {
								bestd = tempd;
								bestx = ix;
								besty = iy;	
							}
						}
					}
					output.setPixel(x, y, input.getPixel(bestx, besty));
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