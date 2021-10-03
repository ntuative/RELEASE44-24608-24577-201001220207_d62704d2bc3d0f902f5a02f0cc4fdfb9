package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1978:String;
      
      private var var_558:String;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         var_558 = param1;
         var_1978 = param2;
      }
      
      public function get race() : String
      {
         return var_1978;
      }
      
      public function get figure() : String
      {
         return var_558;
      }
   }
}
