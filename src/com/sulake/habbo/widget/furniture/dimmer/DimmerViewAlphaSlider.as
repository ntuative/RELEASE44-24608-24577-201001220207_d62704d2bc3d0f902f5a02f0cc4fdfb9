package com.sulake.habbo.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class DimmerViewAlphaSlider
   {
       
      
      private var _view:DimmerView;
      
      private var var_2332:int;
      
      private var var_574:BitmapData;
      
      private var var_1020:int = 255;
      
      private var var_1498:int;
      
      private var var_693:int = 0;
      
      private var _sliderContainer:IWindowContainer;
      
      private var var_573:BitmapData;
      
      public function DimmerViewAlphaSlider(param1:DimmerView, param2:IWindowContainer, param3:IAssetLibrary, param4:int = 0, param5:int = 255)
      {
         super();
         _view = param1;
         _sliderContainer = param2;
         var_693 = param4;
         var_1020 = param5;
         storeAssets(param3);
         displaySlider();
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.const_99 && param1.type != WindowMouseEvent.const_597)
         {
            return;
         }
         _view.selectedBrightness = getValue(param2.x);
      }
      
      private function displaySlider() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_sliderContainer == null)
         {
            return;
         }
         _loc2_ = _sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow;
         if(_loc2_ != null && var_573 != null)
         {
            _loc2_.bitmap = new BitmapData(var_573.width,var_573.height,true,16777215);
            _loc2_.bitmap.copyPixels(var_573,var_573.rect,new Point(0,0),null,null,true);
         }
         _loc1_ = _sliderContainer.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.findChildByName("slider_button") as IBitmapWrapperWindow;
            if(_loc2_ != null && var_574 != null)
            {
               _loc2_.bitmap = new BitmapData(var_574.width,var_574.height,true,16777215);
               _loc2_.bitmap.copyPixels(var_574,var_574.rect,new Point(0,0),null,null,true);
               _loc2_.procedure = buttonProcedure;
               var_1498 = _loc1_.width - _loc2_.width;
            }
         }
      }
      
      private function storeAssets(param1:IAssetLibrary) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_base"));
         var_573 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_button"));
         var_574 = BitmapData(_loc2_.content);
      }
      
      public function set max(param1:Number) : void
      {
         var_1020 = param1;
         setValue(_view.selectedBrightness);
      }
      
      public function dispose() : void
      {
         _view = null;
         _sliderContainer = null;
         var_573 = null;
         var_574 = null;
      }
      
      private function getSliderPosition(param1:int) : int
      {
         return int(var_1498 * (Number(param1 - var_693) / (var_1020 - var_693)));
      }
      
      public function set min(param1:Number) : void
      {
         var_693 = param1;
         setValue(_view.selectedBrightness);
      }
      
      public function setValue(param1:int) : void
      {
         if(_sliderContainer == null)
         {
            return;
         }
         var _loc2_:IWindow = _sliderContainer.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / var_1498 * (var_1020 - var_693)) + var_693;
      }
   }
}
