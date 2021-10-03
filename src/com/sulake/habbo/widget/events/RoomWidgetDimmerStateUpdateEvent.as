package com.sulake.habbo.widget.events
{
   public class RoomWidgetDimmerStateUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const DIMMER_STATE:String = "RWDSUE_DIMMER_STATE";
       
      
      private var var_900:int;
      
      private var _color:uint;
      
      private var var_899:int;
      
      private var var_1817:int;
      
      private var var_46:int;
      
      public function RoomWidgetDimmerStateUpdateEvent(param1:int, param2:int, param3:int, param4:uint, param5:uint, param6:Boolean = false, param7:Boolean = false)
      {
         super(DIMMER_STATE,param6,param7);
         var_46 = param1;
         var_1817 = param2;
         var_900 = param3;
         _color = param4;
         var_899 = param5;
      }
      
      public function get brightness() : uint
      {
         return var_899;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get effectId() : int
      {
         return var_900;
      }
      
      public function get state() : int
      {
         return var_46;
      }
      
      public function get presetId() : int
      {
         return var_1817;
      }
   }
}
