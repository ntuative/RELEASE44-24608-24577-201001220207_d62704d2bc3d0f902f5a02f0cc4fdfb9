package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1749:String;
      
      private var var_761:String;
      
      public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         var_1749 = param1;
         var_761 = param2;
      }
      
      public function get postureType() : String
      {
         return var_1749;
      }
      
      public function get parameter() : String
      {
         return var_761;
      }
   }
}
