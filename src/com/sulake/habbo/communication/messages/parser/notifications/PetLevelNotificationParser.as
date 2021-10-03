package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetLevelNotificationParser implements IMessageParser
   {
       
      
      private var var_558:String;
      
      private var var_1647:int;
      
      private var var_1942:String;
      
      private var var_988:int;
      
      private var var_1096:int;
      
      public function PetLevelNotificationParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return var_1096;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1096 = param1.readInteger();
         var_1942 = param1.readString();
         var_1647 = param1.readInteger();
         var_558 = param1.readString();
         var_988 = param1.readInteger();
         return true;
      }
      
      public function get petName() : String
      {
         return var_1942;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get figure() : String
      {
         return var_558;
      }
      
      public function get petType() : int
      {
         return var_988;
      }
      
      public function get level() : int
      {
         return var_1647;
      }
   }
}
