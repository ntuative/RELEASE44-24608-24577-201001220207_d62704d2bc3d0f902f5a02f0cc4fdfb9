package com.sulake.room.renderer.cache
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectLocationCacheItem
   {
       
      
      private var var_1593:int = -1;
      
      private var var_1112:int = -1;
      
      private var var_608:Vector3d = null;
      
      public function RoomObjectLocationCacheItem()
      {
         super();
         var_608 = new Vector3d();
      }
      
      public function get objectUpdateId() : int
      {
         return var_1593;
      }
      
      public function set objectUpdateId(param1:int) : void
      {
         var_1593 = param1;
      }
      
      public function set screenLoc(param1:IVector3d) : void
      {
         var_608.assign(param1);
         var_608.x = Math.round(var_608.x);
         var_608.y = Math.round(var_608.y);
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         var_1112 = param1;
      }
      
      public function get screenLoc() : IVector3d
      {
         return var_608;
      }
      
      public function get geometryUpdateId() : int
      {
         return var_1112;
      }
   }
}
