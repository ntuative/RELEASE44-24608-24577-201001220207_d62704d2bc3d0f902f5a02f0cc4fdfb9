package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TradingAcceptParser implements IMessageParser
   {
       
      
      private var var_1170:Boolean;
      
      private var _userID:int;
      
      public function TradingAcceptParser()
      {
         super();
      }
      
      public function get userAccepts() : Boolean
      {
         return var_1170;
      }
      
      public function flush() : Boolean
      {
         _userID = -1;
         var_1170 = false;
         return true;
      }
      
      public function get userID() : int
      {
         return _userID;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userID = param1.readInteger();
         var_1170 = param1.readInteger() > 0;
         return true;
      }
   }
}
