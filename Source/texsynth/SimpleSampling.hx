package texsynth;

class SimpleSampling {
	
	public static function render(input:PixelData<ARGB>, width:Int, height:Int):PixelData<ARGB> {
		
		var output = new PixelData<ARGB>(width, height);
		
		output.randomize();
		
		var ncolorout:Array<ARGB>;
		var ncolorin:Array<ARGB>;
		
		var bestx:Int = 0;
		var besty:Int = 0;
		
		var bestd:Float;
		var tempd:Float;
		
		var startseed:Array<Int> = [];
		
		for (j in 0...output.width+2) {
			startseed.push(cast(Math.random()*0xffffff));
		}
		for (j in 0...output.width) {
			ncolorout = [];
			ncolorout.push(output.getPixel(j-1,0));
			ncolorout.push(startseed[j]);
			ncolorout.push(startseed[j+1]);
			ncolorout.push(startseed[j+2]);
			bestd = 195075;
			for (ki in 0...input.height) {		
				for (kj in 0...input.width) {	
					ncolorin = [];
					ncolorin.push(input.getPixel(kj-1,ki));
					ncolorin.push(input.getPixel(kj-1,ki-1));
					ncolorin.push(input.getPixel(kj,ki-1));
					ncolorin.push(input.getPixel(kj+1,ki-1));
					tempd = compare(ncolorout, ncolorin);
					if (tempd < bestd) {
						bestd = tempd;
						bestx = kj;
						besty = ki;	
					}
				}
			}
			output.setPixel(j, 0, input.getPixel(bestx, besty));
		}


		for (i in 1...output.height) {
			trace("y= " +i);
			for (j in 0...output.width) {
				ncolorout = [];
				ncolorout.push(output.getPixel(j-1,i));
				ncolorout.push(output.getPixel(j-1,i-1));
				ncolorout.push(output.getPixel(j,i-1));
				ncolorout.push(output.getPixel(j+1,i-1));
				bestd = 195075;
				for (ki in 0...input.height) {		
					for (kj in 0...input.width) {	
						ncolorin = [];
						ncolorin.push(input.getPixel(kj-1,ki));
						ncolorin.push(input.getPixel(kj-1,ki-1));
						ncolorin.push(input.getPixel(kj,ki-1));
						ncolorin.push(input.getPixel(kj+1,ki-1));
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
			d += ncin[i].sample( ncout[i] );
			
		return(d);
	}
	
	
	
}
