package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   import flash.display.BitmapData;
   
   public class BitmapDataCacheItem
   {
       
      
      private var var_479:int = 0;
      
      private var _name:String = "";
      
      private var _bitmapData:BitmapData = null;
      
      public function BitmapDataCacheItem(param1:BitmapData, param2:String)
      {
         super();
         _bitmapData = param1;
         _name = param2;
         var _loc3_:ExtendedBitmapData = _bitmapData as ExtendedBitmapData;
         if(_loc3_ != null)
         {
            _loc3_.addReference();
         }
         var_479 = 1;
      }
      
      public function resetCount() : void
      {
         var_479 = 0;
      }
      
      public function get useCount() : int
      {
         return var_479;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get memUsage() : int
      {
         if(_bitmapData == null)
         {
            return 0;
         }
         return 0 * 0 * 4;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         var _loc2_:ExtendedBitmapData = _bitmapData as ExtendedBitmapData;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         _bitmapData = param1;
         var_479 = 1;
         _loc2_ = _bitmapData as ExtendedBitmapData;
         if(_loc2_ != null)
         {
            _loc2_.addReference();
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         ++var_479;
         return _bitmapData;
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
   }
}
