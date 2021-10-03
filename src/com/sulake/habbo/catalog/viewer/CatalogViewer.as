package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public class CatalogViewer implements ICatalogViewer
   {
       
      
      private var _container:IWindowContainer;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_669:ICatalogPage;
      
      private var var_96:IHabboCatalog;
      
      public function CatalogViewer(param1:IHabboCatalog, param2:IWindowContainer, param3:IRoomEngine)
      {
         super();
         var_96 = param1;
         _container = param2;
         _roomEngine = param3;
      }
      
      public function getCurrentLayoutCode() : String
      {
         if(var_669 == null)
         {
            return "";
         }
         return var_669.layoutCode;
      }
      
      public function showCatalogPage(param1:int, param2:String, param3:IPageLocalization, param4:Array) : void
      {
         Logger.log("[Catalog Viewer] Show Catalog Page: " + [param1,param2,param4.length]);
         if(var_669 != null)
         {
            _container.removeChild(var_669.window);
            var_669.dispose();
         }
         var _loc5_:ICatalogPage = new CatalogPage(this,param1,param2,param3,param4);
         var_669 = _loc5_;
         if(_loc5_.window != null)
         {
            _container.addChild(_loc5_.window);
         }
         else
         {
            Logger.log("[CatalogViewer] No window for page: " + param2);
         }
         _container.visible = true;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return var_96;
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return var_669.dispatchWidgetEvent(param1);
      }
      
      public function dispose() : void
      {
      }
   }
}
