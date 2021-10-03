package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1160:String;
      
      public function RoomObjectAvatarPetGestureUpdateMessage(param1:String)
      {
         super();
         var_1160 = param1;
      }
      
      public function get gesture() : String
      {
         return var_1160;
      }
   }
}
