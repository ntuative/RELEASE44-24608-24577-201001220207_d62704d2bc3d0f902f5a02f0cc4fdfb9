package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class Offer
   {
      
      public static const const_953:String = "price_type_none";
      
      public static const const_412:String = "pricing_model_multi";
      
      public static const const_468:String = "price_type_credits";
      
      public static const const_367:String = "price_type_credits_and_pixels";
      
      public static const const_375:String = "pricing_model_bundle";
      
      public static const const_355:String = "pricing_model_single";
      
      public static const const_666:String = "price_type_credits_or_credits_and_pixels";
      
      public static const const_1302:String = "pricing_model_unknown";
      
      public static const const_457:String = "price_type_pixels";
       
      
      private var var_800:int;
      
      private var _offerId:int;
      
      private var var_801:int;
      
      private var var_385:String;
      
      private var var_539:String;
      
      private var var_1876:int;
      
      private var var_669:ICatalogPage;
      
      private var var_1159:String;
      
      private var var_384:IProductContainer;
      
      public function Offer(param1:CatalogPageMessageOfferData, param2:ICatalogPage)
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         super();
         _offerId = param1.offerId;
         var_1159 = param1.localizationId;
         var_800 = param1.priceInCredits;
         var_801 = param1.priceInPixels;
         var_669 = param2;
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1.products)
         {
            _loc5_ = param2.viewer.catalog.getProductData(_loc4_.productType);
            _loc6_ = param2.viewer.catalog.getFurnitureData(_loc4_.furniClassId,_loc4_.productType);
            _loc7_ = new Product(_loc4_,_loc5_,_loc6_);
            _loc3_.push(_loc7_);
         }
         analyzePricingModel(_loc3_);
         analyzePriceType();
         createProductContainer(_loc3_);
      }
      
      public function get pricingModel() : String
      {
         return var_385;
      }
      
      public function get page() : ICatalogPage
      {
         return var_669;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_1876 = param1;
      }
      
      public function get productContainer() : IProductContainer
      {
         return var_384;
      }
      
      public function get localizationId() : String
      {
         return var_1159;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get priceInPixels() : int
      {
         return var_801;
      }
      
      public function dispose() : void
      {
         _offerId = 0;
         var_1159 = "";
         var_800 = 0;
         var_801 = 0;
         var_669 = null;
         if(var_384 != null)
         {
            var_384.dispose();
            var_384 = null;
         }
      }
      
      public function get priceType() : String
      {
         return var_539;
      }
      
      public function get previewCallbackId() : int
      {
         return var_1876;
      }
      
      public function get priceInCredits() : int
      {
         return var_800;
      }
      
      private function analyzePricingModel(param1:Array) : void
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            _loc2_ = param1[0];
            if(_loc2_.productCount == 1)
            {
               var_385 = const_355;
            }
            else
            {
               var_385 = const_412;
            }
         }
         else if(param1.length > 1)
         {
            var_385 = const_375;
         }
         else
         {
            var_385 = const_1302;
         }
      }
      
      private function createProductContainer(param1:Array) : void
      {
         switch(var_385)
         {
            case const_355:
               var_384 = new SingleProductContainer(this,param1);
               break;
            case const_412:
               var_384 = new MultiProductContainer(this,param1);
               break;
            case const_375:
               var_384 = new BundleProductContainer(this,param1);
               break;
            default:
               Logger.log("[Offer] Unknown pricing model" + var_385);
         }
      }
      
      private function analyzePriceType() : void
      {
         if(var_800 > 0 && var_801 > 0)
         {
            var_539 = const_367;
         }
         else if(var_800 > 0)
         {
            var_539 = const_468;
         }
         else if(var_801 > 0)
         {
            var_539 = const_457;
         }
         else
         {
            var_539 = const_953;
         }
      }
   }
}
