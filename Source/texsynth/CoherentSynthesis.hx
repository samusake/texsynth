package texsynth;

class CoherentSynthesis {

	public static function render(pixelType:PixelType, input:PixelData, output:PixelData,
	                              neighborsX:Int = 1, neighborsY:Int = 2,  neighborsOutside:Bool = false,
								  							turbo:Int = 0):PixelData {

		var pixelMath = new PixelMath(pixelType);
		output.randomize();

		//var ixStart:Int = (neighborsOutside) ? 0 : neighborsX;
		//var iyStart:Int = (neighborsOutside) ? 0 : neighborsY;

		var best = new Vec2<Int>(0, 0);

		var bestd:Float;
		var tempd:Float;


		var pixellocinOutput = new PixelLocationMap(output.width, output.height); // Pixelloc output -> Pixelloc input
		var curloc    = new Vec2<Int>(0, 0);
		var candidate = new Vec2<Int>(0, 0);
		var curneigh  = new Vec2<Int>(0, 0);


		// randomize pixellocinOutput
		for (y in 0...output.height) {
			for (x in 0...output.width) {
				candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
				candidate.y = Std.random(input.height - 2* neighborsY) + neighborsY;
				curloc.set(x, y);
				pixellocinOutput.setLocInOutput(curloc, candidate);
			}
		}

		// for every pixel in output image
		for (y in 0...output.height - neighborsY) {
			trace('render line $y'); // TODO: onProgress callback here (for worker)
			curloc.y = y;
			for (x in 0...output.width) {
				curloc.x = x;
				bestd = 9007199254740992;

				for (cx in 1...neighborsX+1) {
					tempd = 0;
					curneigh.set(curloc.x - cx, curloc.y);
					candidate = pixellocinOutput.getLocInOutput(curneigh);
					candidate.x += cx;
					if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
							candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
							candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
							candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
					}

					for (nx in 1...neighborsX + 1)
						tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y), output.getPixelSeamless(x - nx, y));
					for (nx in (0-neighborsX)...neighborsX+1)
						for (ny in 1...neighborsY + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));

					if (tempd < bestd) {
						bestd = tempd;
						best.set(candidate.x, candidate.y);
					}

				}
				for (cx in (0-neighborsX)...neighborsX+1) {
					for (cy in 1...neighborsY + 1) {
						tempd = 0;
						curneigh.set(curloc.x - cx, curloc.y - cy);
						candidate = pixellocinOutput.getLocInOutput(curneigh);
						candidate.set(candidate.x + cx, candidate.y + cy);
						if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
							  candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
								candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
								candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
						}

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1)
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));

						if (tempd < bestd) {
							bestd = tempd;
							best.set(candidate.x, candidate.y);
						}

					}
				}
				output.setPixel(x, y, input.getPixel(best.x, best.y));
				candidate.set(best.x, best.y);
				pixellocinOutput.setLocInOutput(curloc, candidate);
			}
		}


		for (y in output.height - neighborsY...output.height) { trace('render line $y');
			curloc.y = y;
			for (x in 0...output.width) {

				curloc.x = x;
				bestd = 9007199254740992;

				for (cx in 1...neighborsX+1) {
					tempd = 0;
					curneigh.set(curloc.x - cx, curloc.y);
					candidate = pixellocinOutput.getLocInOutput(curneigh);
					candidate.x += cx;
					if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
							candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
							candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
							candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
					}

					for (nx in 1...neighborsX + 1)
						tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y), output.getPixelSeamless(x - nx, y));
					for (nx in (0-neighborsX)...neighborsX+1) {
						for (ny in 1...neighborsY + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));
						for (ny in output.height - y + 1...neighborsY + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y + ny), output.getPixelSeamless(x - nx, y + ny));
					}
					if (tempd < bestd) {
						bestd = tempd;
						best.set(candidate.x, candidate.y);
					}

				}
				for (cx in (0-neighborsX)...neighborsX+1) {
					for (cy in 1...neighborsY + 1) {
						tempd = 0;
						curneigh.set(curloc.x - cx, curloc.y - cy);
						candidate = pixellocinOutput.getLocInOutput(curneigh);
						candidate.set(candidate.x + cx, candidate.y + cy);
						if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
							  candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
								candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
								candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
						}

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1) {
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));
							for (ny in output.height - y + 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y + ny), output.getPixelSeamless(x - nx, y + ny));
						}
						if (tempd < bestd) {
							bestd = tempd;
							best.set(candidate.x, candidate.y);
						}

					}
					for (cy in output.height - y + 1...neighborsY + 1) {
						tempd = 0;
						curneigh.set(curloc.x - cx, curloc.y + cy);
						candidate = pixellocinOutput.getLocInOutput(curneigh);
						candidate.set(candidate.x + cx, candidate.y - cy);
						if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
							  candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
								candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
								candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
						}

						for (nx in 1...neighborsX + 1)
							tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y), output.getPixelSeamless(x - nx, y));
						for (nx in (0-neighborsX)...neighborsX+1) {
							for (ny in 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));
							for (ny in output.height - y + 1...neighborsY + 1)
								tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y + ny), output.getPixelSeamless(x - nx, y + ny));
						}

						if (tempd < bestd) {
							bestd = tempd;
							best.set(candidate.x, candidate.y);
						}

					}
				}
				output.setPixel(x, y, input.getPixel(best.x, best.y));
				candidate.set(best.x, best.y);
				pixellocinOutput.setLocInOutput(curloc, candidate);
			}
		}

		if (turbo == 0) {
			for (y in 0...output.height) { trace('render line $y');
				curloc.y = y;
				for (x in 0...output.width) {

					curloc.x = x;
					bestd = 9007199254740992;

					for (cx in (0-neighborsX)...neighborsX + 1) {
						for (cy in -neighborsY...neighborsY + 1) {
							tempd = 0;
							curneigh.set(curloc.x - cx, curloc.y - cy);
							candidate = pixellocinOutput.getLocInOutput(curneigh);
							candidate.set(candidate.x + cx, candidate.y + cy);
							if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
									candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
									candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
									candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
							}
							for (nx in -neighborsX...neighborsX + 1) {
								for (ny in -neighborsY...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y - ny), output.getPixelSeamless(x - nx, y - ny));
								for (ny in output.height - y + 1...neighborsY + 1)
									tempd += pixelMath.absErrorNorm2(input.getPixel(candidate.x - nx, candidate.y + ny), output.getPixelSeamless(x - nx, y + ny));
							}
							if (tempd < bestd) {
								bestd = tempd;
								best.set(candidate.x, candidate.y);
							}

						}
					}
					output.setPixel(x, y, input.getPixel(best.x, best.y));
					candidate.set(best.x, best.y);
					pixellocinOutput.setLocInOutput(curloc, candidate);
				}
			}
		}

	return output;
	}

}
