package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class AvailabilityStatusMessageParser implements IMessageParser
   {
       
      
      private var var_907:Boolean;
      
      private var var_1233:Boolean;
      
      public function AvailabilityStatusMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_907 = param1.readInteger() > 0;
         var_1233 = param1.readInteger() > 0;
         return true;
      }
      
      public function get isOpen() : Boolean
      {
         return var_907;
      }
      
      public function get onShutDown() : Boolean
      {
         return var_1233;
      }
      
      public function flush() : Boolean
      {
         var_907 = false;
         var_1233 = false;
         return true;
      }
   }
}
