package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1160:int = 0;
      
      public function RoomObjectAvatarGestureUpdateMessage(param1:int)
      {
         super();
         var_1160 = param1;
      }
      
      public function get gesture() : int
      {
         return var_1160;
      }
   }
}
