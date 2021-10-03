package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChatMessage extends RoomWidgetMessage
   {
      
      public static const const_121:int = 0;
      
      public static const const_122:int = 1;
      
      public static const const_100:int = 2;
      
      public static const const_531:String = "RWCM_MESSAGE_CHAT";
       
      
      private var var_1214:int = 0;
      
      private var var_2126:String = "";
      
      private var var_198:String = "";
      
      public function RoomWidgetChatMessage(param1:String, param2:String, param3:int = 0, param4:String = "")
      {
         super(param1);
         var_198 = param2;
         var_1214 = param3;
         var_2126 = param4;
      }
      
      public function get recipientName() : String
      {
         return var_2126;
      }
      
      public function get chatType() : int
      {
         return var_1214;
      }
      
      public function get text() : String
      {
         return var_198;
      }
   }
}
