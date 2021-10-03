package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.window.IWindowContainer;
   import flash.display.BitmapData;
   
   public class MarketPlaceOfferData
   {
       
      
      private var var_2011:int;
      
      private var var_1223:int;
      
      private var var_1682:int;
      
      private var var_2012:int = -1;
      
      private var _window:IWindowContainer;
      
      private var var_363:int;
      
      private var _offerId:int;
      
      private var _furniType:int;
      
      private var _image:BitmapData;
      
      private var var_1224:int;
      
      private var var_1716:int;
      
      public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int = -1)
      {
         super();
         _offerId = param1;
         var_1716 = param2;
         _furniType = param3;
         var_1223 = param4;
         var_363 = param5;
         var_1682 = param6;
         var_1224 = param7;
      }
      
      public function get furniId() : int
      {
         return var_1716;
      }
      
      public function get furniType() : int
      {
         return _furniType;
      }
      
      public function set imageCallback(param1:int) : void
      {
         var_2011 = param1;
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
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function set timeLeftMinutes(param1:int) : void
      {
         var_2012 = param1;
      }
      
      public function dispose() : void
      {
         if(_image)
         {
            _image.dispose();
         }
         if(_window)
         {
            _window.dispose();
         }
      }
      
      public function set window(param1:IWindowContainer) : void
      {
         _window = param1;
      }
      
      public function set price(param1:int) : void
      {
         var_1223 = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         var_1224 = param1;
      }
      
      public function get status() : int
      {
         return var_363;
      }
      
      public function get averagePrice() : int
      {
         return var_1682;
      }
      
      public function get imageCallback() : int
      {
         return var_2011;
      }
      
      public function set offerId(param1:int) : void
      {
         _offerId = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
