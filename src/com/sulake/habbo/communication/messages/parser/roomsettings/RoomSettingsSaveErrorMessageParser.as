package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomSettingsSaveErrorMessageParser implements IMessageParser
   {
      
      public static const const_1442:int = 9;
      
      public static const const_1467:int = 4;
      
      public static const const_1437:int = 1;
      
      public static const const_1189:int = 10;
      
      public static const const_1549:int = 2;
      
      public static const const_1159:int = 7;
      
      public static const const_1176:int = 11;
      
      public static const const_1501:int = 3;
      
      public static const const_1274:int = 8;
      
      public static const const_1124:int = 5;
      
      public static const const_1470:int = 6;
      
      public static const const_1324:int = 12;
       
      
      private var var_1929:String;
      
      private var _roomId:int;
      
      private var var_1128:int;
      
      public function RoomSettingsSaveErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get info() : String
      {
         return var_1929;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         var_1128 = param1.readInteger();
         var_1929 = param1.readString();
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_1128;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
