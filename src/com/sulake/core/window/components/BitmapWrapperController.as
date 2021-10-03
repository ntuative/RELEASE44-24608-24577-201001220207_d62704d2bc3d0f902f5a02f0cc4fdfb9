package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.graphics.WindowRedrawFlag;
   import com.sulake.core.window.utils.IBitmapDataContainer;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class BitmapWrapperController extends WindowController implements IBitmapWrapperWindow, IBitmapDataContainer
   {
      
      protected static const const_1371:String = null;
      
      protected static const const_1007:String = "handle_bitmap_disposing";
      
      protected static const const_1372:Boolean = true;
      
      protected static const const_1008:String = "bitmap_asset_name";
       
      
      protected var var_424:Boolean = true;
      
      protected var _bitmapData:BitmapData;
      
      protected var var_1060:String;
      
      public function BitmapWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get disposesBitmap() : Boolean
      {
         return var_424;
      }
      
      public function set disposesBitmap(param1:Boolean) : void
      {
         var_424 = param1;
      }
      
      override public function clone() : IWindow
      {
         var _loc1_:BitmapWrapperController = super.clone() as BitmapWrapperController;
         _loc1_._bitmapData = _bitmapData;
         _loc1_.var_424 = var_424;
         _loc1_.var_1060 = var_1060;
         return _loc1_;
      }
      
      public function set bitmap(param1:BitmapData) : void
      {
         if(var_424 && _bitmapData && param1 != _bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = param1;
         var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case const_1007:
                  var_424 = _loc2_.value as Boolean;
                  break;
               case const_1008:
                  var_1060 = _loc2_.value as String;
                  break;
            }
         }
         super.properties = param1;
      }
      
      override public function dispose() : void
      {
         if(_bitmapData)
         {
            if(var_424)
            {
               _bitmapData.dispose();
            }
            _bitmapData = null;
         }
         super.dispose();
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmapData;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         bitmap = param1;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(new PropertyStruct(const_1007,var_424,PropertyStruct.const_56,var_424 != const_1372));
         _loc1_.push(new PropertyStruct(const_1008,var_1060,PropertyStruct.STRING,var_1060 != const_1371));
         return _loc1_;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
   }
}
