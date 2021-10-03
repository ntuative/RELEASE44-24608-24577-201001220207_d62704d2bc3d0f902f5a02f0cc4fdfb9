package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ItemPopupCtrl
   {
      
      private static const const_1089:int = 100;
      
      private static const const_1088:int = 200;
      
      private static const const_1090:int = 180;
      
      public static const const_931:int = 1;
      
      public static const const_373:int = 2;
      
      private static const const_1091:int = 250;
      
      private static const const_762:int = 5;
       
      
      private var var_562:BitmapData;
      
      private var var_302:Timer;
      
      private var var_23:IWindowContainer;
      
      private var var_682:BitmapData;
      
      private var var_303:Timer;
      
      private var var_81:IWindowContainer;
      
      private var var_1481:int = 2;
      
      private var _assets:IAssetLibrary;
      
      public function ItemPopupCtrl(param1:IWindowContainer, param2:IAssetLibrary)
      {
         var_303 = new Timer(const_1091,1);
         var_302 = new Timer(const_1089,1);
         super();
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            return;
         }
         var_81 = param1;
         var_81.visible = false;
         _assets = param2;
         var_303.addEventListener(TimerEvent.TIMER,onDisplayTimer);
         var_302.addEventListener(TimerEvent.TIMER,onHideTimer);
         var _loc3_:BitmapDataAsset = _assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset;
         if(_loc3_ != null && _loc3_.content != null)
         {
            var_682 = _loc3_.content as BitmapData;
         }
         _loc3_ = _assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset;
         if(_loc3_ != null && _loc3_.content != null)
         {
            var_562 = _loc3_.content as BitmapData;
         }
      }
      
      public function hide() : void
      {
         var_81.visible = false;
         var_302.reset();
         var_303.reset();
         if(var_23 != null)
         {
            var_23.removeChild(var_81);
         }
      }
      
      public function hideDelayed() : void
      {
         var_302.reset();
         var_303.reset();
         var_302.start();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         hide();
      }
      
      public function dispose() : void
      {
         if(var_303 != null)
         {
            var_303.removeEventListener(TimerEvent.TIMER,onDisplayTimer);
            var_303.stop();
            var_303 = null;
         }
         if(var_302 != null)
         {
            var_302.removeEventListener(TimerEvent.TIMER,onHideTimer);
            var_302.stop();
            var_302 = null;
         }
         _assets = null;
         var_81 = null;
         var_23 = null;
         var_562 = null;
         var_682 = null;
      }
      
      public function showDelayed() : void
      {
         var_302.reset();
         var_303.reset();
         var_303.start();
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         show();
      }
      
      public function updateContent(param1:IWindowContainer, param2:String, param3:BitmapData, param4:int = 2) : void
      {
         var _loc7_:* = null;
         if(var_81 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = new BitmapData(1,1,true,16777215);
         }
         if(var_23 != null)
         {
            var_23.removeChild(var_81);
         }
         var_23 = param1;
         var_1481 = param4;
         var _loc5_:ITextWindow = ITextWindow(var_81.findChildByName("item_name_text"));
         if(_loc5_)
         {
            _loc5_.text = param2;
         }
         var _loc6_:IBitmapWrapperWindow = var_81.findChildByName("item_image") as IBitmapWrapperWindow;
         if(_loc6_)
         {
            _loc7_ = new BitmapData(Math.min(const_1090,param3.width),Math.min(const_1088,param3.height),true,16777215);
            _loc7_.copyPixels(param3,new Rectangle(0,0,_loc7_.width,_loc7_.height),new Point(0,0),null,null,true);
            _loc6_.bitmap = _loc7_;
            _loc6_.width = _loc6_.bitmap.width;
            _loc6_.height = _loc6_.bitmap.height;
            _loc6_.x = (0 - _loc6_.width) / 2;
            var_81.height = _loc6_.rectangle.bottom + 10;
         }
      }
      
      private function refreshArrow(param1:int = 2) : void
      {
         if(var_81 == null || false)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_81.findChildByName("arrow_pointer"));
         if(!_loc2_)
         {
            return;
         }
         switch(param1)
         {
            case const_931:
               _loc2_.bitmap = var_682.clone();
               _loc2_.width = var_682.width;
               _loc2_.height = var_682.height;
               _loc2_.y = (0 - 0) / 2;
               _loc2_.x = -1;
               break;
            case const_373:
               _loc2_.bitmap = var_562.clone();
               _loc2_.width = var_562.width;
               _loc2_.height = var_562.height;
               _loc2_.y = (0 - 0) / 2;
               _loc2_.x = 1;
         }
         _loc2_.invalidate();
      }
      
      public function show() : void
      {
         var_302.reset();
         var_303.reset();
         if(var_23 == null)
         {
            return;
         }
         var_81.visible = true;
         var_23.addChild(var_81);
         refreshArrow(var_1481);
         switch(var_1481)
         {
            case const_931:
               var_81.x = 0 - const_762;
               break;
            case const_373:
               var_81.x = var_23.width + const_762;
         }
         var_81.y = (0 - 0) / 2;
      }
   }
}
