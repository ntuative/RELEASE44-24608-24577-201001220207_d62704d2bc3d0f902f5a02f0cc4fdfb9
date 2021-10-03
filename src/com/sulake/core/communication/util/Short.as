package com.sulake.core.communication.util
{
   import flash.utils.ByteArray;
   
   public class Short
   {
       
      
      private var var_715:ByteArray;
      
      public function Short(param1:int)
      {
         super();
         var_715 = new ByteArray();
         var_715.writeShort(param1);
         var_715.position = 0;
      }
      
      public function get value() : int
      {
         var _loc1_:int = 0;
         var_715.position = 0;
         if(false)
         {
            _loc1_ = var_715.readShort();
            var_715.position = 0;
         }
         return _loc1_;
      }
   }
}
