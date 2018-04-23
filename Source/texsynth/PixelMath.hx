package texsynth;

class PixelMath {
	public var norm2Max:Int;
    public var absErrorNorm2:Pixel->Pixel->Float;

    public function new(pixelType:PixelType) {
        switch (pixelType) {
            case PixelType.RGB:
                norm2Max = 255*255*3;
                absErrorNorm2 = absErrorNorm2_RGB;
            case PixelType.RGBA:
                norm2Max = 255*255*4;
                absErrorNorm2 = absErrorNorm2_ARGB;
       }
    }

	public inline function absErrorNorm2_RGB(p1:Pixel, p2:Pixel):Float {
		return (p2.r - p1.r) * (p2.r - p1.r) +
		       (p2.g - p1.g) * (p2.g - p1.g) +
		       (p2.b - p1.b) * (p2.b - p1.b);
	}
    
	public inline function absErrorNorm2_ARGB(p1:Pixel, p2:Pixel):Float {
		return (p2.a - p1.a) * (p2.a - p1.a) +
		       (p2.r - p1.r) * (p2.r - p1.r) +
		       (p2.g - p1.g) * (p2.g - p1.g) +
		       (p2.b - p1.b) * (p2.b - p1.b);
	}
}