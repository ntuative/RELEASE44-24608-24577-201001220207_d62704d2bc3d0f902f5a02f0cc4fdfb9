package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class MarketPlaceLogic implements IMarketPlace
   {
       
      
      public const const_1624:int = 3;
      
      public const const_1550:int = 2;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1948:int;
      
      private var _visualization:IMarketPlaceVisualization;
      
      private var var_1953:int = -1;
      
      private var _windowManager:IHabboWindowManager;
      
      public const const_1430:int = 1;
      
      private var var_671:Map;
      
      private var var_1996:MarketplaceItemStats;
      
      private var var_96:IHabboCatalog;
      
      private var var_229:Map;
      
      private var var_670:int = -1;
      
      private var var_1949:int;
      
      private var var_1888:int;
      
      private var var_195:MarketplaceConfirmationDialog;
      
      public function MarketPlaceLogic(param1:IHabboCatalog, param2:IHabboWindowManager, param3:IRoomEngine)
      {
         super();
         var_96 = param1;
         _windowManager = param2;
         _roomEngine = param3;
         getConfiguration();
      }
      
      public function requestOffers(param1:int, param2:int, param3:String, param4:int) : void
      {
         if(var_96)
         {
            var_96.getPublicMarketPlaceOffers(param1,param2,param3,param4);
         }
      }
      
      public function latestOwnOffers() : Map
      {
         return var_671;
      }
      
      public function requestOwnItems() : void
      {
         var_96.getOwnMarketPlaceOffers();
      }
      
      public function get averagePricePeriod() : int
      {
         return var_1953;
      }
      
      public function get localization() : ICoreLocalizationManager
      {
         return var_96.localization;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function dispose() : void
      {
         var_96 = null;
         _windowManager = null;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         var_1953 = param1;
      }
      
      public function set itemStats(param1:MarketplaceItemStats) : void
      {
         if(param1.furniCategoryId != var_1949 || param1.furniTypeId != var_1948)
         {
            return;
         }
         var_1996 = param1;
         if(_visualization)
         {
            _visualization.listUpdatedNotify();
         }
      }
      
      public function onBuyResult(param1:IMessageEvent) : void
      {
         var newItem:MarketPlaceOfferData = null;
         var updateItem:MarketPlaceOfferData = null;
         var event:IMessageEvent = param1;
         var buyEvent:MarketplaceBuyOfferResultEvent = event as MarketplaceBuyOfferResultEvent;
         var parser:MarketplaceBuyOfferResultParser = buyEvent.getParser() as MarketplaceBuyOfferResultParser;
         if(parser.result == 1)
         {
            if(parser.offerId > 0)
            {
               newItem = var_229.getValue(parser.requestedOfferId) as MarketPlaceOfferData;
               var_229.remove(parser.requestedOfferId);
               newItem.offerId = parser.offerId;
               newItem.price = parser.newPrice;
               --newItem.offerCount;
               var_229.add(parser.offerId,newItem);
            }
            else
            {
               var_229.remove(parser.requestedOfferId);
            }
            var_670 = -1;
            _visualization.listUpdatedNotify();
         }
         else if(parser.result == 2)
         {
            var_229.remove(parser.requestedOfferId);
            var_670 = -1;
            _visualization.listUpdatedNotify();
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.marketplace.not_available_title}","${catalog.marketplace.not_available_header}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
            }
         }
         else if(parser.result == 3)
         {
            updateItem = var_229.getValue(parser.requestedOfferId) as MarketPlaceOfferData;
            if(updateItem)
            {
               updateItem.offerId = parser.offerId;
               updateItem.price = parser.newPrice;
               --updateItem.offerCount;
               var_229.add(parser.offerId,updateItem);
            }
            var_229.remove(parser.requestedOfferId);
            var_670 = parser.offerId;
            showConfirmation(const_1550,updateItem);
            _visualization.listUpdatedNotify();
         }
         else if(parser.result == 4)
         {
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.alert.notenough.title}","${catalog.alert.notenough.credits.description}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
            }
         }
      }
      
      public function requestOffersByName(param1:String) : void
      {
         var_96.getPublicMarketPlaceOffers(-1,-1,param1,-1);
      }
      
      public function onCancelResult(param1:IMessageEvent) : void
      {
         var event:IMessageEvent = param1;
         var cancelEvent:MarketplaceCancelOfferResultEvent = event as MarketplaceCancelOfferResultEvent;
         var parser:MarketplaceCancelOfferResultParser = cancelEvent.getParser() as MarketplaceCancelOfferResultParser;
         if(parser.result == 1)
         {
            var_671.remove(parser.offerId);
            _visualization.listUpdatedNotify();
         }
         else if(parser.result == 0)
         {
            if(_windowManager != null)
            {
               _windowManager.alert("${catalog.marketplace.operation_failed.topic}","{{catalog.marketplace.cancel_failed}",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
            }
         }
      }
      
      private function getConfiguration() : void
      {
         if(!var_96 || true)
         {
            return;
         }
         var_96.connection.send(new GetMarketplaceConfigurationMessageComposer());
      }
      
      public function registerVisualization(param1:IMarketPlaceVisualization = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         _visualization = param1;
      }
      
      public function redeemSoldOffers() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = var_671.getKeys();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = var_671.getValue(_loc2_);
            if(_loc3_.status == MarketPlaceOfferState.const_372)
            {
               var_671.remove(_loc2_);
            }
         }
         var_96.redeemSoldMarketPlaceOffers();
         _visualization.listUpdatedNotify();
      }
      
      public function onOwnOffers(param1:IMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:MarketPlaceOwnOffersEvent = param1 as MarketPlaceOwnOffersEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:MarketPlaceOwnOffersParser = _loc2_.getParser() as MarketPlaceOwnOffersParser;
         if(_loc3_ == null)
         {
            return;
         }
         var_1888 = _loc3_.creditsWaiting;
         var_671 = new Map();
         for each(_loc4_ in _loc3_.offers)
         {
            _loc5_ = new MarketPlaceOfferData(_loc4_.offerId,_loc4_.furniId,_loc4_.furniType,_loc4_.price,_loc4_.status,_loc4_.averagePrice);
            _loc5_.timeLeftMinutes = _loc4_.timeLeftMinutes;
            var_671.add(_loc4_.offerId,_loc5_);
         }
         if(_visualization == null)
         {
            return;
         }
         _visualization.listUpdatedNotify();
      }
      
      public function requestOffersByPrice(param1:int) : void
      {
         var_96.getPublicMarketPlaceOffers(param1,-1,"",-1);
      }
      
      private function showConfirmation(param1:int, param2:MarketPlaceOfferData) : void
      {
         if(!var_195)
         {
            var_195 = new MarketplaceConfirmationDialog(this,var_96,_roomEngine);
         }
         var_195.showConfirmation(param1,param2);
      }
      
      public function onOffers(param1:IMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:MarketPlaceOffersEvent = param1 as MarketPlaceOffersEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:MarketPlaceOffersParser = _loc2_.getParser() as MarketPlaceOffersParser;
         if(_loc3_ == null)
         {
            return;
         }
         if(var_229)
         {
            for each(_loc5_ in var_229)
            {
               _loc5_.dispose();
            }
         }
         var_229 = new Map();
         for each(_loc4_ in _loc3_.offers)
         {
            _loc6_ = new MarketPlaceOfferData(_loc4_.offerId,_loc4_.furniId,_loc4_.furniType,_loc4_.price,_loc4_.status,_loc4_.averagePrice,_loc4_.offerCount);
            _loc6_.timeLeftMinutes = _loc4_.timeLeftMinutes;
            var_229.add(_loc4_.offerId,_loc6_);
         }
         if(_visualization == null)
         {
            return;
         }
         _visualization.listUpdatedNotify();
      }
      
      public function get itemStats() : MarketplaceItemStats
      {
         return var_1996;
      }
      
      public function get creditsWaiting() : int
      {
         return var_1888;
      }
      
      public function redeemExpiredOffer(param1:int) : void
      {
         var_96.redeemExpiredMarketPlaceOffer(param1);
      }
      
      public function buyOffer(param1:int) : void
      {
         var_670 = param1;
         var _loc2_:MarketPlaceOfferData = var_229.getValue(param1) as MarketPlaceOfferData;
         showConfirmation(const_1430,_loc2_);
      }
      
      public function requestItemStats(param1:int, param2:int) : void
      {
         if(var_96)
         {
            var_1948 = param2;
            var_1949 = param1;
            var_96.getMarketplaceItemStats(param1,param2);
         }
      }
      
      public function latestOffers() : Map
      {
         return var_229;
      }
   }
}
