package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceConfigurationParser implements IMessageParser
   {
       
      
      private var var_1952:int;
      
      private var var_1463:int;
      
      private var var_1950:int;
      
      private var var_1951:int;
      
      private var var_1947:int;
      
      private var var_1464:int;
      
      private var var_1953:int;
      
      private var var_1881:Boolean;
      
      public function MarketplaceConfigurationParser()
      {
         super();
      }
      
      public function get offerMaxPrice() : int
      {
         return var_1952;
      }
      
      public function get tokenBatchPrice() : int
      {
         return var_1463;
      }
      
      public function get averagePricePeriod() : int
      {
         return var_1953;
      }
      
      public function get offerMinPrice() : int
      {
         return var_1951;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get expirationHours() : int
      {
         return var_1947;
      }
      
      public function get tokenBatchSize() : int
      {
         return var_1464;
      }
      
      public function get commission() : int
      {
         return var_1950;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1881 = param1.readBoolean();
         var_1950 = param1.readInteger();
         var_1463 = param1.readInteger();
         var_1464 = param1.readInteger();
         var_1951 = param1.readInteger();
         var_1952 = param1.readInteger();
         var_1947 = param1.readInteger();
         var_1953 = param1.readInteger();
         return true;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_1881;
      }
   }
}
