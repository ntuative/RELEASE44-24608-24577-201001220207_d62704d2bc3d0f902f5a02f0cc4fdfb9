package com.sulake.room.events
{
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      
      public static const const_1525:String = "ROE_MOUSE_LEAVE";
      
      public static const const_1428:String = "ROE_MOUSE_ENTER";
      
      public static const const_441:String = "ROE_MOUSE_MOVE";
      
      public static const const_1484:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const const_217:String = "ROE_MOUSE_CLICK";
      
      public static const const_456:String = "ROE_MOUSE_DOWN";
       
      
      private var var_1753:Boolean;
      
      private var var_1758:Boolean;
      
      private var var_1757:Boolean;
      
      private var var_1761:Boolean;
      
      public function RoomObjectMouseEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false)
      {
         super(param1,param2,param3,param8,param9);
         var_1757 = param4;
         var_1761 = param5;
         var_1753 = param6;
         var_1758 = param7;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_1758;
      }
      
      public function get altKey() : Boolean
      {
         return var_1757;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_1761;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_1753;
      }
   }
}
