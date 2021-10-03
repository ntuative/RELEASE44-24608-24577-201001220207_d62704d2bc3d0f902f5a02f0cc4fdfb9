package com.sulake.habbo.widget.events
{
   public class RoomWidgetPetCommandsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_144:String = "RWPCUE_PET_COMMANDS";
       
      
      private var _id:int;
      
      private var var_1003:Array;
      
      public function RoomWidgetPetCommandsUpdateEvent(param1:int, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super(RoomWidgetPetCommandsUpdateEvent.const_144,param3,param4);
         _id = param1;
         var_1003 = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get enabledCommands() : Array
      {
         return var_1003;
      }
   }
}
