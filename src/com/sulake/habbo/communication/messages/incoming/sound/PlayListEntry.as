package com.sulake.habbo.communication.messages.incoming.sound
{
   public class PlayListEntry
   {
       
      
      private var var_1873:int;
      
      private var var_1869:int = 0;
      
      private var var_1872:String;
      
      private var var_1871:int;
      
      private var var_1870:String;
      
      public function PlayListEntry(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         var_1873 = param1;
         var_1871 = param2;
         var_1870 = param3;
         var_1872 = param4;
      }
      
      public function get length() : int
      {
         return var_1871;
      }
      
      public function get name() : String
      {
         return var_1870;
      }
      
      public function get creator() : String
      {
         return var_1872;
      }
      
      public function get startPlayHeadPos() : int
      {
         return var_1869;
      }
      
      public function get id() : int
      {
         return var_1873;
      }
      
      public function set startPlayHeadPos(param1:int) : void
      {
         var_1869 = param1;
      }
   }
}
