package com.sulake.habbo.catalog.purse
{
   public class Purse implements IPurse
   {
       
      
      private var var_1821:int = 0;
      
      private var var_1994:int = 0;
      
      private var var_1693:int = 0;
      
      private var var_1820:int = 0;
      
      public function Purse()
      {
         super();
      }
      
      public function get pixels() : int
      {
         return var_1994;
      }
      
      public function set pixels(param1:int) : void
      {
         var_1994 = param1;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1821 = param1;
      }
      
      public function get credits() : int
      {
         return var_1693;
      }
      
      public function get clubDays() : int
      {
         return var_1821;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1820 = param1;
      }
      
      public function set credits(param1:int) : void
      {
         var_1693 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return var_1820;
      }
   }
}
