package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarWaveUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_2163:Boolean = false;
      
      public function RoomObjectAvatarWaveUpdateMessage(param1:Boolean = false)
      {
         super();
         var_2163 = param1;
      }
      
      public function get isWaving() : Boolean
      {
         return var_2163;
      }
   }
}
