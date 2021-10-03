package com.sulake.habbo.widget.messages
{
   public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage
   {
      
      public static const const_351:String = "RWSUM_STICKIE_SEND_UPDATE";
      
      public static const const_545:String = "RWSUM_STICKIE_SEND_DELETE";
       
      
      private var var_661:String;
      
      private var var_160:int;
      
      private var var_198:String;
      
      public function RoomWidgetStickieSendUpdateMessage(param1:String, param2:int, param3:String = "", param4:String = "")
      {
         super(param1);
         var_160 = param2;
         var_198 = param3;
         var_661 = param4;
      }
      
      public function get objectId() : int
      {
         return var_160;
      }
      
      public function get text() : String
      {
         return var_198;
      }
      
      public function get colorHex() : String
      {
         return var_661;
      }
   }
}
