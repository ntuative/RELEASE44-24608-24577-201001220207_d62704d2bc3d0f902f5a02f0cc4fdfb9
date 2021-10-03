package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_982:int;
      
      private var var_1186:String;
      
      public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
      {
         super();
         var_982 = param1;
         var_1186 = param2;
      }
      
      public function get itemType() : int
      {
         return var_982;
      }
      
      public function get itemName() : String
      {
         return var_1186;
      }
   }
}
