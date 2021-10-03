package com.sulake.habbo.messenger.domain
{
   public class Message
   {
      
      public static const const_538:int = 2;
      
      public static const const_930:int = 6;
      
      public static const const_528:int = 1;
      
      public static const const_548:int = 3;
      
      public static const const_978:int = 4;
      
      public static const const_613:int = 5;
       
      
      private var var_1660:String;
      
      private var var_995:int;
      
      private var var_1659:String;
      
      private var _type:int;
      
      public function Message(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         _type = param1;
         var_995 = param2;
         var_1659 = param3;
         var_1660 = param4;
      }
      
      public function get time() : String
      {
         return var_1660;
      }
      
      public function get senderId() : int
      {
         return var_995;
      }
      
      public function get messageText() : String
      {
         return var_1659;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}
