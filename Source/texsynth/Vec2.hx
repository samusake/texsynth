package texsynth;

/**
 * 2 dimensional vector
 */

@:generic
class Vec2<T>
{

	public var x:T;
	public var y:T;
	
	public inline function new(x:T, y:T)
	{
		set(x, y);
	}
	
	public inline function set(x:T, y:T):Void {
		this.x = x;
		this.y = y;
	}
	
	public inline function copy():Vec2<T> {
		return new Vec2<T>(x , y);
	}
	
}