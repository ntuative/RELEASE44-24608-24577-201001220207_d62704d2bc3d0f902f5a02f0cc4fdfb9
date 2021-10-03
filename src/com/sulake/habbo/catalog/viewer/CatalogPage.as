package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.widgets.BotCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.CatalogWidgetEnum;
   import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ItemGroupCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PurseCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpacesCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import flash.events.Event;
   
   public class CatalogPage implements ICatalogPage
   {
      
      protected static const const_1370:String = "ctlg_";
       
      
      private var _localization:IPageLocalization;
      
      protected var var_1317:XML;
      
      protected var _window:IWindowContainer;
      
      private var var_739:String;
      
      private var var_1086:EventDispatcher;
      
      private var _widgets:Array;
      
      private var _pageId:int;
      
      private var var_832:ICatalogViewer;
      
      private var var_919:Array;
      
      public function CatalogPage(param1:ICatalogViewer, param2:int, param3:String, param4:IPageLocalization, param5:Array)
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         _widgets = [];
         super();
         var_832 = param1;
         _pageId = param2;
         var_739 = param3;
         _localization = param4;
         var_919 = new Array();
         for each(_loc6_ in param5)
         {
            _loc7_ = new Offer(_loc6_,this);
            if(_loc7_.productContainer != null)
            {
               var_919.push(_loc7_);
            }
            else
            {
               _loc7_.dispose();
            }
         }
         var_1086 = new EventDispatcher();
         _widgets = new Array();
         init();
      }
      
      public function get hasLinks() : Boolean
      {
         return _localization.hasLinks(var_739);
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc2_:String = const_1370 + param1;
         var _loc3_:XmlAsset = viewer.catalog.assets.getAssetByName(_loc2_) as XmlAsset;
         if(_loc3_ == null)
         {
            Logger.log("Could not find asset for layout " + _loc2_);
            return;
         }
         var_1317 = _loc3_.content as XML;
         _window = viewer.catalog.windowManager.buildFromXML(var_1317) as IWindowContainer;
         if(_window == null)
         {
            Logger.log("Could not create layout " + param1);
         }
      }
      
      public function init() : void
      {
         createWindow(layoutCode);
         createWidgets();
      }
      
      public function get viewer() : ICatalogViewer
      {
         return var_832;
      }
      
      private function createWidgets() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_window == null)
         {
            return;
         }
         _widgets.push(new LocalizationCatalogWidget(_window));
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1160) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new ItemGridCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1145) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new ItemGroupCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1316) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new ProductViewCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1304) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new SingleViewCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1156) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new PurchaseCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1276) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new PurseCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1238) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new ColourGridCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1325) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new TraxPreviewCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1186) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new RedeemItemCodeCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1211) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new SpacesCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1309) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new TrophyCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1351) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new PetsCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1281) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new BotCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1359) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new TextInputCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1155) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new SpecialInfoWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1263) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new RecyclerCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1303) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new RecyclerPrizesCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1164) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new MarketPlaceCatalogWidget(_loc1_));
         }
         _loc1_ = _window.findChildByName(CatalogWidgetEnum.const_1133) as IWindowContainer;
         if(_loc1_ != null)
         {
            _widgets.push(new MarketPlaceOwnItemsCatalogWidget(_loc1_));
         }
         for each(_loc2_ in _widgets)
         {
            _loc2_.page = this;
            _loc2_.events = var_1086;
            _loc2_.init();
         }
         var_1086.dispatchEvent(new CatalogWidgetsInitializedEvent());
      }
      
      public function get offers() : Array
      {
         return var_919;
      }
      
      private function localize() : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in _widgets)
         {
            _loc1_.dispose();
         }
         _widgets = null;
         _localization.dispose();
         for each(_loc2_ in var_919)
         {
            _loc2_.dispose();
         }
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         var_832 = null;
         var_1317 = null;
         _pageId = 0;
         var_739 = "";
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return var_1086.dispatchEvent(param1);
      }
      
      public function get localization() : IPageLocalization
      {
         return _localization;
      }
      
      public function get layoutCode() : String
      {
         return var_739;
      }
      
      public function get links() : Array
      {
         return _localization.getLinks(var_739);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
