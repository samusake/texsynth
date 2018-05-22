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

import texsynth.CoherentSynthesis;
import texsynth.FullSynthesis;
import texsynth.FullSynthesisSimple;
import texsynth.PixelType;
import texsynth.PixelData;
import texsynth.PixelLocationMap;

class MainOpenfl extends Sprite {

	public function new () {
		super();

		var input:BitmapData = Assets.getBitmapData ("assets/flowers.png");
		addImage(input, 10, 10);

		var output = new PixelData(128,128);

		output = CoherentSynthesis.render(PixelType.RGB, input, output , 3, 3);
		addImage(output, 100, 10);

		//output = FullSynthesisSimple.render(PixelType.RGB, input, output);
		//addImage(output, 250, 10);

		//output = FullSynthesis.render(PixelType.RGB, input, output);
		//addImage(output, 400, 10);

		// ----------------------------------------------------------------------

		var input:BitmapData = Assets.getBitmapData ("assets/texsynthimage.png");
		addImage(input, 10, 150);

		var output = new PixelData(128,128);

		output = CoherentSynthesis.render(PixelType.RGB, input, output , 3, 3);
		addImage(output, 100, 150);

		//output = FullSynthesisSimple.render(PixelType.RGB, input, output);
		//addImage(output, 250, 150);

		//output = FullSynthesis.render(PixelType.RGB, input, output);
		//addImage(output, 400, 150);

		// ----------------------------------------------------------------------

		var input:BitmapData = Assets.getBitmapData ("assets/stones.png");
		addImage(input, 10, 300);

		var output = new PixelData(128,128);

		output = CoherentSynthesis.render(PixelType.RGB, input, output , 3, 3);
		addImage(output, 100, 300);

		//output = FullSynthesisSimple.render(PixelType.RGB, input, output);
		//addImage(output, 250, 300);

		//output = FullSynthesis.render(PixelType.RGB, input, output);
		//addImage(output, 400, 300);



		//saveBitmapData(output,"finaloutput.png");
	}

	public function addImage(bitmapData:BitmapData, x:Int, y:Int) {
		var sprite = new Sprite();
		sprite.addChild (new Bitmap (bitmapData));
		sprite.x = x;
		sprite.y = y;
		addChild(sprite);
	}

	public function saveBitmapData(bitmapData:BitmapData, fileName:String) {
		#if (!(html5 || flash))
		// saves file
		// (todo: trying out openfl filedialog)
		var b:ByteArrayData = bitmapData.encode(bitmapData.rect, new PNGEncoderOptions ());
		var fo:FileOutput = File.write(fileName, true);
		fo.writeString(b.toString());
		fo.close();
	   	#end
	}
}
