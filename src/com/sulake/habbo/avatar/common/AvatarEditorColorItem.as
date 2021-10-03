package com.sulake.habbo.avatar.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AvatarEditorColorItem
   {
       
      
      private const const_1599:int = 8947848;
      
      private const const_1598:int = 13421772;
      
      private var _isSelected:Boolean = false;
      
      private var var_1388:BitmapData;
      
      private var _window:IWindowContainer;
      
      private var var_609:BitmapData;
      
      private var _model:IAvatarEditorCategoryModel;
      
      private var var_770:IPartColor;
      
      private var var_1077:BitmapData;
      
      private var var_908:BitmapData;
      
      public function AvatarEditorColorItem(param1:IWindowContainer, param2:IAvatarEditorCategoryModel, param3:IPartColor)
      {
         super();
         _model = param2;
         _window = param1;
         _window.background = true;
         var_770 = param3;
         var _loc4_:BitmapDataAsset = param2.controller.assets.getAssetByName("editor_clr_40x32_1") as BitmapDataAsset;
         var_609 = _loc4_.content as BitmapData;
         var _loc5_:BitmapDataAsset = param2.controller.assets.getAssetByName("editor_clr_40x32_2") as BitmapDataAsset;
         var_1077 = _loc5_.content as BitmapData;
         var _loc6_:BitmapDataAsset = param2.controller.assets.getAssetByName("editor_clr_40x32_3") as BitmapDataAsset;
         var_908 = _loc6_.content as BitmapData;
         var _loc7_:BitmapDataAsset = param2.controller.assets.getAssetByName("habbo_club_icon") as BitmapDataAsset;
         var_1388 = _loc7_.content as BitmapData;
         updateThumbData();
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         updateThumbData();
      }
      
      private function updateThumbData() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(_window == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:IBitmapWrapperWindow = _window.findChildByTag("BG_BORDER") as IBitmapWrapperWindow;
         if(_loc1_ != null)
         {
            _loc1_.bitmap = new BitmapData(var_609.width,var_609.height,true,0);
            _loc1_.bitmap.copyPixels(var_609,var_609.rect,new Point(0,0));
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = new BitmapData(var_1077.width,var_1077.height,true,0);
            _loc4_ = var_1077.clone();
            _loc4_.colorTransform(_loc4_.rect,var_770.colorTransform);
            _loc2_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(0,0));
         }
         var _loc3_:IBitmapWrapperWindow = _window.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            _loc3_.bitmap = new BitmapData(var_908.width,var_908.height,true,16777215);
            _loc3_.bitmap.copyPixels(var_908,var_908.rect,new Point(0,0),null,null,true);
            if(!_isSelected)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
            }
         }
         if(false)
         {
            _loc5_ = _window.findChildByTag("CLUB_ICON") as IBitmapWrapperWindow;
            if(_loc5_ != null)
            {
               _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
               _loc5_.bitmap.copyPixels(var_1388,var_1388.rect,new Point(0,0),null,null,true);
            }
         }
      }
      
      public function dispose() : void
      {
         _model = null;
         if(_window != null)
         {
            if(true)
            {
               _window.dispose();
            }
         }
         _window = null;
         var_770 = null;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function get partColor() : IPartColor
      {
         return var_770;
      }
   }
}
