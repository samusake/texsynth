// Generated by Haxe 3.4.7
#ifndef INCLUDED_texsynth__Pixel_Pixel_Impl_
#define INCLUDED_texsynth__Pixel_Pixel_Impl_

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(texsynth,_Pixel,Pixel_Impl_)

namespace texsynth{
namespace _Pixel{


class HXCPP_CLASS_ATTRIBUTES Pixel_Impl__obj : public hx::Object
{
	public:
		typedef hx::Object super;
		typedef Pixel_Impl__obj OBJ_;
		Pixel_Impl__obj();

	public:
		enum { _hx_ClassId = 0x282e58aa };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="texsynth._Pixel.Pixel_Impl_")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return hx::Object::operator new(inSize+extra,false,"texsynth._Pixel.Pixel_Impl_"); }

		hx::ObjectPtr< Pixel_Impl__obj > __new() {
			hx::ObjectPtr< Pixel_Impl__obj > __this = new Pixel_Impl__obj();
			__this->__construct();
			return __this;
		}

		static hx::ObjectPtr< Pixel_Impl__obj > __alloc(hx::Ctx *_hx_ctx) {
			Pixel_Impl__obj *__this = (Pixel_Impl__obj*)(hx::Ctx::alloc(_hx_ctx, sizeof(Pixel_Impl__obj), false, "texsynth._Pixel.Pixel_Impl_"));
			*(void **)__this = Pixel_Impl__obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~Pixel_Impl__obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_HCSTRING("Pixel_Impl_","\x86","\x43","\xb4","\x6d"); }

		static int fromUInt(int p);
		static ::Dynamic fromUInt_dyn();

		static int toUInt(int this1);
		static ::Dynamic toUInt_dyn();

};

} // end namespace texsynth
} // end namespace _Pixel

#endif /* INCLUDED_texsynth__Pixel_Pixel_Impl_ */ 