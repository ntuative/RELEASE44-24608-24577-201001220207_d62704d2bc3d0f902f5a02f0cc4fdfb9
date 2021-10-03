package com.sulake.habbo.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_209:String = "RWBIUE_HABBO_CLUB";
       
      
      private var var_2196:Boolean = false;
      
      private var var_2198:int = 0;
      
      private var var_2195:int = 0;
      
      private var var_2197:int = 0;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(const_209,param5,param6);
         var_2197 = param1;
         var_2195 = param2;
         var_2198 = param3;
         var_2196 = param4;
      }
      
      public function get pastPeriods() : int
      {
         return var_2198;
      }
      
      public function get periodsLeft() : int
      {
         return var_2195;
      }
      
      public function get daysLeft() : int
      {
         return var_2197;
      }
      
      public function get allowClubDances() : Boolean
      {
         return var_2196;
      }
   }
}
