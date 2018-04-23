package texsynth;

//import haxe.macro.Expr;

class FullSynthesis {
	
	public static function render(pixelType:PixelType, input:PixelData, output:PixelData,
	                              neighborsX:Int = 1, neighborsY:Int = 2,
			       	              passes:Int = 1):PixelData {
		
		var pixelMath = new PixelMath(pixelType);
		output.randomize();

		var bestx:Int = 0;
		var besty:Int = 0;
		
		var bestd:Float;
		var tempd:Float;
	
		for (p in 0...passes) {	
		// for every pixel in output image
			for (y in 0...output.height) { trace('render line $y');
				for (x in 0...output.width - neighborsX) {
					
					bestd = pixelMath.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
						
					// for every pixel in input image
					for (iy in neighborsY...input.height) {
						for (ix in neighborsX...input.width - neighborsX) {
							
							tempd = 0;
							
							//absErrorNorm2Enrolled(2, 3, false);
							for (nx in 1...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy), output.getPixelSeamless(x - nx, y));
							for (nx in (0 - neighborsX)...neighborsX + 1)
								for (ny in 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy - ny), output.getPixelSeamless(x - nx, y - ny));
							// store pixel if neighbors of input and output is more similiar 
							if (tempd < bestd) {
								bestd = tempd;
								bestx = ix;
								besty = iy;	
							}
						}
					}
					output.setPixel(x, y, input.getPixel(bestx, besty));
				}
				for (x in output.width - neighborsX...output.width) {
					bestd = pixelMath.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
					
					for (iy in neighborsY...input.height) {
						for (ix in neighborsX...input.width - neighborsX) {
							tempd = 0; 
	
							for (nx in 1...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy), output.getPixelSeamless(x - nx, y));
							for (nx in output.width - x...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix + nx, iy), output.getPixelSeamless(x + nx, y));
							for (nx in (0 - neighborsX)...neighborsX + 1)
								for (ny in 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy - ny), output.getPixelSeamless(x - nx, y - ny));
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
		for (y in 0...neighborsY) { trace('render line $y');
			for (x in 0...output.width - neighborsX) {
				
				bestd = pixelMath.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
				
				for (iy in neighborsY...input.height - neighborsY) {
					for (ix in neighborsX...input.width - neighborsX) {
						tempd = 0; 

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX + 1) {
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy - ny), output.getPixelSeamless(x - nx, y - ny));
							for (ny in neighborsY - y + 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy + ny), output.getPixelSeamless(x - nx, y + ny));
						}
						if (tempd < bestd) {
							bestd = tempd;
							bestx = ix;
							besty = iy;	
						}
					}
				}
				output.setPixel(x, y, input.getPixel(bestx, besty));

			}
			for(x in output.width-neighborsX...output.width){
				bestd = pixelMath.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);
				
				for (iy in neighborsY...input.height - neighborsY) {
					for (ix in neighborsX...input.width - neighborsX) {
						tempd = 0; 

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy), output.getPixelSeamless(x - nx, y));
						for (nx in output.width - x...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(ix + nx, iy), output.getPixelSeamless(x + nx, y));
						for (nx in (0 - neighborsX)...neighborsX + 1) {
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy - ny), output.getPixelSeamless(x - nx, y - ny));
							for (ny in neighborsY - y + 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(ix - nx, iy + ny), output.getPixelSeamless(x - nx, y + ny));
						}
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
