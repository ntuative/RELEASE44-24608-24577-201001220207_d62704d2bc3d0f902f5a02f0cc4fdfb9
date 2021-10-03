package com.sulake.habbo.communication.messages.incoming.navigator
{
   public class RoomThumbnailObjectData
   {
       
      
      private var var_1444:int;
      
      private var var_1445:int;
      
      public function RoomThumbnailObjectData()
      {
         super();
      }
      
      public function get pos() : int
      {
         return var_1444;
      }
      
      public function set pos(param1:int) : void
      {
         this.var_1444 = param1;
      }
      
      public function getCopy() : RoomThumbnailObjectData
      {
         var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc1_.var_1444 = this.var_1444;
         _loc1_.var_1445 = this.var_1445;
         return _loc1_;
      }
      
      public function set imgId(param1:int) : void
      {
         this.var_1445 = param1;
      }
      
      public function get imgId() : int
      {
         return var_1445;
      }
   }
}
