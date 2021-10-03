package com.sulake.habbo.widget.messages
{
   public class RoomWidgetFurniActionMessage extends RoomWidgetMessage
   {
      
      public static const const_237:String = "RWFAM_MOVE";
      
      public static const const_578:String = "RWFUAM_ROTATE";
      
      public static const const_542:String = "RWFAM_PICKUP";
       
      
      private var var_1716:int = 0;
      
      private var var_1717:int = 0;
      
      public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         var_1716 = param2;
         var_1717 = param3;
      }
      
      public function get furniId() : int
      {
         return var_1716;
      }
      
      public function get furniCategory() : int
      {
         return var_1717;
      }
   }
}
