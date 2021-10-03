package com.sulake.core.window
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.utils.IRectLimiter;
   import com.sulake.core.window.utils.WindowRectLimits;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowModel implements IDisposable
   {
       
      
      protected var _disposed:Boolean = false;
      
      protected var var_364:Rectangle;
      
      protected var var_31:uint;
      
      protected var var_152:Rectangle;
      
      protected var _type:uint;
      
      protected var var_1067:Boolean = true;
      
      protected var var_151:Rectangle;
      
      protected var var_601:uint = 16777215;
      
      protected var var_46:uint;
      
      protected var var_89:uint;
      
      protected var var_353:Boolean = true;
      
      protected var var_318:String = "";
      
      protected var var_83:WindowRectLimits;
      
      protected var var_1331:uint;
      
      protected var var_5:Boolean = false;
      
      protected var var_410:Number = 1;
      
      protected var var_64:Rectangle;
      
      protected var _id:uint;
      
      protected var _name:String;
      
      protected var var_22:Rectangle;
      
      protected var var_29:WindowContext;
      
      protected var var_602:Array;
      
      public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array = null)
      {
         super();
         _id = param1;
         _name = param2;
         _type = param3;
         var_31 = param5;
         var_46 = WindowState.const_81;
         var_89 = param4;
         var_602 = param8 == null ? new Array() : param8;
         var_29 = param6;
         var_22 = param7.clone();
         var_364 = param7.clone();
         var_64 = param7.clone();
         var_151 = new Rectangle();
         var_152 = null;
         var_83 = new WindowRectLimits(this as IWindow);
      }
      
      public function getMinHeight() : int
      {
         return var_83.minHeight;
      }
      
      public function testTypeFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_type & param2 ^ param1) == 0;
         }
         return (_type & param1) == param1;
      }
      
      public function getMinWidth() : int
      {
         return var_83.minWidth;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get param() : uint
      {
         return var_31;
      }
      
      public function get state() : uint
      {
         return var_46;
      }
      
      public function getMaximizedWidth() : int
      {
         return var_152.width;
      }
      
      public function getMinimizedHeight() : int
      {
         return var_151.height;
      }
      
      public function get limits() : IRectLimiter
      {
         return var_83;
      }
      
      public function get tags() : Array
      {
         return var_602;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function testStateFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_46 & param2 ^ param1) == 0;
         }
         return (var_46 & param1) == param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_22 = null;
            var_46 = WindowState.const_349;
            _disposed = true;
            var_602 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get height() : int
      {
         return var_22.height;
      }
      
      public function get position() : Point
      {
         return var_22.topLeft;
      }
      
      public function get background() : Boolean
      {
         return var_5;
      }
      
      public function get context() : IWindowContext
      {
         return var_29;
      }
      
      public function getMaximizedHeight() : int
      {
         return var_152.height;
      }
      
      public function get style() : uint
      {
         return var_89;
      }
      
      public function getMaxWidth() : int
      {
         return var_83.maxWidth;
      }
      
      public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      public function testStyleFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_89 & param2 ^ param1) == 0;
         }
         return (var_89 & param1) == param1;
      }
      
      public function testParamFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_31 & param2 ^ param1) == 0;
         }
         return (var_31 & param1) == param1;
      }
      
      public function hasMaxHeight() : Boolean
      {
         return false;
      }
      
      public function get type() : uint
      {
         return _type;
      }
      
      public function get clipping() : Boolean
      {
         return var_1067;
      }
      
      public function setMinWidth(param1:int) : int
      {
         var _loc2_:int = 0;
         var_83.minWidth = param1;
         return _loc2_;
      }
      
      public function get width() : int
      {
         return var_22.width;
      }
      
      public function hasMinHeight() : Boolean
      {
         return false;
      }
      
      public function get blend() : Number
      {
         return var_410;
      }
      
      public function getInitialHeight() : int
      {
         return var_364.height;
      }
      
      public function getMinimizedWidth() : int
      {
         return var_151.width;
      }
      
      public function setMinHeight(param1:int) : int
      {
         var _loc2_:int = 0;
         var_83.minHeight = param1;
         return _loc2_;
      }
      
      public function getInitialWidth() : int
      {
         return var_364.width;
      }
      
      public function getPreviousWidth() : int
      {
         return var_64.width;
      }
      
      public function hasMinWidth() : Boolean
      {
         return false;
      }
      
      public function get color() : uint
      {
         return var_601;
      }
      
      public function get caption() : String
      {
         return var_318;
      }
      
      public function setMaxHeight(param1:int) : int
      {
         var _loc2_:int = 0;
         var_83.maxHeight = param1;
         return _loc2_;
      }
      
      public function get rectangle() : Rectangle
      {
         return var_22;
      }
      
      public function setMaxWidth(param1:int) : int
      {
         var _loc2_:int = 0;
         var_83.maxWidth = param1;
         return _loc2_;
      }
      
      public function get visible() : Boolean
      {
         return var_353;
      }
      
      public function getMaxHeight() : int
      {
         return var_83.maxHeight;
      }
      
      public function get x() : int
      {
         return var_22.x;
      }
      
      public function get y() : int
      {
         return var_22.y;
      }
      
      public function getPreviousHeight() : int
      {
         return var_64.height;
      }
      
      public function hasMaxWidth() : Boolean
      {
         return false;
      }
   }
}
