package com.sulake.habbo.toolbar
{
   public class MenuSettingsItem
   {
       
      
      private var var_1723:Array;
      
      private var var_1724:String;
      
      private var var_1722:Boolean;
      
      public function MenuSettingsItem(param1:String, param2:Array = null, param3:Boolean = false)
      {
         super();
         var_1724 = param1;
         var_1723 = param2;
         var_1722 = param3;
      }
      
      public function get menuId() : String
      {
         return var_1724;
      }
      
      public function get yieldList() : Array
      {
         return var_1723;
      }
      
      public function get lockToIcon() : Boolean
      {
         return var_1722;
      }
   }
}
