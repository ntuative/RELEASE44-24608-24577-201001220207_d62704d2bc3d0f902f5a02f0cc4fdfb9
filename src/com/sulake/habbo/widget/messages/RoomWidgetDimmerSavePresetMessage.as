package com.sulake.habbo.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      
      public static const const_604:String = "RWSDPM_SAVE_PRESET";
       
      
      private var _color:uint;
      
      private var var_1799:int;
      
      private var var_1798:int;
      
      private var var_1797:Boolean;
      
      private var var_899:int;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean)
      {
         super(const_604);
         var_1798 = param1;
         var_1799 = param2;
         _color = param3;
         var_899 = param4;
         var_1797 = param5;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get effectTypeId() : int
      {
         return var_1799;
      }
      
      public function get presetNumber() : int
      {
         return var_1798;
      }
      
      public function get brightness() : int
      {
         return var_899;
      }
      
      public function get apply() : Boolean
      {
         return var_1797;
      }
   }
}
