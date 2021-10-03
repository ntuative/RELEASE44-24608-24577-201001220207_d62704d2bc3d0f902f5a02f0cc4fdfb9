package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SpacesCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener
   {
      
      private static const const_176:String = "landscape";
      
      private static const const_175:String = "floor";
      
      private static const const_177:String = "wallpaper";
       
      
      private var var_1243:String = "HabboAvatarRenderLib_HabboAvatarPetFigure";
      
      private var var_1220:Array;
      
      private var var_998:BitmapData = null;
      
      private var var_230:int = 0;
      
      private var var_677:int = 0;
      
      private var var_1241:String = "1.1";
      
      private var var_2005:int = -1;
      
      private var var_2004:int = -1;
      
      private var var_834:Array;
      
      private var var_676:int = 0;
      
      private var var_999:BitmapData = null;
      
      private var var_301:int = 0;
      
      private var var_675:int = 0;
      
      private var var_299:int = 0;
      
      private var var_270:int = 0;
      
      private var _activeWallpaperPatterns:Array;
      
      private var _floorType:String = "HabboAvatarRenderLib_HabboAvatarPetFigure";
      
      private var var_835:Array;
      
      private var var_1219:Array;
      
      private var var_271:int = 0;
      
      private var var_180:XML;
      
      private var var_1221:Array;
      
      private var var_300:int = 0;
      
      public function SpacesCatalogWidget(param1:IWindowContainer)
      {
         var_1221 = [];
         _activeWallpaperPatterns = [];
         var_1220 = [];
         var_835 = [];
         var_1219 = [];
         var_834 = [];
         super(param1);
      }
      
      private function setRoomImage(param1:BitmapData, param2:BitmapData) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc3_:Point = new Point(param1.width / 2 + 4 + 19,param1.height / 2 - param2.height / 2 - 24 + 10);
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,param1.transparent);
         _loc4_.copyPixels(param1,param1.rect,new Point(0,0),null,null,true);
         _loc4_.copyPixels(param2,param2.rect,_loc3_,null,null,true);
         var _loc5_:IBitmapWrapperWindow = window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow;
         if(_loc5_ != null)
         {
            if(_loc5_.bitmap == null)
            {
               _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
            }
            _loc5_.bitmap.fillRect(_loc5_.bitmap.rect,16777215);
            _loc6_ = (_loc5_.width - _loc4_.width) / 2;
            _loc7_ = (_loc5_.height - _loc4_.height) / 2;
            _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(_loc6_,_loc7_),null,null,true);
            _loc5_.invalidate();
         }
      }
      
      private function changeColor(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case const_177:
               var_230 += param2;
               if(var_230 < 0)
               {
                  if(var_675 > 0)
                  {
                     var_230 = var_675 - 1;
                  }
                  else
                  {
                     var_230 = 0;
                  }
               }
               if(var_230 >= var_675)
               {
                  var_230 = 0;
               }
               break;
            case const_175:
               var_270 += param2;
               if(var_270 < 0)
               {
                  if(var_676 > 0)
                  {
                     var_270 = var_676 - 1;
                  }
                  else
                  {
                     var_270 = 0;
                  }
               }
               if(var_270 >= var_676)
               {
                  var_270 = 0;
               }
               break;
            case const_176:
               var_271 += param2;
               if(var_271 < 0)
               {
                  if(var_677 > 0)
                  {
                     var_271 = var_677 - 1;
                  }
                  else
                  {
                     var_271 = 0;
                  }
               }
               if(var_271 >= var_677)
               {
                  var_271 = 0;
               }
         }
      }
      
      override public function init() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         super.init();
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("configuration_catalog_spaces") as XmlAsset;
         if(_loc1_ != null)
         {
            var_180 = _loc1_.content as XML;
            for each(_loc2_ in page.offers)
            {
               _loc4_ = _loc2_.productContainer.firstProduct;
               _loc5_ = _loc2_.localizationId;
               _loc6_ = _loc5_.split(" ")[0];
               _loc7_ = _loc5_.split(" ")[1];
               _loc8_ = false;
               switch(_loc4_.furnitureData.name)
               {
                  case "floor":
                     for each(_loc9_ in var_180.floors.pattern)
                     {
                        var_835.push(String(_loc9_.@id));
                        var_1220.push(_loc2_);
                     }
                     break;
                  case "wallpaper":
                     for each(_loc10_ in var_180.walls.pattern)
                     {
                        if(_loc10_.@id == _loc7_)
                        {
                           _activeWallpaperPatterns.push(_loc7_);
                           _loc8_ = true;
                        }
                     }
                     if(_loc8_)
                     {
                        var_1221.push(_loc2_);
                     }
                     else
                     {
                        Logger.log("[SpacesCatalogWidget] Could not find wallpaper pattern configuration! " + [_loc2_.localizationId,_loc4_.furnitureData.name]);
                     }
                     break;
                  case "landscape":
                     for each(_loc11_ in var_180.landscapes.pattern)
                     {
                        if(_loc11_.@id == _loc7_)
                        {
                           var_834.push(_loc7_);
                           _loc8_ = true;
                        }
                     }
                     if(_loc8_)
                     {
                        var_1219.push(_loc2_);
                     }
                     else
                     {
                        Logger.log("[SpacesCatalogWidget] Could not find landscape pattern configuration! " + [_loc2_.localizationId,_loc4_.furnitureData.name]);
                     }
                     break;
                  default:
                     Logger.log("[SpacesCatalogWidget] : " + _loc4_.furnitureData.name);
                     break;
               }
            }
            _loc3_ = 0;
            while(_loc3_ < _window.numChildren)
            {
               _loc12_ = _window.getChildAt(_loc3_);
               if(_loc12_ is IButtonWindow)
               {
                  _loc12_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onClick);
               }
               _loc3_++;
            }
            changePattern(const_177,0);
            changePattern(const_176,0);
            changePattern(const_175,0);
            updateConfiguration();
            retrieveSpacesPreview();
            return;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         switch(param1)
         {
            case var_2004:
               var_998 = param2;
               break;
            case var_2005:
               var_999 = param2;
         }
         if(var_998 != null && var_999 != null)
         {
            setRoomImage(var_998,var_999);
         }
      }
      
      private function updateConfiguration() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc2_:String = "null";
         for each(_loc1_ in var_180.walls.pattern)
         {
            if(_loc1_.@id == _loc2_)
            {
               if(var_230 >= 0)
               {
                  _loc9_ = _loc1_.children()[var_230];
                  if(_loc9_ != null)
                  {
                     var_1243 = _loc9_.@id;
                  }
               }
            }
         }
         _loc3_ = var_1221[var_301];
         _loc4_ = (page.viewer.catalog as HabboCatalog).localization;
         if(_loc3_ != null)
         {
            _loc10_ = _window.findChildByName("ctlg_wall_price") as ITextWindow;
            if(_loc10_ != null)
            {
               _loc10_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc3_.priceInCredits));
            }
         }
         var _loc5_:String = "null";
         for each(_loc1_ in var_180.floors.pattern)
         {
            if(_loc1_.@id == _loc5_)
            {
               _loc11_ = _loc1_.children()[var_270];
               if(_loc11_ != null)
               {
                  _floorType = _loc11_.@id;
               }
            }
         }
         _loc6_ = var_1220[var_299];
         if(_loc6_ != null)
         {
            _loc12_ = _window.findChildByName("ctlg_floor_price") as ITextWindow;
            if(_loc12_ != null)
            {
               _loc12_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc6_.priceInCredits));
            }
         }
         var _loc7_:String = "null";
         for each(_loc1_ in var_180.landscapes.pattern)
         {
            if(_loc1_.@id == _loc7_)
            {
               _loc13_ = _loc1_.children()[var_271];
               if(_loc13_ != null)
               {
                  var_1241 = _loc13_.@id;
               }
            }
         }
         _loc8_ = var_1219[var_300];
         if(_loc8_ != null)
         {
            _loc14_ = _window.findChildByName("ctlg_landscape_price") as ITextWindow;
            if(_loc14_ != null)
            {
               _loc14_.caption = _loc4_.registerParameter("catalog.purchase.price.credits","credits",String(_loc8_.priceInCredits));
            }
         }
      }
      
      private function changePattern(param1:String, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         switch(param1)
         {
            case const_177:
               var_301 += param2;
               if(var_301 < 0)
               {
                  var_301 = -1;
               }
               if(var_301 == _activeWallpaperPatterns.length)
               {
                  var_301 = 0;
               }
               var_230 = 0;
               var_675 = 0;
               _loc5_ = "null";
               for each(_loc8_ in var_180.walls.pattern)
               {
                  if(_loc8_.@id == _loc5_)
                  {
                     var_675 = _loc8_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_wall_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_wall_color_next") as IButtonWindow;
               if(var_675 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
               break;
            case const_175:
               var_299 += param2;
               if(var_299 < 0)
               {
                  var_299 = -1;
               }
               if(var_299 >= var_835.length)
               {
                  var_299 = 0;
               }
               var_270 = 0;
               var_676 = 0;
               _loc6_ = "null";
               for each(_loc9_ in var_180.floors.pattern)
               {
                  if(_loc9_.@id == _loc6_)
                  {
                     var_676 = _loc9_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_floor_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_floor_color_next") as IButtonWindow;
               if(var_676 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
               break;
            case const_176:
               var_300 += param2;
               if(var_300 < 0)
               {
                  var_300 = -1;
               }
               if(var_300 >= var_834.length)
               {
                  var_300 = 0;
               }
               var_271 = 0;
               var_677 = 0;
               _loc7_ = "null";
               for each(_loc10_ in var_180.landscapes.pattern)
               {
                  if(_loc10_.@id == _loc7_)
                  {
                     var_677 = _loc10_.children().length();
                  }
               }
               _loc4_ = _window.findChildByName("ctlg_landscape_color_prev") as IButtonWindow;
               _loc3_ = _window.findChildByName("ctlg_landscape_color_next") as IButtonWindow;
               if(var_677 < 2)
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.disable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.disable();
                  }
               }
               else
               {
                  if(_loc4_ != null)
                  {
                     _loc4_.enable();
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.enable();
                  }
               }
         }
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:IWindow = param1.target as IWindow;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.name)
         {
            case "ctlg_wall_pattern_prev":
               changePattern(const_177,-1);
               break;
            case "ctlg_wall_pattern_next":
               changePattern(const_177,1);
               break;
            case "ctlg_wall_color_prev":
               changeColor(const_177,-1);
               break;
            case "ctlg_wall_color_next":
               changeColor(const_177,1);
               break;
            case "ctlg_buy_wall":
               _loc3_ = var_1221[var_301];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page,var_1243);
               }
               break;
            case "ctlg_floor_pattern_prev":
               changePattern(const_175,-1);
               break;
            case "ctlg_floor_pattern_next":
               changePattern(const_175,1);
               break;
            case "ctlg_floor_color_prev":
               changeColor(const_175,-1);
               break;
            case "ctlg_floor_color_next":
               changeColor(const_175,1);
               break;
            case "ctlg_buy_floor":
               _loc3_ = var_1220[var_299];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page,_floorType);
               }
               break;
            case "ctlg_landscape_pattern_next":
               changePattern(const_176,-1);
               break;
            case "ctlg_landscape_pattern_prev":
               changePattern(const_176,1);
               break;
            case "ctlg_landscape_color_prev":
               changeColor(const_176,-1);
               break;
            case "ctlg_landscape_color_next":
               changeColor(const_176,1);
               break;
            case "ctlg_buy_landscape":
               _loc3_ = var_1219[var_300];
               if(_loc3_ != null)
               {
                  (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(_loc3_,page,var_1241);
               }
               break;
            default:
               Logger.log("Spaces, unknown button: " + _loc2_.name);
         }
         updateConfiguration();
         retrieveSpacesPreview();
      }
      
      private function retrieveSpacesPreview() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:ImageResult = page.viewer.roomEngine.getRoomImage(_floorType,var_1243,var_1241,64,this,"window_romantic_wide");
         var _loc3_:ImageResult = page.viewer.roomEngine.getGenericRoomObjectImage("window_romantic_wide","",new Vector3d(180,0,0),64,this,"window_romantic_wide");
         if(_loc2_ != null && _loc3_ != null)
         {
            var_2004 = _loc2_.id;
            var_2005 = _loc3_.id;
            _loc4_ = _loc2_.data as BitmapData;
            _loc5_ = _loc3_.data as BitmapData;
            if(_loc4_ != null && _loc5_ != null)
            {
               var_998 = _loc4_;
               var_999 = _loc5_;
               setRoomImage(_loc4_,_loc5_);
            }
         }
      }
   }
}
