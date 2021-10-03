package com.sulake.room.renderer.utils
{
   public class ObjectMouseData
   {
       
      
      private var var_1594:String = "";
      
      private var var_160:String = "";
      
      public function ObjectMouseData()
      {
         super();
      }
      
      public function set spriteTag(param1:String) : void
      {
         var_1594 = param1;
      }
      
      public function set objectId(param1:String) : void
      {
         var_160 = param1;
      }
      
      public function get spriteTag() : String
      {
         return var_1594;
      }
      
      public function get objectId() : String
      {
         return var_160;
      }
   }
}
