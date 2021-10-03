package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceItemStatsParser implements IMessageParser
   {
       
      
      private var var_1364:Array;
      
      private var var_1682:int;
      
      private var var_1683:int;
      
      private var var_1680:int;
      
      private var var_1679:int;
      
      private var _dayOffsets:Array;
      
      private var var_1681:int;
      
      private var var_1365:Array;
      
      public function MarketplaceItemStatsParser()
      {
         super();
      }
      
      public function get dayOffsets() : Array
      {
         return _dayOffsets;
      }
      
      public function get averagePrices() : Array
      {
         return var_1364;
      }
      
      public function get furniTypeId() : int
      {
         return var_1683;
      }
      
      public function get historyLength() : int
      {
         return var_1679;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get furniCategoryId() : int
      {
         return var_1680;
      }
      
      public function get offerCount() : int
      {
         return var_1681;
      }
      
      public function get soldAmounts() : Array
      {
         return var_1365;
      }
      
      public function get averagePrice() : int
      {
         return var_1682;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1682 = param1.readInteger();
         var_1681 = param1.readInteger();
         var_1679 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _dayOffsets = [];
         var_1364 = [];
         var_1365 = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _dayOffsets.push(param1.readInteger());
            var_1364.push(param1.readInteger());
            var_1365.push(param1.readInteger());
            _loc3_++;
         }
         var_1680 = param1.readInteger();
         var_1683 = param1.readInteger();
         return true;
      }
   }
}
