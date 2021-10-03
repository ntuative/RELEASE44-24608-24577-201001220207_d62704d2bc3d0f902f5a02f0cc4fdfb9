package com.sulake.habbo.toolbar
{
   public class ToolbarIconBouncer
   {
       
      
      private var var_1893:Number;
      
      private var var_542:Number = 0;
      
      private var var_1892:Number;
      
      private var var_543:Number;
      
      public function ToolbarIconBouncer(param1:Number, param2:Number)
      {
         super();
         var_1893 = param1;
         var_1892 = param2;
      }
      
      public function update() : void
      {
         var_543 += var_1892;
         var_542 += var_543;
         if(var_542 > 0)
         {
            var_542 = 0;
            var_543 = var_1893 * -1 * var_543;
         }
      }
      
      public function reset(param1:int) : void
      {
         var_543 = param1;
         var_542 = 0;
      }
      
      public function get location() : Number
      {
         return var_542;
      }
   }
}
