package; 

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.PNGEncoderOptions;


import openfl.Assets;
import openfl.utils.ByteArray;
import sys.io.File;
import sys.io.FileOutput;


class Main extends Sprite{
	public function new () {
		super();
		var input = Assets.getBitmapData ("assets/texsynthimage.png");
		var output = Assets.getBitmapData ("assets/output.png");
		var ncolorout:Array<Int>;
		var ncolorin:Array<Int>;
		var bestx:Int=0;
		var besty:Int=0;
		var bestd:Float;
		var tempd:Float;
		
		var startseed:Array<Int>=[];
		for(j in 0...output.width+2){
			startseed.push(cast(Math.random()*0xffffff));
		}
		for(j in 0...output.width){
			ncolorout=[];
			ncolorout.push(output.getPixel(j-1,0));
			ncolorout.push(startseed[j]);
			ncolorout.push(startseed[j+1]);
			ncolorout.push(startseed[j+2]);
			bestd=195075;
			for(ki in 0...input.height){		
				for(kj in 0...input.width){	
					ncolorin=[];
					ncolorin.push(input.getPixel(kj-1,ki));
					ncolorin.push(input.getPixel(kj-1,ki-1));
					ncolorin.push(input.getPixel(kj,ki-1));
					ncolorin.push(input.getPixel(kj+1,ki-1));
					tempd=compare(ncolorout, ncolorin);
					if(tempd<bestd){
						bestd=tempd;
						bestx=kj;
							besty=ki;	
					}
				}
			}
			output.setPixel(j, 0, input.getPixel(bestx, besty));
		}


		for(i in 1...output.height){
			trace("y= " +i);
			for(j in 0...output.width){
				ncolorout=[];
				ncolorout.push(output.getPixel(j-1,i));
				ncolorout.push(output.getPixel(j-1,i-1));
				ncolorout.push(output.getPixel(j,i-1));
				ncolorout.push(output.getPixel(j+1,i-1));
				bestd=195075;
				for(ki in 0...input.height){		
					for(kj in 0...input.width){	
						ncolorin=[];
						ncolorin.push(input.getPixel(kj-1,ki));
						ncolorin.push(input.getPixel(kj-1,ki-1));
						ncolorin.push(input.getPixel(kj,ki-1));
						ncolorin.push(input.getPixel(kj+1,ki-1));
						tempd=compare(ncolorout, ncolorin);
						if(tempd<bestd){
							bestd=tempd;
							bestx=kj;
							besty=ki;	
						}
					}
				}
				output.setPixel(j, i, input.getPixel(bestx, besty));
			}
		}
		var b:ByteArrayData = output.encode(output.rect, new PNGEncoderOptions ());
		var fo:FileOutput = sys.io.File.write("finaloutput.png", true);
		fo.writeString(b.toString());
		fo.close();   
	   	
		var bitmap = new Bitmap (output);
		addChild (bitmap);

		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
	}
	public function compare(ncout:Array<Int>, ncin:Array<Int>):Float{
		var d:Float=0;
		for(i in 0...ncout.length){
			var ro:Int =  cast((Math.pow(256,3) + ncout[i]) / 65536);
			var go:Int =  cast(((Math.pow(256,3) + ncout[i]) / 256 ) % 256 );
			var bo:Int =  cast((Math.pow(256,3) + ncout[i]) % 256);
			var ri:Int =  cast((Math.pow(256,3) + ncin[i]) / 65536);
			var gi:Int =  cast(((Math.pow(256,3) + ncin[i]) / 256 ) % 256 );
			var bi:Int =  cast((Math.pow(256,3) + ncin[i]) % 256);

			d=d+(ro-ri)*(ro-ri)+(go-gi)*(go-gi)+(bo-bi)*(bo-bi);
		}
		return(d);
	}
	
	
	
}
