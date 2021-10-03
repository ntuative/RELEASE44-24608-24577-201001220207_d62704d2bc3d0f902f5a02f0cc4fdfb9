package com.sulake.habbo.widget.events
{
   public class RoomWidgetDanceUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_607:String = "RWUE_DANCE";
       
      
      private var var_89:int;
      
      public function RoomWidgetDanceUpdateEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super(const_607,param2,param3);
         var_89 = param1;
      }
      
      public function get style() : int
      {
         return var_89;
      }
   }
}
