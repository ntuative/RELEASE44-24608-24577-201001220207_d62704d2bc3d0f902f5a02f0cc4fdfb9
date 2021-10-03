package com.sulake.habbo.widget.messages
{
   public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage
   {
      
      public static const const_786:String = "select_outfit";
       
      
      private var var_1921:int;
      
      public function RoomWidgetSelectOutfitMessage(param1:int)
      {
         super(const_786);
         var_1921 = param1;
      }
      
      public function get outfitId() : int
      {
         return var_1921;
      }
   }
}
