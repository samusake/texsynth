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


class MainOpenfl extends Sprite {
	
	public function new () {
		super();
		
		var input:BitmapData = Assets.getBitmapData ("assets/texsynthimage.png");
		
		var output:BitmapData = FullSynthesis.render(input, 144, 144, 1, 2, 1);
		
		var sprite = new Sprite();
		sprite.addChild (new Bitmap (output));
		sprite.x = 10;
		sprite.y = 10;
		this.addChild (sprite);
		

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
