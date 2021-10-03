package com.sulake.habbo.inventory.purse
{
   public class Purse
   {
       
      
      private var var_1819:Boolean = false;
      
      private var var_1818:int = 0;
      
      private var var_1821:int = 0;
      
      private var var_1822:int = 0;
      
      private var var_1413:int = 0;
      
      private var var_1820:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function set creditBalance(param1:int) : void
      {
         var_1413 = Math.max(0,param1);
      }
      
      public function get clubPastPeriods() : int
      {
         return var_1818;
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return var_1819;
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         var_1819 = param1;
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         var_1818 = Math.max(0,param1);
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1821 = Math.max(0,param1);
      }
      
      public function get creditBalance() : int
      {
         return var_1413;
      }
      
      public function set pixelBalance(param1:int) : void
      {
         var_1822 = Math.max(0,param1);
      }
      
      public function get clubDays() : int
      {
         return var_1821;
      }
      
      public function get pixelBalance() : int
      {
         return var_1822;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1820 = Math.max(0,param1);
      }
      
      public function get clubPeriods() : int
      {
         return var_1820;
      }
   }
}
