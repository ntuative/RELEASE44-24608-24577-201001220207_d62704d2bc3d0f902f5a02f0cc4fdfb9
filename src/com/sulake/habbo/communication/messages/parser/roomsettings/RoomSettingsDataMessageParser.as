package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
   
   public class RoomSettingsDataMessageParser implements IMessageParser
   {
       
      
      private var var_144:RoomSettingsData;
      
      public function RoomSettingsDataMessageParser()
      {
         super();
      }
      
      public function get data() : RoomSettingsData
      {
         return var_144;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_144 = new RoomSettingsData();
         var_144.roomId = param1.readInteger();
         var_144.name = param1.readString();
         var_144.description = param1.readString();
         var_144.doorMode = param1.readInteger();
         var_144.categoryId = param1.readInteger();
         var_144.maximumVisitors = param1.readInteger();
         var_144.maximumVisitorsLimit = param1.readInteger();
         var_144.tags = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_144.tags.push(param1.readString());
            _loc3_++;
         }
         var_144.controllers = [];
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            var_144.controllers.push(new FlatControllerData(param1));
            _loc5_++;
         }
         var_144.controllerCount = param1.readInteger();
         var_144.allowPets = param1.readInteger() == 1;
         var_144.allowFoodConsume = param1.readInteger() == 1;
         return true;
      }
      
      public function flush() : Boolean
      {
         var_144 = null;
         return true;
      }
   }
}
