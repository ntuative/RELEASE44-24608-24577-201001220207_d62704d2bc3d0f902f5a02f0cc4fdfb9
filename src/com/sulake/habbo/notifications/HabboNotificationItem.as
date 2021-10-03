package com.sulake.habbo.notifications
{
   public class HabboNotificationItem
   {
       
      
      private var var_89:HabboNotificationItemStyle;
      
      private var var_35:String;
      
      private var var_44:HabboNotifications;
      
      public function HabboNotificationItem(param1:String, param2:HabboNotificationItemStyle, param3:HabboNotifications)
      {
         super();
         var_35 = param1;
         var_89 = param2;
         var_44 = param3;
      }
      
      public function ExecuteUiLinks() : void
      {
         var _loc2_:* = null;
         var _loc1_:Array = var_89.componentLinks;
         for each(_loc2_ in _loc1_)
         {
            if(var_44 != null)
            {
               var_44.onExecuteLink(_loc2_);
            }
         }
      }
      
      public function get style() : HabboNotificationItemStyle
      {
         return var_89;
      }
      
      public function get content() : String
      {
         return var_35;
      }
   }
}
