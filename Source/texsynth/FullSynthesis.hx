package texsynth;

class FullSynthesis{
	
	public static function render(input:PixelData<ARGB>, width:Int, height:Int):PixelData<ARGB> {
		
		var output = new PixelData<ARGB>(width, height);
		
		output.randomize();
		
		var ncolorout:Array<ARGB>;
		var ncolorin:Array<ARGB>;
		
		var bestx:Int = 0;
		var besty:Int = 0;
		
		var bestd:Float;
		var tempd:Float;
		
		for (i in 0...output.height) {
			trace("y= " +i);
			for (j in 0...output.width) {
				ncolorout = [];
				ncolorout.push(output.getPixelSeamless(j-1,i));
				ncolorout.push(output.getPixelSeamless(j-1,i-1));
				ncolorout.push(output.getPixelSeamless(j,i-1));
				ncolorout.push(output.getPixelSeamless(j+1,i-1));
				bestd = 195075;
				for (ki in 0...input.height) {		
					for (kj in 0...input.width) {	
						ncolorin = [];
						ncolorin.push(input.getPixelSeamless(kj-1,ki));
						ncolorin.push(input.getPixelSeamless(kj-1,ki-1));
						ncolorin.push(input.getPixelSeamless(kj,ki-1));
						ncolorin.push(input.getPixelSeamless(kj+1,ki-1));
						tempd = compare(ncolorout, ncolorin);
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
		
		return output;
	}
	
	static inline function compare(ncout:Array<ARGB>, ncin:Array<ARGB>):Float {
		var d:Float=0;
		for (i in 0...ncout.length)
			d += ncin[i].absErrorNorm2( ncout[i] );
			
		return(d);
	}
	
	
	
}
