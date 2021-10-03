package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class IssueCloseNotificationMessageParser implements IMessageParser
   {
       
      
      private var var_2158:int;
      
      public function IssueCloseNotificationMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2158 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get closeReason() : int
      {
         return var_2158;
      }
   }
}
