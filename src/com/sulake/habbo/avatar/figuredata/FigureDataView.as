package com.sulake.habbo.avatar.figuredata
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class FigureDataView
   {
       
      
      private var var_505:IBitmapWrapperWindow;
      
      private var _window:IWindowContainer;
      
      private var var_1300:BitmapData;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      public function FigureDataView(param1:IHabboWindowManager, param2:IAssetLibrary)
      {
         super();
         _assetLibrary = param2;
         _windowManager = param1;
         var _loc3_:XmlAsset = _assetLibrary.getAssetByName("AvatarEditorImage") as XmlAsset;
         _window = IWindowContainer(_windowManager.buildFromXML(_loc3_.content as XML));
         var _loc4_:BitmapDataAsset = _assetLibrary.getAssetByName("platform") as BitmapDataAsset;
         var_1300 = _loc4_.content as BitmapData;
         if(_window != null)
         {
            var_505 = _window.findChildByName("bitmap") as IBitmapWrapperWindow;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function udpate(param1:BitmapData) : void
      {
         var_505.bitmap = new BitmapData(var_505.width,var_505.height,true,16777215);
         var_505.bitmap.copyPixels(var_1300,var_1300.rect,new Point(0,0 - 0 - 8));
         var_505.bitmap.copyPixels(param1,param1.rect,new Point(4,0),null,null,true);
      }
   }
}
