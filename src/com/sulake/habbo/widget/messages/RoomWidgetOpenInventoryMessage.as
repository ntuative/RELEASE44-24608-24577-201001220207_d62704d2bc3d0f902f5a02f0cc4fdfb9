package com.sulake.habbo.widget.messages
{
   public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage
   {
      
      public static const const_903:String = "inventory_badges";
      
      public static const const_1182:String = "inventory_clothes";
      
      public static const const_1350:String = "inventory_furniture";
      
      public static const const_701:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
      
      public static const const_886:String = "inventory_effects";
       
      
      private var var_2204:String;
      
      public function RoomWidgetOpenInventoryMessage(param1:String)
      {
         super(const_701);
         var_2204 = param1;
      }
      
      public function get inventoryType() : String
      {
         return var_2204;
      }
   }
}
