package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1923:int;
      
      public function RoomObjectAvatarChatUpdateMessage(param1:int)
      {
         super();
         var_1923 = param1;
      }
      
      public function get numberOfWords() : int
      {
         return var_1923;
      }
   }
}
