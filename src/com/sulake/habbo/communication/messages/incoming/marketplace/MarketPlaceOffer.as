package com.sulake.habbo.communication.messages.incoming.marketplace
{
   public class MarketPlaceOffer
   {
       
      
      private var var_1223:int;
      
      private var var_2012:int = -1;
      
      private var var_363:int;
      
      private var var_1682:int;
      
      private var _furniType:int;
      
      private var _offerId:int;
      
      private var var_1224:int;
      
      private var var_1716:int;
      
      public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int = -1)
      {
         super();
         _offerId = param1;
         var_1716 = param2;
         _furniType = param3;
         var_1223 = param4;
         var_363 = param5;
         var_2012 = param6;
         var_1682 = param7;
         var_1224 = param8;
      }
      
      public function get status() : int
      {
         return var_363;
      }
      
      public function get price() : int
      {
         return var_1223;
      }
      
      public function get timeLeftMinutes() : int
      {
         return var_2012;
      }
      
      public function get offerCount() : int
      {
         return var_1224;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get furniType() : int
      {
         return _furniType;
      }
      
      public function get averagePrice() : int
      {
         return var_1682;
      }
      
      public function get furniId() : int
      {
         return var_1716;
      }
   }
}
