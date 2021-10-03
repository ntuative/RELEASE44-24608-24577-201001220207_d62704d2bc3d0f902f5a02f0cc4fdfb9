package com.sulake.habbo.catalog.marketplace
{
   public class MarketplaceItemStats
   {
       
      
      private var var_1364:Array;
      
      private var var_1682:int;
      
      private var var_1683:int;
      
      private var var_1679:int;
      
      private var var_1680:int;
      
      private var _dayOffsets:Array;
      
      private var var_1681:int;
      
      private var var_1365:Array;
      
      public function MarketplaceItemStats()
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
      
      public function set averagePrices(param1:Array) : void
      {
         var_1364 = param1.slice();
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         _dayOffsets = param1.slice();
      }
      
      public function get furniTypeId() : int
      {
         return var_1683;
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         var_1365 = param1.slice();
      }
      
      public function set averagePrice(param1:int) : void
      {
         var_1682 = param1;
      }
      
      public function get historyLength() : int
      {
         return var_1679;
      }
      
      public function get furniCategoryId() : int
      {
         return var_1680;
      }
      
      public function get offerCount() : int
      {
         return var_1681;
      }
      
      public function set offerCount(param1:int) : void
      {
         var_1681 = param1;
      }
      
      public function get soldAmounts() : Array
      {
         return var_1365;
      }
      
      public function get averagePrice() : int
      {
         return var_1682;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         var_1680 = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         var_1679 = param1;
      }
      
      public function set furniTypeId(param1:int) : void
      {
         var_1683 = param1;
      }
   }
}
