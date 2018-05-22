package texsynth;

import haxe.ds.Vector;
import haxe.ds.IntMap;

class CoherentSynthesis {

	public static function render(pixelType:PixelType, input:PixelData, output:PixelData,
	                              neighborsX:Int = 1, neighborsY:Int = 2,  neighborsOutside:Bool = false,
								  passes:Int = 1):PixelData {

		var pixelMath = new PixelMath(pixelType);
		output.randomize();

		//var ixStart:Int = (neighborsOutside) ? 0 : neighborsX;
		//var iyStart:Int = (neighborsOutside) ? 0 : neighborsY;

		var bestx:Int = 0;
		var besty:Int = 0;

		var bestd:Float;
		var tempd:Float;


		var pixellocinOutput:PixelLocationMap = new PixelLocationMap(output.width, output.height); //Pixelloc output -> Pixelloc input
		var curloc   :Vector<Int> = new Vector<Int>(2);
		var candidate:Vector<Int> = new Vector<Int>(2);
		var curneigh :Vector<Int> = new Vector<Int>(2);


		//randomize pixellocinOutput
		for(y in 0...output.height){
			for(x in 0...output.width){
				candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
				candidate[1]=cast(Std.random(input.height - neighborsY));
				curloc[0]=x;
				curloc[1]=y;
				pixellocinOutput.setLocInOutput(curloc, candidate);
			}
		}

		for (p in 0...passes) {

			// for every pixel in output image
			for (y in 0...output.height - neighborsY) { trace('render line $y');
				curloc[1]=y;
				for (x in 0...output.width) {

					curloc[0]=x;

					bestd = pixelMath.norm2Max*(neighborsX+(2*neighborsX+1)*neighborsY);

					for (cx in 1...neighborsX+1) {
						tempd=0;
						curneigh[0]=curloc[0] - cx;
						curneigh[1]=curloc[1];
						candidate = pixellocinOutput.getLocInOutput(curneigh);
						candidate[0] = candidate[0] + cx;
						if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
								candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
								candidate[1]=cast(Std.random(input.height - neighborsY));
						}

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1]), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1)
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] - ny), output.getPixelSeamless(x - nx, y - ny));

						if (tempd < bestd) {
							bestd = tempd;
							bestx = candidate[0];
							besty = candidate[1];
						}

					}
					for (cx in (0-neighborsX)...neighborsX+1) {
						for (cy in 1...neighborsY + 1) {
							tempd=0;
							curneigh[0]=curloc[0] - cx;
							curneigh[1]=curloc[1] - cy;
							candidate = pixellocinOutput.getLocInOutput(curneigh);
							candidate[0] = candidate[0] + cx;
							candidate[1] = candidate[1] + cy;
							if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
									candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
									candidate[1]=cast(Std.random(input.height - neighborsY));
							}

							for (nx in 1...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1]), output.getPixelSeamless(x - nx, y));
							for (nx in (0-neighborsX)...neighborsX+1)
								for (ny in 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] - ny), output.getPixelSeamless(x - nx, y - ny));

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

					pixellocinOutput.setLocInOutput(curloc, candidate);
				}
			}


			for (y in output.height - neighborsY...output.height) { trace('render line $y');
				curloc[1]=y;
				for (x in 0...output.width) {

					curloc[0]=x;

					bestd = pixelMath.norm2Max*(4*neighborsX*neighborsY);

					for (cx in 1...neighborsX+1) {
						tempd=0;
						curneigh[0]=curloc[0] - cx;
						curneigh[1]=curloc[1];
						candidate = pixellocinOutput.getLocInOutput(curneigh);
						candidate[0] = candidate[0] + cx;
						if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
								candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
								candidate[1]=cast(Std.random(input.height - neighborsY));
						}

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1]), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1) {
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] - ny), output.getPixelSeamless(x - nx, y - ny));
							for (ny in output.height - y + 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] + ny), output.getPixelSeamless(x - nx, y + ny));
						}
						if (tempd < bestd) {
							bestd = tempd;
							bestx = candidate[0];
							besty = candidate[1];
						}

					}
					for (cx in (0-neighborsX)...neighborsX+1) {
						for (cy in 1...neighborsY + 1) {
							tempd=0;
							curneigh[0]=curloc[0] - cx;
							curneigh[1]=curloc[1] - cy;
							candidate = pixellocinOutput.getLocInOutput(curneigh);
							candidate[0] = candidate[0] + cx;
							candidate[1] = candidate[1] + cy;
							if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
									candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
									candidate[1]=cast(Std.random(input.height - neighborsY));
							}

							for (nx in 1...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1]), output.getPixelSeamless(x - nx, y));
							for (nx in (0-neighborsX)...neighborsX+1) {
								for (ny in 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] - ny), output.getPixelSeamless(x - nx, y - ny));
								for (ny in output.height - y + 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] + ny), output.getPixelSeamless(x - nx, y + ny));
							}
							if (tempd < bestd) {
								bestd = tempd;
								bestx = candidate[0];
								besty = candidate[1];
							}

						}
						for (cy in output.height - y + 1...neighborsY + 1) {
							tempd=0;
							curneigh[0]=curloc[0] - cx;
							curneigh[1]=curloc[1] + cy;
							candidate = pixellocinOutput.getLocInOutput(curneigh);
							candidate[0] = candidate[0] + cx;
							candidate[1] = candidate[1] - cy;
							if (candidate[0] > input.width - neighborsX || candidate[1] > input.height - neighborsY) {
									candidate[0]=cast(Std.random(input.width - 2 * neighborsX)) + neighborsX;
									candidate[1]=cast(Std.random(input.height - neighborsY));
							}

							for (nx in 1...neighborsX + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1]), output.getPixelSeamless(x - nx, y));
							for (nx in (0-neighborsX)...neighborsX+1) {
								for (ny in 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] - ny), output.getPixelSeamless(x - nx, y - ny));
								for (ny in output.height - y + 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate[0] - nx, candidate[1] + ny), output.getPixelSeamless(x - nx, y + ny));
							}

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

					pixellocinOutput.setLocInOutput(curloc, candidate);
				}
			}
		}

		return output;
	}

}
