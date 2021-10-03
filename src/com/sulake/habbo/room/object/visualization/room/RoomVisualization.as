package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
   import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
   import com.sulake.habbo.room.object.RoomPlaneData;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class RoomVisualization extends RoomObjectSpriteVisualization
   {
      
      public static const const_1330:int = 13421772;
      
      private static const const_1039:int = 16777215;
      
      public static const const_1215:int = 10066329;
      
      private static const const_1038:int = 13421772;
      
      public static const const_1219:int = 16777215;
      
      private static const const_1387:int = 0;
      
      public static const const_1205:int = 16777215;
      
      private static const const_1041:int = 10066329;
      
      private static const const_1040:int = 10066329;
      
      public static const const_1291:int = 13421772;
       
      
      private var var_1384:int = 0;
      
      private var var_1243:String = null;
      
      protected var _data:RoomVisualizationData = null;
      
      private var _assetLibrary:AssetLibrary = null;
      
      private var var_1727:int = -1000;
      
      private var var_932:uint = 16777215;
      
      private var var_1241:String = null;
      
      private var var_1728:Boolean = true;
      
      private var var_1112:int = -1;
      
      private var var_108:Array;
      
      private var var_1725:Boolean = false;
      
      private var var_1726:String = null;
      
      private const const_1600:int = 250;
      
      private var var_85:RoomPlaneParser = null;
      
      private var var_1700:Number = 0;
      
      private var var_1704:Number = 0;
      
      private var var_922:Number = 0;
      
      private var _floorType:String = null;
      
      private var _planeMaskParser:RoomPlaneBitmapMaskParser = null;
      
      private var var_1702:Number = 0;
      
      public function RoomVisualization()
      {
         var_108 = [];
         super();
         _assetLibrary = new AssetLibrary("room visualization");
         var_85 = new RoomPlaneParser();
         _planeMaskParser = new RoomPlaneBitmapMaskParser();
         Randomizer.setSeed(123);
         Randomizer.setSeed(124);
      }
      
      private function getLandscapeHeight() : Number
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_85.planeCount)
         {
            _loc3_ = var_85.getPlaneType(_loc2_);
            if(_loc3_ == RoomPlaneData.const_244)
            {
               _loc4_ = var_85.getPlaneRightSide(_loc2_);
               if(_loc4_.length > _loc1_)
               {
                  _loc1_ = Number(_loc4_.length);
               }
            }
            _loc2_++;
         }
         if(_loc1_ > 5)
         {
            _loc1_ = 5;
         }
         return _loc1_;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is RoomVisualizationData))
         {
            return false;
         }
         _data = param1 as RoomVisualizationData;
         _data.initializeAssetCollection(assetCollection);
         return true;
      }
      
      protected function initializeRoomPlanes() : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         if(var_1725)
         {
            return;
         }
         var _loc1_:IRoomObject = object;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = _loc1_.getModel().getString(RoomObjectVariableEnum.const_807);
         if(!var_85.initializeFromXML(new XML(_loc2_)))
         {
            return;
         }
         var _loc3_:Number = getLandscapeWidth();
         var _loc4_:Number = getLandscapeHeight();
         var _loc5_:* = 0;
         var _loc6_:int = _loc1_.getModel().getNumber(RoomObjectVariableEnum.const_999);
         var _loc7_:int = 0;
         while(_loc7_ < var_85.planeCount)
         {
            _loc8_ = var_85.getPlaneLocation(_loc7_);
            _loc9_ = var_85.getPlaneLeftSide(_loc7_);
            _loc10_ = var_85.getPlaneRightSide(_loc7_);
            _loc11_ = var_85.getPlaneSecondaryNormals(_loc7_);
            _loc12_ = var_85.getPlaneType(_loc7_);
            _loc13_ = null;
            if(!(_loc8_ != null && _loc9_ != null && _loc10_ != null))
            {
               return;
            }
            _loc14_ = Vector3d.crossProduct(_loc9_,_loc10_);
            _loc6_ = _loc6_ * 7613 + 517;
            _loc13_ = null;
            if(_loc12_ == RoomPlaneData.const_132)
            {
               _loc13_ = new RoomPlane(_loc1_.getLocation(),_loc8_,_loc9_,_loc10_,RoomPlane.const_175,true,_loc11_,_loc6_);
               if(_loc14_.z != 0)
               {
                  _loc13_.color = const_1219;
               }
               else
               {
                  _loc13_.color = const_1330;
               }
               if(_loc9_.length < 1 || _loc10_.length < 1)
               {
                  _loc13_.hasTexture = false;
               }
               if(_data != null)
               {
                  _loc13_.rasterizer = _data.floorRasterizer;
               }
            }
            else if(_loc12_ == RoomPlaneData.const_143)
            {
               _loc13_ = new RoomPlane(_loc1_.getLocation(),_loc8_,_loc9_,_loc10_,RoomPlane.const_262,true,_loc11_,_loc6_);
               if(_loc9_.length < 1 || _loc10_.length < 1)
               {
                  _loc13_.hasTexture = false;
               }
               if(_loc14_.x == 0 && _loc14_.y == 0)
               {
                  _loc13_.color = const_1040;
               }
               else if(_loc14_.y > 0)
               {
                  _loc13_.color = const_1039;
               }
               else if(_loc14_.y == 0)
               {
                  _loc13_.color = const_1038;
               }
               else
               {
                  _loc13_.color = const_1041;
               }
               if(_data != null)
               {
                  _loc13_.rasterizer = _data.wallRasterizer;
               }
            }
            else if(_loc12_ == RoomPlaneData.const_244)
            {
               _loc13_ = new RoomPlane(_loc1_.getLocation(),_loc8_,_loc9_,_loc10_,RoomPlane.const_176,true,_loc11_,_loc6_,_loc5_,0,_loc3_,_loc4_);
               if(_loc14_.y > 0)
               {
                  _loc13_.color = const_1205;
               }
               else if(_loc14_.y == 0)
               {
                  _loc13_.color = const_1291;
               }
               else
               {
                  _loc13_.color = const_1215;
               }
               if(_data != null)
               {
                  _loc13_.rasterizer = _data.landscapeRasterizer;
               }
               _loc5_ += _loc9_.length;
            }
            if(_loc13_ != null)
            {
               _loc13_.maskManager = _data.maskManager;
               _loc15_ = 0;
               while(_loc15_ < var_85.getPlaneMaskCount(_loc7_))
               {
                  _loc16_ = var_85.getPlaneMaskLeftSideLoc(_loc7_,_loc15_);
                  _loc17_ = var_85.getPlaneMaskRightSideLoc(_loc7_,_loc15_);
                  _loc18_ = var_85.getPlaneMaskLeftSideLength(_loc7_,_loc15_);
                  _loc19_ = var_85.getPlaneMaskRightSideLength(_loc7_,_loc15_);
                  _loc13_.addRectangleMask(_loc16_,_loc17_,_loc18_,_loc19_);
                  _loc15_++;
               }
               var_108.push(_loc13_);
            }
            _loc7_++;
         }
         var_1725 = true;
         defineSprites();
      }
      
      protected function defineSprites() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:int = 0;
         createSprites(_loc1_ + 1);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = var_108[_loc2_] as RoomPlane;
            _loc4_ = getSprite(1 + _loc2_);
            if(_loc4_ != null && _loc3_ != null && _loc3_.leftSide != null && _loc3_.rightSide != null)
            {
               if(_loc3_.type == RoomPlane.const_262 && (_loc3_.leftSide.length < 1 || _loc3_.rightSide.length < 1))
               {
                  _loc4_.capturesMouse = false;
               }
               else
               {
                  _loc4_.capturesMouse = true;
               }
               _loc4_.tag = "plane@" + (_loc2_ + 1);
            }
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         super.dispose();
         if(_assetLibrary != null)
         {
            _assetLibrary.dispose();
            _assetLibrary = null;
         }
         if(var_108 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_108.length)
            {
               _loc2_ = var_108[_loc1_] as RoomPlane;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_108 = null;
         }
         if(var_85 != null)
         {
            var_85.dispose();
            var_85 = null;
         }
         if(_planeMaskParser != null)
         {
            _planeMaskParser.dispose();
            _planeMaskParser = null;
         }
      }
      
      public function get floorRelativeDepth() : Number
      {
         return 100.1;
      }
      
      public function get wallRelativeDepth() : Number
      {
         return 100.5;
      }
      
      protected function updatePlaneMasks(param1:String) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XML = XML(param1);
         _planeMaskParser.initialize(_loc2_);
         var _loc3_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < var_108.length)
         {
            _loc3_ = var_108[_loc4_] as RoomPlane;
            if(_loc3_ != null)
            {
               _loc3_.resetBitmapMasks();
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _planeMaskParser.maskCount)
         {
            _loc6_ = _planeMaskParser.getMaskType(_loc5_);
            _loc7_ = _planeMaskParser.getMaskLocation(_loc5_);
            _loc8_ = _planeMaskParser.getMaskCategory(_loc5_);
            if(_loc7_ != null)
            {
               _loc9_ = 0;
               while(_loc9_ < var_108.length)
               {
                  _loc3_ = var_108[_loc9_] as RoomPlane;
                  if(_loc3_.type == RoomPlane.const_262 || _loc3_.type == RoomPlane.const_176 && _loc8_ == RoomPlaneBitmapMaskData.const_206)
                  {
                     if(_loc3_ != null && _loc3_.location != null && _loc3_.normal != null)
                     {
                        _loc10_ = Vector3d.dif(_loc7_,_loc3_.location);
                        _loc11_ = Math.abs(Vector3d.scalarProjection(_loc10_,_loc3_.normal));
                        if(_loc11_ < 0.01)
                        {
                           if(_loc3_.leftSide != null && _loc3_.rightSide != null)
                           {
                              _loc12_ = Vector3d.scalarProjection(_loc10_,_loc3_.leftSide);
                              _loc13_ = Vector3d.scalarProjection(_loc10_,_loc3_.rightSide);
                              _loc3_.addBitmapMask(_loc6_,_loc12_,_loc13_);
                           }
                        }
                     }
                  }
                  _loc9_++;
               }
            }
            _loc5_++;
         }
      }
      
      protected function updatePlanes(param1:IRoomGeometry, param2:Boolean) : void
      {
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc3_:IRoomObject = object;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         ++var_1384;
         var _loc4_:int = getTimer();
         var _loc5_:int = 0;
         while(_loc5_ < var_108.length)
         {
            _loc6_ = null;
            _loc7_ = false;
            _loc8_ = var_108[_loc5_] as RoomPlane;
            if(_loc8_ != null)
            {
               if(_loc8_.update(param1,_loc4_,param2))
               {
                  if(_loc8_.visible)
                  {
                     _loc10_ = "plane " + _loc5_ + " " + param1.scale;
                     _loc6_ = _assetLibrary.getAssetByName(_loc10_) as BitmapDataAsset;
                     if(_loc6_ == null)
                     {
                        _loc6_ = new BitmapDataAsset(_assetLibrary.getAssetTypeDeclarationByClass(BitmapDataAsset));
                        _assetLibrary.setAsset(_loc10_,_loc6_);
                     }
                     _loc11_ = _loc6_.content as BitmapData;
                     _loc12_ = _loc8_.copyBitmapData(_loc11_);
                     if(_loc12_ == null)
                     {
                        _loc12_ = _loc8_.bitmapData;
                     }
                     if(_loc12_ == null)
                     {
                        _loc6_ = null;
                     }
                     else if(_loc11_ != _loc12_)
                     {
                        if(_loc11_ != null)
                        {
                           _loc11_.dispose();
                        }
                        else
                        {
                           _loc13_ = 1;
                        }
                        _loc6_.setUnknownContent(_loc12_);
                     }
                  }
                  _loc7_ = true;
               }
            }
            else
            {
               _loc6_ = null;
            }
            _loc9_ = getSprite(1 + _loc5_);
            if(_loc9_ != null)
            {
               if(_loc8_ != null)
               {
                  _loc9_.visible = _loc8_.visible;
                  if(_loc9_.visible)
                  {
                     _loc14_ = _loc8_.offset;
                     _loc9_.offsetX = -_loc14_.x;
                     _loc9_.offsetY = -_loc14_.y;
                     _loc9_.color = _loc8_.color;
                     if(_loc7_)
                     {
                        _loc9_.asset = _loc6_;
                        _loc9_.assetName = _loc10_ + "_" + var_1384;
                     }
                     if(var_85.getPlaneType(_loc5_) == RoomPlaneData.const_132)
                     {
                        _loc9_.relativeDepth = _loc8_.relativeDepth + floorRelativeDepth + Number(_loc5_) / 1000;
                     }
                     else
                     {
                        _loc9_.relativeDepth = _loc8_.relativeDepth + wallRelativeDepth + Number(_loc5_) / 1000;
                     }
                  }
               }
               else
               {
                  _loc9_.visible = false;
               }
            }
            _loc5_++;
         }
      }
      
      private function getLandscapeWidth() : Number
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_85.planeCount)
         {
            _loc3_ = var_85.getPlaneType(_loc2_);
            if(_loc3_ == RoomPlaneData.const_244)
            {
               _loc4_ = var_85.getPlaneLeftSide(_loc2_);
               _loc1_ += _loc4_.length;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function update(param1:IRoomGeometry = null) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(param1.updateId != var_1112)
         {
            var_1112 = param1.updateId;
            _loc8_ = param1.direction;
            if(_loc8_ != null && (_loc8_.x != var_922 || _loc8_.y != var_1700 || _loc8_.z != var_1704 || param1.scale != var_1702))
            {
               var_922 = _loc8_.x;
               var_1700 = _loc8_.y;
               var_1704 = _loc8_.z;
               var_1702 = param1.scale;
               _loc3_ = true;
            }
         }
         var _loc5_:IRoomObjectModel = _loc2_.getModel();
         initializeRoomPlanes();
         if(var_166 != _loc5_.getUpdateID())
         {
            _loc9_ = _loc5_.getString(RoomObjectVariableEnum.const_912);
            if(_loc9_ != var_1726)
            {
               updatePlaneMasks(_loc9_);
               var_1726 = _loc9_;
               _loc4_ = true;
            }
            _loc10_ = uint(_loc5_.getNumber(RoomObjectVariableEnum.const_519));
            if(_loc10_ != var_932)
            {
               var_932 = _loc10_;
               _loc4_ = true;
            }
         }
         var _loc6_:int = getTimer();
         if(_loc6_ < var_1727 + const_1600 && !_loc3_ && !_loc4_)
         {
            return;
         }
         var_1727 = _loc6_;
         if(var_166 != _loc5_.getUpdateID())
         {
            _loc11_ = _loc5_.getString(RoomObjectVariableEnum.const_511);
            _loc12_ = _loc5_.getString(RoomObjectVariableEnum.const_676);
            _loc13_ = _loc5_.getString(RoomObjectVariableEnum.const_535);
            updatePlaneTextureTypes(_loc12_,_loc11_,_loc13_);
            var_1728 = Boolean(_loc5_.getNumber(RoomObjectVariableEnum.const_831));
            var_166 = _loc5_.getUpdateID();
         }
         updatePlanes(param1,_loc3_);
         var _loc7_:int = 0;
         while(_loc7_ < var_108.length)
         {
            _loc14_ = getSprite(1 + _loc7_);
            _loc15_ = var_108[_loc7_] as RoomPlane;
            if(_loc14_ != null && _loc15_ != null && _loc15_.type != RoomPlane.const_176)
            {
               _loc16_ = uint(_loc15_.color);
               if(var_1728)
               {
                  _loc17_ = uint((_loc16_ & 255) * (var_932 & 255) / 255);
                  _loc18_ = uint((_loc16_ >> 8 & 255) * (var_932 >> 8 & 255) / 255);
                  _loc19_ = uint((_loc16_ >> 16 & 255) * (var_932 >> 16 & 255) / 255);
                  _loc20_ = uint(_loc16_ >> 24);
                  _loc16_ = uint((_loc20_ << 24) + (_loc19_ << 16) + (_loc18_ << 8) + _loc17_);
               }
               _loc14_.color = _loc16_;
            }
            _loc7_++;
         }
      }
      
      protected function updatePlaneTextureTypes(param1:String, param2:String, param3:String) : Boolean
      {
         var _loc5_:* = null;
         if(param1 != _floorType)
         {
            _floorType = param1;
         }
         else
         {
            param1 = null;
         }
         if(param2 != var_1243)
         {
            var_1243 = param2;
         }
         else
         {
            param2 = null;
         }
         if(param3 != var_1241)
         {
            var_1241 = param3;
         }
         else
         {
            param3 = null;
         }
         if(param1 == null && param2 == null && param3 == null)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(_loc4_ < var_108.length)
         {
            _loc5_ = var_108[_loc4_] as RoomPlane;
            if(_loc5_ != null)
            {
               if(_loc5_.type == RoomPlane.const_175 && param1 != null)
               {
                  _loc5_.id = param1;
               }
               else if(_loc5_.type == RoomPlane.const_262 && param2 != null)
               {
                  _loc5_.id = param2;
               }
               else if(_loc5_.type == RoomPlane.const_176 && param3 != null)
               {
                  _loc5_.id = param3;
               }
            }
            _loc4_++;
         }
         return true;
      }
   }
}
