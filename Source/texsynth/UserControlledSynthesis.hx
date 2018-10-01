package texsynth;

class UserControlledSynthesis {

	public static function render(pixelType:PixelType, input:PixelData, output:PixelData,
	                              neighborsX:Int = 2, neighborsY:Int = 2,  neighborsOutside:Bool = false,
								  							passes:Int = 1):PixelData {

		var pixelMath = new PixelMath(pixelType);


    //output.randomizeAlpha(); // TODO: FIX THIS FUNCTION

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
    for (pass in 0...passes) {
		// for every pixel in output image
  		for (y in 0...output.height) {
  			trace('render line $y'); // TODO: onProgress callback here (for worker)
  			curloc.y = y;
  			for (x in 0...output.width) {
  				curloc.x = x;
  				bestd = 9007199254740992;

  				for (cx in (0-neighborsX)...neighborsX+1) {
  					for (cy in (0-neighborsY)...neighborsY + 1) {
  						tempd = 0;
  						curneigh.set(curloc.x - cx, curloc.y - cy);
  						candidate = pixellocinOutput.getLocInOutput(curneigh);
  						candidate.set(candidate.x + cx, candidate.y + cy);
  						if (candidate.x > input.width - neighborsX  || candidate.x < neighborsX ||
  							  candidate.y > input.height - neighborsY || candidate.y < neighborsY) {
  								candidate.x = Std.random(input.width - 2 * neighborsX) + neighborsX;
  								candidate.y = Std.random(input.height - 2 * neighborsY) + neighborsY;
  						}

  						for (nx in (0-neighborsX)...neighborsX+1)
  							for (ny in (0-neighborsX)...neighborsY + 1)
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
    }
	return output;
	}

}
