package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvailabilityTimeMessageParser implements IMessageParser
   {
       
      
      private var var_907:Boolean;
      
      private var var_1153:int;
      
      public function AvailabilityTimeMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_907 = param1.readInteger() > 0;
         var_1153 = param1.readInteger();
         return true;
      }
      
      public function get isOpen() : Boolean
      {
         return var_907;
      }
      
      public function flush() : Boolean
      {
         var_907 = false;
         var_1153 = 0;
         return true;
      }
      
      public function get minutesUntilChange() : int
      {
         return var_1153;
      }
   }
}
