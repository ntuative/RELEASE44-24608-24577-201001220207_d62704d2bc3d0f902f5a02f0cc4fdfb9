package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.visualization.furniture.data.ColorData;
   import com.sulake.habbo.room.object.visualization.furniture.data.LayerData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BlendMode;
   
   public class FurnitureVisualization extends RoomObjectSpriteVisualization
   {
      
      protected static const const_1374:Number = Math.sqrt(0.5);
       
      
      protected var _direction:int;
      
      protected var var_2228:int = -1;
      
      private var var_487:Array;
      
      private var var_2028:int = -1;
      
      protected var _data:FurnitureVisualizationData = null;
      
      protected var _alphaMultiplier:Number = 1;
      
      protected var _type:String = "";
      
      private var var_489:Array;
      
      protected var var_1475:String = null;
      
      private var var_488:Array;
      
      private var var_486:Array;
      
      private var var_2029:Number = 0;
      
      private var var_484:Array;
      
      private var var_1237:Boolean = true;
      
      private var var_565:Array;
      
      private var var_564:Array;
      
      private var var_2026:Number = 0;
      
      private var var_483:Array;
      
      private var var_485:Array;
      
      private var var_482:Array;
      
      protected var var_2220:Number = NaN;
      
      private var var_2027:int = -1;
      
      public function FurnitureVisualization()
      {
         var_564 = [];
         var_565 = [];
         var_489 = [];
         var_483 = [];
         var_482 = [];
         var_486 = [];
         var_487 = [];
         var_485 = [];
         var_488 = [];
         var_484 = [];
         super();
         reset();
      }
      
      protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(false)
         {
            return var_485[param1];
         }
         if(_data == null)
         {
            return LayerData.const_346;
         }
         var _loc4_:Number = _data.getZOffset(param1,param2,param3);
         var_485[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteAssetName(param1:int, param2:Number) : String
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(_data == null)
         {
            return "";
         }
         var _loc3_:String = "null";
         var _loc4_:Boolean = false;
         if(_loc3_ == null || _loc3_.length == 0)
         {
            _loc5_ = _data.getSize(param2);
            _loc3_ = _type;
            _loc6_ = "";
            if(param1 < spriteCount - 1)
            {
               _loc6_ = String.fromCharCode("a".charCodeAt() + param1);
            }
            else
            {
               _loc6_ = "sd";
            }
            if(_loc5_ == 1)
            {
               _loc3_ += "_icon_" + _loc6_;
               _loc4_ = false;
            }
            else
            {
               _loc3_ += "_" + _loc5_ + "_" + _loc6_ + "_" + _direction;
               _loc4_ = true;
            }
            var_564[param1] = _loc3_;
            var_565[param1] = _loc4_;
         }
         if(_loc4_)
         {
            _loc7_ = getFrameNumber(param1,param2);
            _loc3_ += "_" + _loc7_;
         }
         return _loc3_;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is FurnitureVisualizationData))
         {
            return false;
         }
         _data = param1 as FurnitureVisualizationData;
         _type = _data.getType();
         return true;
      }
      
      protected function getSpriteInk(param1:int, param2:int, param3:int) : int
      {
         if(false)
         {
            return var_484[param1];
         }
         if(_data == null)
         {
            return LayerData.const_410;
         }
         var _loc4_:int = _data.getInk(param1,_direction,param3);
         var_484[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(false)
         {
            return var_487[param1];
         }
         if(_data == null)
         {
            return LayerData.const_364;
         }
         var _loc4_:int = _data.getYOffset(param1,param2,param3);
         var_487[param1] = _loc4_;
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _data = null;
         var_564 = null;
         var_565 = null;
         var_489 = null;
         var_483 = null;
         var_482 = null;
         var_486 = null;
         var_487 = null;
         var_485 = null;
         var_488 = null;
         var_484 = null;
      }
      
      protected function getSpriteMouseCapture(param1:int, param2:int, param3:int) : Boolean
      {
         if(false)
         {
            return var_488[param1];
         }
         if(_data == null)
         {
            return true;
         }
         var _loc4_:* = !_data.getIgnoreMouse(param1,_direction,param3);
         var_488[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function updateAnimation(param1:Number) : Boolean
      {
         return false;
      }
      
      protected function updateSprites(param1:int, param2:Number) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = NaN;
         var _loc10_:int = 0;
         if(_data == null)
         {
            return;
         }
         var _loc3_:int = _data.getLayerCount(param1) + 1;
         if(_loc3_ != spriteCount)
         {
            createSprites(_loc3_);
         }
         updateAssetNameCache(_direction,param1);
         updateSpriteValueCache(_direction,param1);
         var _loc4_:Boolean = false;
         if(var_1475 != null && var_1475.indexOf("http") == 0)
         {
            _loc4_ = true;
         }
         var _loc5_:int = spriteCount - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = getSpriteAssetName(_loc5_,param1);
            _loc7_ = getSprite(_loc5_);
            if(_loc7_ != null)
            {
               _loc8_ = null;
               if(assetCollection != null)
               {
                  _loc8_ = assetCollection.getAsset(_loc6_);
               }
               if(_loc8_ != null)
               {
                  _loc7_.visible = true;
                  _loc7_.asset = _loc8_.asset;
                  _loc7_.flipH = _loc8_.flipH;
                  _loc7_.flipV = _loc8_.flipV;
                  _loc7_.offsetX = _loc8_.offsetX;
                  _loc7_.offsetY = _loc8_.offsetY;
                  _loc9_ = 0;
                  if(_loc5_ < spriteCount - 1)
                  {
                     _loc7_.tag = getSpriteTag(_loc5_,_direction,param1);
                     _loc7_.alpha = getSpriteAlpha(_loc5_,_direction,param1);
                     _loc7_.color = getSpriteColor(_loc5_,var_2228,param1);
                     _loc7_.offsetX += getSpriteXOffset(_loc5_,_direction,param1);
                     _loc7_.offsetY += getSpriteYOffset(_loc5_,_direction,param1);
                     _loc7_.capturesMouse = getSpriteMouseCapture(_loc5_,_direction,param1);
                     _loc7_.blendMode = getBlendMode(getSpriteInk(_loc5_,_direction,param1));
                     _loc9_ = Number(getSpriteZOffset(_loc5_,_direction,param1));
                     _loc9_ -= _loc5_ * 0.001;
                  }
                  else
                  {
                     _loc10_ = 96;
                     _loc10_ *= _alphaMultiplier;
                     _loc7_.alpha = _loc10_;
                     _loc7_.capturesMouse = false;
                     _loc9_ = 1;
                  }
                  _loc9_ *= param2;
                  _loc7_.relativeDepth = _loc9_;
                  _loc7_.assetName = _loc6_;
                  _loc7_.clickHandling = _loc4_;
               }
               else
               {
                  _loc7_.asset = null;
                  _loc7_.assetName = "";
                  _loc7_.tag = "";
                  _loc7_.flipH = false;
                  _loc7_.flipV = false;
                  _loc7_.offsetX = 0;
                  _loc7_.offsetY = 0;
                  _loc7_.relativeDepth = 0;
                  _loc7_.clickHandling = false;
               }
            }
            _loc5_--;
         }
         var_1237 = false;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc4_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         if(_data == null)
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:Number = param1.scale;
         if(updateObject(_loc3_,param1.direction.x))
         {
            _loc2_ = true;
         }
         if(updateModel(_loc3_))
         {
            _loc2_ = true;
         }
         if(updateAnimation(_loc3_))
         {
            _loc2_ = true;
         }
         if(_loc2_ || var_212 != _loc3_)
         {
            _loc4_ = const_1374;
            updateSprites(_loc3_,_loc4_);
            var_212 = _loc3_;
         }
      }
      
      override protected function reset() : void
      {
         super.reset();
         _direction = -1;
         _data = null;
         var_564 = [];
         var_565 = [];
         var_489 = [];
         var_483 = [];
         var_482 = [];
         var_486 = [];
         var_487 = [];
         var_485 = [];
         var_488 = [];
         var_484 = [];
         this.createSprites(0);
      }
      
      protected function getBlendMode(param1:int) : String
      {
         var _loc2_:String = "null";
         switch(param1)
         {
            case LayerData.const_1000:
               _loc2_ = "null";
               break;
            case LayerData.INK_DARKEN:
               _loc2_ = "null";
               break;
            case LayerData.const_862:
               _loc2_ = "null";
         }
         return _loc2_;
      }
      
      private function updateAssetNameCache(param1:int, param2:Number) : void
      {
         var _loc3_:int = 0;
         if(var_2028 != param1 || var_2026 != param2)
         {
            _loc3_ = spriteCount - 1;
            while(_loc3_ >= 0)
            {
               var_564[_loc3_] = "";
               var_565[_loc3_] = false;
               _loc3_--;
            }
            var_2028 = param1;
            var_2026 = param2;
         }
      }
      
      protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         if(false && !var_1237)
         {
            return var_483[param1];
         }
         if(_data == null)
         {
            return LayerData.const_363;
         }
         var _loc4_:int = _data.getAlpha(param1,param2,param3);
         _loc4_ *= _alphaMultiplier;
         var_483[param1] = _loc4_;
         return _loc4_;
      }
      
      private function updateSpriteValueCache(param1:int, param2:Number) : void
      {
         var _loc3_:int = 0;
         if(var_2027 != param1 || var_2029 != param2)
         {
            _loc3_ = spriteCount - 1;
            while(_loc3_ >= 0)
            {
               var_489[_loc3_] = null;
               var_483[_loc3_] = null;
               var_482[_loc3_] = null;
               var_486[_loc3_] = null;
               var_487[_loc3_] = null;
               var_485[_loc3_] = null;
               var_488[_loc3_] = null;
               var_484[_loc3_] = null;
               _loc3_--;
            }
            var_2027 = param1;
            var_2029 = param2;
         }
      }
      
      protected function getSpriteTag(param1:int, param2:int, param3:int) : String
      {
         if(false)
         {
            return var_489[param1];
         }
         if(_data == null)
         {
            return "";
         }
         var _loc4_:String = _data.getTag(param1,_direction,param3);
         var_489[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:* = NaN;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         if(var_166 != _loc3_.getUpdateID())
         {
            var_2228 = _loc3_.getNumber(RoomObjectVariableEnum.const_202);
            _loc4_ = Number(_loc3_.getNumber(RoomObjectVariableEnum.const_214));
            if(isNaN(_loc4_))
            {
               _loc4_ = 1;
            }
            if(_loc4_ != _alphaMultiplier)
            {
               _alphaMultiplier = _loc4_;
               var_1237 = true;
            }
            var_1475 = _loc3_.getString(RoomObjectVariableEnum.const_313);
            var_166 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = object;
         if(_loc3_ == null)
         {
            return false;
         }
         if(var_286 != _loc3_.getUpdateID() || param1 != var_212 || param2 != var_2220)
         {
            _loc4_ = _loc3_.getDirection().x - (param2 + 135);
            _loc4_ = (_loc4_ % 360 + 360) % 360;
            _loc5_ = _data.getDirectionValue(_loc4_,param1);
            _direction = _loc5_;
            var_286 = _loc3_.getUpdateID();
            var_2220 = param2;
            return true;
         }
         return false;
      }
      
      protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(false)
         {
            return var_486[param1];
         }
         if(_data == null)
         {
            return LayerData.const_428;
         }
         var _loc4_:int = _data.getXOffset(param1,param2,param3);
         var_486[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(false)
         {
            return var_482[param1];
         }
         if(_data == null)
         {
            return ColorData.const_65;
         }
         var _loc4_:int = _data.getColor(param1,param2,param3);
         var_482[param1] = _loc4_;
         return _loc4_;
      }
      
      protected function getFrameNumber(param1:int, param2:int) : int
      {
         return 0;
      }
   }
}
