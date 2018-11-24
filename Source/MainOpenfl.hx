package;

import lime.system.BackgroundWorker;
//import lime.system.ThreadPool;

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
import texsynth.UserControlledSynthesis;
import texsynth.ImageTransition;
import texsynth.PixelType;
import texsynth.PixelData;

class MainOpenfl extends Sprite {

	public function new () {
		super();

		//var worker = new ThreadPool(0, 4);

		var worker = new BackgroundWorker();
		worker.doWork.add( function(value:Dynamic) {

			var input1:BitmapData = Assets.getBitmapData ("assets/flowers.png");
			addImage(input1, 10, 10);
			var input2:BitmapData = Assets.getBitmapData ("assets/texsynthimage.png");
			addImage(input2, 10, 10);
			var output = ImageTransition.render(PixelType.RGB, input1, input2, 20, 2, 2, false, 1, true);
			addImage(output, 100, 10);
			saveBitmapData(output,"finaloutput.png");
/*
			var input:BitmapData = Assets.getBitmapData ("assets/flowers.png");
			addImage(input, 10, 10);
			var output:BitmapData = Assets.getBitmapData ("assets/flowerinput.png");
			//var output = new PixelData(128, 128);
			output = UserControlledSynthesis.render(PixelType.RGBA, input, output , 1, 2);
			addImage(output, 100, 10);
			saveBitmapData(output,"finaloutput.png");

			output = FullSynthesisSimple.render(PixelType.RGB, input, output);
			addImage(output, 250, 10);

			output = FullSynthesis.render(PixelType.RGB, input, output);
			addImage(output, 400, 10);
			*/
		});
		//worker.queue();
		worker.run();

		// ----------------------------------------------------------------------
		var worker = new BackgroundWorker();
		worker.doWork.add( function(value:Dynamic) {

			var input:BitmapData = Assets.getBitmapData ("assets/texsynthimage.png");
			addImage(input, 10, 150);
			var output = new PixelData(128, 128);

			output = CoherentSynthesis.render(PixelType.RGB, input, output , 1, 1);
			addImage(output, 100, 150);
			/*
			output = FullSynthesisSimple.render(PixelType.RGB, input, output);
			addImage(output, 250, 150);

			output = FullSynthesis.render(PixelType.RGB, input, output);
			addImage(output, 400, 150);
			*/
		});
		//worker.queue();
		worker.run();

		// ----------------------------------------------------------------------
		var worker = new BackgroundWorker();
		worker.doWork.add( function(value:Dynamic) {

			var input:BitmapData = Assets.getBitmapData ("assets/stones.png");
			addImage(input, 10, 300);
			var output = new PixelData(128, 128);

			output = CoherentSynthesis.render(PixelType.RGB, input, output , 3, 3);
			addImage(output, 100, 300);
			/*
			output = FullSynthesisSimple.render(PixelType.RGB, input, output);
			addImage(output, 250, 300);

			output = FullSynthesis.render(PixelType.RGB, input, output);
			addImage(output, 400, 300);
			*/
		});
		//worker.queue();
		worker.run();


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
