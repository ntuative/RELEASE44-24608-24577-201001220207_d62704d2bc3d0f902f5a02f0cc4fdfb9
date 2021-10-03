package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public class BitmapDataCache
   {
       
      
      private var var_1571:int = 0;
      
      private var var_431:int = 0;
      
      private var var_247:Array;
      
      private var var_321:Map;
      
      public function BitmapDataCache(param1:uint)
      {
         super();
         var_321 = new Map();
         var_247 = [];
         var_1571 = param1;
      }
      
      public function addBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc4_:* = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:BitmapDataCacheItem = var_321.getValue(param1) as BitmapDataCacheItem;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.bitmapData;
            if(_loc4_ != null)
            {
               var_431 -= _loc4_.width * _loc4_.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new BitmapDataCacheItem(param2,param1);
            var_321.add(param1,_loc3_);
            var_247.push(_loc3_);
         }
         var_431 += param2.width * param2.height * 4;
      }
      
      public function compress() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(memUsage > memLimit)
         {
            var_247.sortOn("useCount",0 | 0);
            _loc2_ = -1;
            while(_loc2_ >= 0)
            {
               _loc1_ = var_247[_loc2_] as BitmapDataCacheItem;
               if(_loc1_.useCount != 0)
               {
                  _loc2_++;
               }
               removeItem(_loc1_);
               _loc2_--;
            }
            var_247.splice(_loc2_,0 - _loc2_);
            if(memUsage > memLimit)
            {
               var_247.sortOn("memUsage",Array.NUMERIC);
               while(memUsage > memLimit)
               {
                  _loc1_ = var_247.pop() as BitmapDataCacheItem;
                  if(_loc1_ == null)
                  {
                     break;
                  }
                  removeItem(_loc1_);
               }
            }
         }
         _loc2_ = 0;
         while(_loc2_ < var_247.length)
         {
            _loc1_ = var_247[_loc2_] as BitmapDataCacheItem;
            if(_loc1_ != null)
            {
               _loc1_.resetCount();
            }
            _loc2_++;
         }
      }
      
      public function get memUsage() : int
      {
         return var_431;
      }
      
      public function get memLimit() : int
      {
         return var_1571;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataCacheItem = var_321.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.bitmapData;
      }
      
      private function removeItem(param1:BitmapDataCacheItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1 = var_321.remove(param1.name) as BitmapDataCacheItem;
         if(param1 != null)
         {
            var_431 -= param1.memUsage;
            param1.dispose();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_321 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_321.length)
            {
               _loc2_ = var_321.getWithIndex(_loc1_) as BitmapDataCacheItem;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_321.dispose();
            var_321 = null;
         }
         var_247 = null;
      }
   }
}
