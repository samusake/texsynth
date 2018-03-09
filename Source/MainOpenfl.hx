package; 

import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

#if (!(html5 || flash))
import sys.io.File;
import sys.io.FileOutput;
import openfl.utils.ByteArray;
import openfl.display.PNGEncoderOptions;
#end

import texsynth.FullSynthesis;
import texsynth.ARGB;
import texsynth.RGB;


class MainOpenfl extends Sprite {
	
	public function new () {
		super();
		
		//var input:BitmapData = Assets.getBitmapData ("assets/texsynthimage.png");
		var input:BitmapData = Assets.getBitmapData ("assets/stones.png");
		//var input:BitmapData = Assets.getBitmapData ("assets/fractal.png");

		var isprite = new Sprite();
		isprite.addChild (new Bitmap (input));
		isprite.x = 10;
		isprite.y = 10;
		this.addChild (isprite);
		
		
		//var output:BitmapData = RGB.newRandomPixelData(144, 144);
		var output:BitmapData = FullSynthesis.render(input, RGB.newRandomPixelData(144, 144) , 2, 3);
		//var output:BitmapData = FullSynthesis.render(input, RGB.newRandomPixelData(144, 144) , 2, 3, true);
		
		var osprite = new Sprite();
		osprite.addChild (new Bitmap (output));
		osprite.x = 100;
		osprite.y = 10;
		this.addChild (osprite);		

		#if (!(html5 || flash))
		// saves file
		// (todo: trying out openfl filedialog)
		var b:ByteArrayData = output.encode(output.rect, new PNGEncoderOptions ());
		var fo:FileOutput = sys.io.File.write("finaloutput.png", true);
		fo.writeString(b.toString());
		fo.close();   
	   	#end
		
	}
	
}
