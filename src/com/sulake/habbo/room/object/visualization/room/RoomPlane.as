package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomPlane
   {
      
      public static const const_175:int = 2;
      
      public static const const_1473:int = 0;
      
      public static const const_176:int = 3;
      
      public static const const_262:int = 1;
       
      
      private var var_438:Vector3d = null;
      
      private var var_686:Array;
      
      private var var_255:Vector3d = null;
      
      private var var_170:Map = null;
      
      private var _bitmapData:BitmapData = null;
      
      private var _type:int = 0;
      
      private var var_687:IPlaneRasterizer = null;
      
      private var var_760:Vector3d = null;
      
      private var _height:Number = 0;
      
      private var var_132:Vector3d = null;
      
      private var var_110:Vector3d = null;
      
      private var var_84:Vector3d = null;
      
      private var var_111:Vector3d = null;
      
      private var var_1703:Number = 0;
      
      private var var_205:Array;
      
      private var var_254:Vector3d = null;
      
      private var var_584:PlaneMaskManager = null;
      
      private var _isVisible:Boolean = true;
      
      private var _color:uint = 0;
      
      private var var_2048:Number = 0;
      
      private var var_2045:Number = 0;
      
      private var var_2047:int = 0;
      
      private var var_161:Boolean = false;
      
      private var var_78:Vector3d = null;
      
      private var _disposed:Boolean = false;
      
      private var var_67:BitmapData = null;
      
      private var var_2046:Number = 0;
      
      private var var_2049:Number = 0;
      
      private var var_1213:Array;
      
      private var _offset:Point = null;
      
      private var _id:String = null;
      
      private var var_1016:Array;
      
      private var var_1491:Boolean = true;
      
      private var _width:Number = 0;
      
      private var var_182:BitmapData = null;
      
      private var var_842:Boolean = false;
      
      private var var_272:Array;
      
      public function RoomPlane(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var_1213 = [];
         var_205 = [];
         var_272 = [];
         var_686 = [];
         var_1016 = [];
         super();
         var_2047 = param8;
         var_760 = new Vector3d();
         var_760.assign(param1);
         var_78 = new Vector3d();
         var_78.assign(param2);
         var_254 = new Vector3d();
         var_254.assign(param3);
         var_255 = new Vector3d();
         var_255.assign(param4);
         var_438 = Vector3d.crossProduct(var_254,var_255);
         if(false)
         {
            var_438.mul(Infinity);
         }
         if(param7 != null)
         {
            _loc13_ = 0;
            while(_loc13_ < param7.length)
            {
               _loc14_ = param7[_loc13_] as IVector3d;
               if(_loc14_ != null)
               {
                  _loc15_ = new Vector3d();
                  _loc15_.assign(_loc14_);
                  var_1213.push(_loc14_);
               }
               _loc13_++;
            }
         }
         _offset = new Point();
         _type = param5;
         var_170 = new Map();
         var_132 = new Vector3d();
         var_110 = new Vector3d();
         var_84 = new Vector3d();
         var_111 = new Vector3d();
         var_2046 = param9;
         var_2049 = param10;
         var_2048 = param11;
         var_2045 = param12;
         var_842 = param6;
      }
      
      public function resetRectangleMasks() : void
      {
         if(var_842)
         {
            if(false)
            {
               return;
            }
            var_161 = true;
            var_272 = [];
         }
      }
      
      private function resetTextureCache(param1:BitmapData = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(var_170 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_170.length)
            {
               _loc3_ = var_170.getWithIndex(_loc2_) as PlaneBitmapData;
               if(_loc3_ != null)
               {
                  if(_loc3_.bitmap != null && _loc3_.bitmap != param1)
                  {
                     _loc3_.bitmap.dispose();
                  }
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            var_170.reset();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(var_170 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_170.length)
            {
               _loc2_ = var_170.getWithIndex(_loc1_) as PlaneBitmapData;
               if(_loc2_ != null)
               {
                  if(_loc2_.bitmap != null)
                  {
                     _loc2_.bitmap.dispose();
                  }
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_170.dispose();
            var_170 = null;
         }
         var_78 = null;
         var_760 = null;
         var_254 = null;
         var_255 = null;
         var_438 = null;
         var_687 = null;
         var_132 = null;
         var_110 = null;
         var_84 = null;
         var_111 = null;
         var_205 = null;
         var_272 = null;
         if(var_67 != null)
         {
            var_67.dispose();
            var_67 = null;
         }
         if(var_182 != null)
         {
            var_182.dispose();
            var_182 = null;
         }
         _disposed = true;
      }
      
      public function get hasTexture() : Boolean
      {
         return var_1491;
      }
      
      public function set rasterizer(param1:IPlaneRasterizer) : void
      {
         var_687 = param1;
      }
      
      private function cacheTexture(param1:String, param2:PlaneBitmapData) : Boolean
      {
         var _loc3_:PlaneBitmapData = var_170.remove(param1) as PlaneBitmapData;
         if(_loc3_ != null)
         {
            if(param2 != null && param2.bitmap != _loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.dispose();
         }
         var_170.add(param1,param2);
         return true;
      }
      
      public function addBitmapMask(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(var_842)
         {
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < var_205.length)
            {
               _loc4_ = var_205[_loc5_] as RoomPlaneBitmapMask;
               if(_loc4_ != null)
               {
                  if(_loc4_.type == param1 && _loc4_.leftSideLoc == param2 && _loc4_.rightSideLoc == param3)
                  {
                     return false;
                  }
               }
               _loc5_++;
            }
            _loc4_ = new RoomPlaneBitmapMask(param1,param2,param3);
            var_205.push(_loc4_);
            var_161 = true;
            return true;
         }
         return false;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 != _id)
         {
            resetTextureCache();
            _id = param1;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set hasTexture(param1:Boolean) : void
      {
         var_1491 = param1;
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(_bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (_type == const_262 || _type == const_176))
            {
               _loc3_ = 0;
               _loc4_ = 0;
               _loc5_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  ++param2.ty;
               }
               _loc7_ = 0;
               while(_loc3_ < param1.width)
               {
                  _loc3_++;
                  _loc5_ += Math.abs(param2.b);
                  if(_loc5_ >= 1)
                  {
                     _bitmapData.copyPixels(param1,new Rectangle(_loc4_ + _loc6_,0,_loc3_ - _loc4_,param1.height),new Point(param2.tx + _loc4_,param2.ty + _loc7_),null,null,true);
                     _loc4_ = _loc3_;
                     if(param2.b > 0)
                     {
                        _loc7_++;
                     }
                     else
                     {
                        _loc7_--;
                     }
                     _loc5_ = 0;
                  }
               }
               if(_loc5_ > 0)
               {
                  _bitmapData.copyPixels(param1,new Rectangle(_loc4_,0,_loc3_ - _loc4_,param1.height),new Point(param2.tx + _loc4_,param2.ty + _loc7_),null,null,true);
               }
               return;
            }
            _bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
      
      public function set maskManager(param1:PlaneMaskManager) : void
      {
         var_584 = param1;
      }
      
      private function updateMask(param1:BitmapData, param2:IRoomGeometry) : void
      {
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(!var_842 || false && false && !var_161 || var_584 == null)
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         updateMaskChangeStatus();
         var _loc7_:Number = param1.width;
         var _loc8_:Number = param1.height;
         if(var_67 == null || var_67.width != _loc7_ || var_67.height != _loc8_)
         {
            if(var_67 != null)
            {
               var_67.dispose();
               var_67 = null;
            }
            var_67 = new BitmapData(_loc7_,_loc8_,true,16777215);
            var_161 = true;
         }
         if(var_161)
         {
            var_686 = [];
            var_1016 = [];
            if(var_67 != null)
            {
               var_67.fillRect(var_67.rect,16777215);
            }
            resetTextureCache(param1);
            _loc9_ = param2.getCoordinatePosition(var_438);
            _loc10_ = 0;
            _loc11_ = 0;
            _loc5_ = 0;
            while(_loc5_ < var_205.length)
            {
               _loc3_ = var_205[_loc5_] as RoomPlaneBitmapMask;
               if(_loc3_ != null)
               {
                  _loc10_ = 0 - 0 * _loc3_.leftSideLoc / 0;
                  _loc11_ = 0 - 0 * _loc3_.rightSideLoc / 0;
                  _loc12_ = _loc3_.type;
                  var_584.updateMask(var_67,_loc12_,param2.scale,_loc9_,_loc10_,_loc11_);
                  var_686.push(new RoomPlaneBitmapMask(_loc12_,_loc3_.leftSideLoc,_loc3_.rightSideLoc));
               }
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < var_272.length)
            {
               _loc4_ = var_272[_loc6_] as RoomPlaneRectangleMask;
               if(_loc4_ != null)
               {
                  _loc10_ = 0 - 0 * _loc4_.leftSideLoc / 0;
                  _loc11_ = 0 - 0 * _loc4_.rightSideLoc / 0;
                  _loc13_ = 0 * _loc4_.leftSideLength / 0;
                  _loc14_ = 0 * _loc4_.rightSideLength / 0;
                  var_67.fillRect(new Rectangle(_loc10_ - _loc13_,_loc11_ - _loc14_,_loc13_,_loc14_),4278190080);
                  var_1016.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength,_loc4_.rightSideLoc,_loc4_.leftSideLength,_loc4_.rightSideLength));
               }
               _loc6_++;
            }
            var_161 = false;
         }
         combineTextureMask(param1,var_67);
      }
      
      public function get relativeDepth() : Number
      {
         return var_1703;
      }
      
      public function resetBitmapMasks() : void
      {
         if(var_842)
         {
            if(false)
            {
               return;
            }
            var_161 = true;
            var_205 = [];
         }
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get visible() : Boolean
      {
         return _isVisible;
      }
      
      private function getTextureIdentifier(param1:Number) : String
      {
         if(var_687 != null)
         {
            return var_687.getTextureIdentifier(param1,normal);
         }
         return String(param1);
      }
      
      public function get bitmapData() : BitmapData
      {
         if(_isVisible)
         {
            if(_bitmapData != null)
            {
               return _bitmapData.clone();
            }
         }
         return null;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get rightSide() : IVector3d
      {
         return var_255;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(var_132 == null || var_110 == null || var_84 == null || var_111 == null || param2 == null || _bitmapData == null)
         {
            return;
         }
         var _loc3_:Number = 0 - 0;
         var _loc4_:Number = 0 - 0;
         var _loc5_:Number = 0 - 0;
         var _loc6_:Number = 0 - 0;
         if(_type == const_262 || _type == const_176)
         {
            if(Math.abs(_loc5_ - param2.width) <= 1)
            {
               _loc5_ = param2.width;
            }
            if(Math.abs(_loc6_ - param2.width) <= 1)
            {
               _loc6_ = param2.width;
            }
            if(Math.abs(_loc3_ - param2.height) <= 1)
            {
               _loc3_ = param2.height;
            }
            if(Math.abs(_loc4_ - param2.height) <= 1)
            {
               _loc4_ = param2.height;
            }
         }
         var _loc7_:Number = _loc5_ / param2.width;
         var _loc8_:Number = _loc6_ / param2.width;
         var _loc9_:Number = _loc3_ / param2.height;
         var _loc10_:Number = _loc4_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc7_;
         _loc11_.b = _loc8_;
         _loc11_.c = _loc9_;
         _loc11_.d = _loc10_;
         _loc11_.translate(var_84.x,var_84.y);
         draw(param2,_loc11_);
      }
      
      public function get location() : IVector3d
      {
         return var_78;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         var_132.assign(param1.getScreenPosition(var_78));
         var_110.assign(param1.getScreenPosition(Vector3d.sum(var_78,var_255)));
         var_84.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(var_78,var_254),var_255)));
         var_111.assign(param1.getScreenPosition(Vector3d.sum(var_78,var_254)));
         _offset = param1.getScreenPoint(var_760);
         var_132.x = Math.round(var_132.x);
         var_132.y = Math.round(var_132.y);
         var_110.x = Math.round(var_110.x);
         var_110.y = Math.round(var_110.y);
         var_84.x = Math.round(var_84.x);
         var_84.y = Math.round(var_84.y);
         var_111.x = Math.round(var_111.x);
         var_111.y = Math.round(var_111.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc2_:Number = Math.min(var_132.x,var_110.x,var_84.x,var_111.x);
         var _loc3_:Number = Math.max(var_132.x,var_110.x,var_84.x,var_111.x);
         var _loc4_:Number = Math.min(var_132.y,var_110.y,var_84.y,var_111.y);
         var _loc5_:Number = Math.max(var_132.y,var_110.y,var_84.y,var_111.y);
         _loc3_ -= _loc2_;
         _offset.x = 0 - _loc2_;
         var_132.x = 0 - _loc2_;
         var_110.x = 0 - _loc2_;
         var_84.x = 0 - _loc2_;
         var_111.x = 0 - _loc2_;
         _loc5_ -= _loc4_;
         _offset.y = 0 - _loc4_;
         var_132.y = 0 - _loc4_;
         var_110.y = 0 - _loc4_;
         var_84.y = 0 - _loc4_;
         var_111.y = 0 - _loc4_;
         _width = _loc3_;
         _height = _loc5_;
      }
      
      private function updateMaskChangeStatus() : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:* = null;
         if(!var_161)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:* = null;
         if(true)
         {
            while(_loc1_ < var_205.length)
            {
               _loc4_ = var_205[_loc1_] as RoomPlaneBitmapMask;
               if(_loc4_ != null)
               {
                  _loc6_ = false;
                  while(_loc2_ < var_686.length)
                  {
                     _loc7_ = var_686[_loc2_] as RoomPlaneBitmapMask;
                     if(_loc7_ != null)
                     {
                        if(_loc7_.type == _loc4_.type && _loc7_.leftSideLoc == _loc4_.leftSideLoc && _loc7_.rightSideLoc == _loc4_.rightSideLoc)
                        {
                           _loc6_ = true;
                           break;
                        }
                     }
                     _loc2_++;
                  }
                  if(!_loc6_)
                  {
                     _loc3_ = false;
                     break;
                  }
               }
               _loc1_++;
            }
         }
         else
         {
            _loc3_ = false;
         }
         if(false)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            var_161 = false;
         }
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function update(param1:IRoomGeometry, param2:int, param3:Boolean) : Boolean
      {
         var _loc4_:* = NaN;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null;
         if(param1 == null || _disposed)
         {
            return false;
         }
         if(param3)
         {
            _loc4_ = 0;
            _loc4_ = Number(Vector3d.cosAngle(param1.directionAxis,normal));
            if(_loc4_ > -0.001)
            {
               if(_isVisible)
               {
                  _isVisible = false;
                  return true;
               }
               return false;
            }
            _loc5_ = 0;
            while(_loc5_ < var_1213.length)
            {
               _loc4_ = Number(Vector3d.cosAngle(param1.directionAxis,var_1213[_loc5_]));
               if(_loc4_ > -0.001)
               {
                  if(_isVisible)
                  {
                     _isVisible = false;
                     return true;
                  }
                  return false;
               }
               _loc5_++;
            }
            updateCorners(param1);
            _loc6_ = param1.getScreenPosition(var_760);
            _loc7_ = _loc6_.z;
            _loc8_ = Math.max(0 - _loc7_,0 - _loc7_,0 - _loc7_,0 - _loc7_);
            if(_type == const_176)
            {
               _loc8_ += 0.02;
            }
            var_1703 = _loc8_;
            _isVisible = true;
         }
         if(needsNewTexture(param1,param2) || param3)
         {
            if(_bitmapData == null || _width != _bitmapData.width || _height != _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
                  _bitmapData = null;
                  if(_width < 1 || _height < 1)
                  {
                     return true;
                  }
               }
               else if(_width < 1 || _height < 1)
               {
                  return false;
               }
               _bitmapData = new BitmapData(_width,_height,true,16777215);
               _bitmapData.lock();
            }
            else
            {
               _bitmapData.lock();
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            Randomizer.setSeed(var_2047);
            _loc9_ = getTexture(param1,param2);
            if(_loc9_ != null)
            {
               renderTexture(param1,_loc9_);
            }
            _bitmapData.unlock();
            return true;
         }
         return false;
      }
      
      public function copyBitmapData(param1:BitmapData) : BitmapData
      {
         if(_isVisible)
         {
            if(_bitmapData != null && param1 != null)
            {
               if(_bitmapData.width == param1.width && _bitmapData.height == param1.height)
               {
                  param1.copyPixels(_bitmapData,_bitmapData.rect,new Point(0,0));
                  return param1;
               }
            }
         }
         return null;
      }
      
      private function needsNewTexture(param1:IRoomGeometry, param2:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:String = getTextureIdentifier(param1.scale);
         var _loc4_:PlaneBitmapData = var_170.getValue(_loc3_) as PlaneBitmapData;
         if(_width > 0 && _height > 0)
         {
            updateMaskChangeStatus();
            if(_loc4_ == null || _loc4_.timeStamp >= 0 && param2 > _loc4_.timeStamp || var_161)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(var_842)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < var_272.length)
            {
               _loc5_ = var_272[_loc6_] as RoomPlaneRectangleMask;
               if(_loc5_ != null)
               {
                  if(_loc5_.leftSideLoc == param1 && _loc5_.rightSideLoc == param2 && _loc5_.leftSideLength == param3 && _loc5_.rightSideLength == param4)
                  {
                     return false;
                  }
               }
               _loc6_++;
            }
            _loc5_ = new RoomPlaneRectangleMask(param1,param2,param3,param4);
            var_272.push(_loc5_);
            var_161 = true;
            return true;
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:String = getTextureIdentifier(param1.scale);
         var _loc4_:* = null;
         if(needsNewTexture(param1,param2))
         {
            _loc5_ = 0 * param1.scale;
            _loc6_ = 0 * param1.scale;
            _loc7_ = param1.getCoordinatePosition(var_438);
            _loc4_ = var_170.getValue(_loc3_) as PlaneBitmapData;
            _loc8_ = null;
            if(_loc4_ != null)
            {
               _loc8_ = _loc4_.bitmap;
            }
            if(var_687 != null)
            {
               _loc4_ = var_687.render(_loc8_,_id,_loc5_,_loc6_,param1.scale,_loc7_,var_1491,var_2046,var_2049,var_2048,var_2045,param2);
               if(_loc4_ != null)
               {
                  if(_loc8_ != null && _loc4_.bitmap != _loc8_)
                  {
                     _loc8_.dispose();
                  }
               }
            }
            else
            {
               _loc9_ = new BitmapData(_loc5_,_loc6_,true,4278190080 | _color);
               _loc4_ = new PlaneBitmapData(_loc9_,-1);
            }
            updateMask(_loc4_.bitmap,param1);
            if(_loc4_ != null)
            {
               cacheTexture(_loc3_,_loc4_);
            }
         }
         else
         {
            _loc4_ = var_170.getValue(_loc3_) as PlaneBitmapData;
         }
         if(_loc4_ != null)
         {
            return _loc4_.bitmap;
         }
         return null;
      }
      
      public function get normal() : IVector3d
      {
         return var_438;
      }
      
      private function combineTextureMask(param1:BitmapData, param2:BitmapData) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(var_182 != null && (var_182.width != param1.width || var_182.height != param1.height))
         {
            var_182.dispose();
            var_182 = null;
         }
         if(var_182 == null)
         {
            var_182 = new BitmapData(param1.width,param1.height,true,4294967295);
         }
         var_182.copyChannel(param1,param1.rect,new Point(0,0),BitmapDataChannel.ALPHA,BitmapDataChannel.RED);
         var_182.draw(param2,null,null,BlendMode.DARKEN);
         param1.copyChannel(var_182,var_182.rect,new Point(0,0),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
      }
      
      public function get leftSide() : IVector3d
      {
         return var_254;
      }
   }
}
