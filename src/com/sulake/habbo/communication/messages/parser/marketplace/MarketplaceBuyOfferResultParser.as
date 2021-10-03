package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceBuyOfferResultParser implements IMessageParser
   {
       
      
      private var var_1635:int = -1;
      
      private var var_1637:int = -1;
      
      private var var_1636:int = -1;
      
      private var _result:int;
      
      public function MarketplaceBuyOfferResultParser()
      {
         super();
      }
      
      public function get newPrice() : int
      {
         return var_1637;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get requestedOfferId() : int
      {
         return var_1635;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readInteger();
         var_1636 = param1.readInteger();
         var_1637 = param1.readInteger();
         var_1635 = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get offerId() : int
      {
         return var_1636;
      }
   }
}
