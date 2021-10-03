package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
   
   public class FlatInfoMessageParser implements IMessageParser
   {
       
      
      private var var_231:RoomSettingsFlatInfo;
      
      public function FlatInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_231 = null;
         return true;
      }
      
      public function get flatInfo() : RoomSettingsFlatInfo
      {
         return var_231;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_231 = new RoomSettingsFlatInfo();
         var_231.allowFurniMoving = param1.readInteger() == 1;
         var_231.doorMode = param1.readInteger();
         var_231.id = param1.readInteger();
         var_231.ownerName = param1.readString();
         var_231.type = param1.readString();
         var_231.name = param1.readString();
         var_231.description = param1.readString();
         var_231.showOwnerName = param1.readInteger() == 1;
         var_231.allowTrading = param1.readInteger() == 1;
         var_231.categoryAlertKey = param1.readInteger() == 1;
         return true;
      }
   }
}
