package texsynth;

class FullSynthesis{
	
	public static function render(input:PixelData<ARGB>, width:Int, height:Int, neighborhood_x:Int=2, neighborhood_y:Int=2, passes:Int=1):PixelData<ARGB> {
		
		var output = new PixelData<ARGB>(width, height);
		
		output.randomize();
		
		var bestx:Int = 0;
		var besty:Int = 0;
		
		var bestd:Float;
		var tempd:Float;
		
		for (p in 0...passes) {
			for (i in 0...output.height) {
				trace("y= " + i);
				for (j in 0...output.width) {
					bestd = 195075;
					for (ki in neighborhood_y...input.height) {		
						for (kj in neighborhood_x...input.width-neighborhood_x) {	
							tempd = 0;
							for (nx in 1...neighborhood_x+1) {
								tempd += input.getPixelSeamless(kj-nx, ki).absErrorNorm2(output.getPixelSeamless(j-nx, i));
							}
							for (nx in (0-neighborhood_x)...neighborhood_x+1) {
								for(ny in 1...neighborhood_y+1) {
									tempd += input.getPixelSeamless(kj-nx, ki-ny).absErrorNorm2(output.getPixelSeamless(j-nx, i-ny));
								}
							}
							if (tempd < bestd) {
								bestd = tempd;
								bestx = kj;
								besty = ki;	
							}
						}
					}
					output.setPixel(j, i, input.getPixel(bestx, besty));
				}
			}
		}
		
		return output;
	}
	
}
