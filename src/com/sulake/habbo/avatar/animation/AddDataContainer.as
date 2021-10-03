package com.sulake.habbo.avatar.animation
{
   public class AddDataContainer
   {
       
      
      private var var_1338:String;
      
      private var var_1537:String;
      
      private var var_949:String;
      
      private var var_410:Number = 1;
      
      private var _id:String;
      
      public function AddDataContainer(param1:XML)
      {
         super();
         _id = String(param1.@id);
         var_1338 = String(param1.@align);
         var_949 = String(param1.@base);
         var_1537 = String(param1.@ink);
         var _loc2_:String = String(param1.@blend);
         if(_loc2_.length > 0)
         {
            var_410 = Number(_loc2_);
            if(var_410 > 1)
            {
               var_410 /= 100;
            }
         }
      }
      
      public function get align() : String
      {
         return var_1338;
      }
      
      public function get ink() : String
      {
         return var_1537;
      }
      
      public function get base() : String
      {
         return var_949;
      }
      
      public function get isBlended() : Boolean
      {
         return var_410 != 1;
      }
      
      public function get blend() : Number
      {
         return var_410;
      }
      
      public function get id() : String
      {
         return _id;
      }
   }
}
