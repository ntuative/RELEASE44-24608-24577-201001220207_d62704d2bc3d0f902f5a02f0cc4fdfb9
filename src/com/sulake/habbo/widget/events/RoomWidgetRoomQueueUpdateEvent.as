package com.sulake.habbo.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_383:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
      
      public static const const_301:String = "RWRQUE_VISITOR_QUEUE_STATUS";
       
      
      private var var_860:int;
      
      private var var_260:Boolean;
      
      private var var_1885:Boolean;
      
      private var var_1356:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_860 = param2;
         var_1885 = param3;
         var_260 = param4;
         var_1356 = param5;
      }
      
      public function get position() : int
      {
         return var_860;
      }
      
      public function get isActive() : Boolean
      {
         return var_260;
      }
      
      public function get isClubQueue() : Boolean
      {
         return var_1356;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return var_1885;
      }
   }
}
