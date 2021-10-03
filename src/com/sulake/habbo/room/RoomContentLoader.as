package com.sulake.habbo.room
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectLogicEnum;
   import com.sulake.habbo.room.object.RoomObjectVisualizationEnum;
   import com.sulake.habbo.room.utils.PublicRoomData;
   import com.sulake.room.IRoomContentLoader;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObjectVisualizationFactory;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public class RoomContentLoader implements IRoomContentLoader, IDisposable
   {
      
      private static const const_769:String = "selection_arrow";
      
      private static const const_770:String = "tile_cursor";
      
      private static const const_274:String = "RCL_PUBLICROOM_";
      
      private static const const_490:String = "wall_place_holder";
      
      private static const const_1097:int = 2;
      
      private static const const_337:String = "place_holder";
      
      private static const const_1096:String = const_337;
      
      private static const const_1405:int = 0;
      
      private static const const_768:int = 1;
      
      private static const ROOM_CONTENT:String = "room";
      
      public static const const_696:String = "RCL_LOADER_READY";
       
      
      private var _isDisposed:Boolean = false;
      
      private var var_405:Map = null;
      
      private var var_407:Map = null;
      
      private var var_2059:String;
      
      private var var_393:IRoomObjectVisualizationFactory = null;
      
      private var var_494:Array;
      
      private var _events:Map = null;
      
      private var var_404:Map = null;
      
      private var var_1018:IEventDispatcher = null;
      
      private var var_1248:Map = null;
      
      private var _furniRevisions:Map = null;
      
      private var _wallItemTypes:Map = null;
      
      private var var_572:Map = null;
      
      private var _assetLibrary:AssetLibrary = null;
      
      private var var_2058:Boolean = false;
      
      private var var_46:int = 0;
      
      private var _wallItems:Array;
      
      private var var_2060:String;
      
      private var var_2061:Array;
      
      private var var_406:Map = null;
      
      private var var_2056:String;
      
      private var var_2057:String;
      
      private var var_571:Map = null;
      
      private var var_2055:Array;
      
      private var var_273:Map = null;
      
      private var var_183:PublicRoomData = null;
      
      public function RoomContentLoader()
      {
         var_494 = [];
         _wallItems = [];
         var_2055 = ["hh_people_pool","hh_people_pool_calippo","hh_paalu","hh_people_paalu"];
         var_2061 = ["room_public","room_public_park","room_public_pool"];
         super();
         var_407 = new Map();
         _events = new Map();
         _assetLibrary = new AssetLibrary("room_engine");
         var_405 = new Map();
         _wallItemTypes = new Map();
         var_572 = new Map();
         _furniRevisions = new Map();
         var_406 = new Map();
         var_404 = new Map();
         var_273 = new Map();
         var_571 = new Map();
         var_1248 = new Map();
      }
      
      public function insertObjectContent(param1:int, param2:int, param3:IAssetLibrary) : Boolean
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:String = getAssetLibraryType(param3);
         switch(param2)
         {
            case RoomObjectCategoryEnum.const_30:
               var_405[param1] = _loc4_;
               break;
            case RoomObjectCategoryEnum.const_28:
               _wallItemTypes[param1] = _loc4_;
               break;
            default:
               throw new Error("Registering content library for unsupported category " + param2 + "!");
         }
         var _loc5_:AssetLibraryCollection = addAssetLibraryCollection(_loc4_,null) as AssetLibraryCollection;
         if(_loc5_)
         {
            _loc5_.addAssetLibrary(param3);
            if(initializeGraphicAssetCollection(_loc4_,param3))
            {
               switch(param2)
               {
                  case RoomObjectCategoryEnum.const_30:
                     if(var_494.indexOf(_loc4_) == -1)
                     {
                        var_494.push(_loc4_);
                     }
                     break;
                  case RoomObjectCategoryEnum.const_28:
                     if(_wallItems.indexOf(_loc4_) == -1)
                     {
                        _wallItems.push(_loc4_);
                     }
                     break;
                  default:
                     throw new Error("Registering content library for unsupported category " + param2 + "!");
               }
               _loc6_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.const_279,_loc4_);
               _loc7_ = getAssetLibraryEventDispatcher(_loc4_,true);
               if(_loc7_)
               {
                  _loc7_.dispatchEvent(_loc6_);
               }
               return true;
            }
         }
         return false;
      }
      
      public function getWallItemColorIndex(param1:int) : int
      {
         var _loc2_:String = _wallItemTypes.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function hasInternalContent(param1:String) : Boolean
      {
         if(param1 == RoomObjectVisualizationEnum.const_129 || param1 == RoomObjectVisualizationEnum.PET || param1 == RoomObjectVisualizationEnum.BOT)
         {
            return true;
         }
         return false;
      }
      
      private function getRoomObjectOriginalName(param1:String) : String
      {
         var _loc2_:* = null;
         if(var_404 != null)
         {
            _loc2_ = var_404.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function getObjectType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = param1.indexOf("*");
         if(_loc2_ >= 0)
         {
            param1 = param1.substr(0,_loc2_);
         }
         return param1;
      }
      
      private function extractPublicRoomFromXML(param1:String, param2:XML) : PublicRoomData
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc3_:XMLList = param2.layoutData;
         var _loc4_:PublicRoomData = new PublicRoomData(param1);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length())
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = const_274 + String(_loc6_.@name);
            _loc8_ = 32;
            _loc9_ = 1;
            if(String(_loc6_.@size) != "")
            {
               _loc8_ = Number(parseInt(_loc6_.@size));
            }
            if(String(_loc6_.@heightScale) != "")
            {
               _loc9_ = Number(parseFloat(_loc6_.@heightScale));
            }
            _loc4_.addWorld(_loc7_,_loc8_,_loc9_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getPublicRoomContentType(param1:String) : String
      {
         if(var_183 != null && var_183.hasWorldType(const_274 + param1))
         {
            return var_183.type;
         }
         return param1;
      }
      
      private function furniDataLoadedHandler(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            if(_loc2_.assetLoader != null && _loc2_.assetLoader.content != null)
            {
               _loc3_ = _loc2_.assetLoader.content as String;
               _loc4_ = /\n{1,}/g;
               _loc5_ = _loc3_.split(_loc4_);
               for each(_loc6_ in _loc5_)
               {
                  _loc7_ = _loc6_.split("],[");
                  for each(_loc8_ in _loc7_)
                  {
                     _loc8_ = _loc8_.replace(/\[{1,}/g,"");
                     _loc8_ = _loc8_.replace(/\]{1,}/g,"");
                     _loc8_ = _loc8_.replace(/"{1,}/g,"");
                     if(_loc8_.length > 0)
                     {
                        _loc9_ = _loc8_.split(",");
                        if(_loc9_.length >= 3)
                        {
                           _loc10_ = int(_loc9_[1]);
                           _loc11_ = String(_loc9_[2]);
                           _loc12_ = int(_loc9_[3]);
                           _loc13_ = String(_loc9_[_loc9_.length - 1]);
                           if(_loc13_.length > 0)
                           {
                              var_572.add(_loc11_,_loc13_);
                           }
                           _loc14_ = _loc11_;
                           _loc15_ = _loc14_.indexOf("*");
                           if(_loc15_ >= 0)
                           {
                              _loc14_ = _loc14_.substr(0,_loc15_);
                           }
                           if(_loc9_[0] as String == "s")
                           {
                              var_405.add(_loc10_,_loc11_);
                              if(var_494.indexOf(_loc14_) < 0)
                              {
                                 var_494.push(_loc14_);
                              }
                           }
                           else if(_loc9_[0] as String == "i")
                           {
                              if(_loc11_ == "post.it")
                              {
                                 _loc11_ = "post_it";
                                 _loc14_ = "post_it";
                              }
                              if(_loc11_ == "post.it.vd")
                              {
                                 _loc11_ = "post_it_vd";
                                 _loc14_ = "post_it_vd";
                              }
                              _wallItemTypes.add(_loc10_,_loc11_);
                              if(_wallItems.indexOf(_loc14_) < 0)
                              {
                                 _wallItems.push(_loc14_);
                              }
                           }
                           _loc16_ = _furniRevisions.getValue(_loc14_);
                           if(_loc12_ > _loc16_)
                           {
                              _furniRevisions.remove(_loc14_);
                              _furniRevisions.add(_loc14_,_loc12_);
                           }
                        }
                     }
                  }
               }
            }
         }
         var_2058 = true;
         continueInitilization();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(var_407 != null)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = var_407.getWithIndex(_loc2_) as AssetLibrary;
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            var_407.dispose();
            var_407 = null;
         }
         if(_events != null)
         {
            _events.dispose();
            _events = null;
         }
         if(var_405 != null)
         {
            var_405.dispose();
            var_405 = null;
         }
         if(_wallItemTypes != null)
         {
            _wallItemTypes.dispose();
            _wallItemTypes = null;
         }
         if(_assetLibrary != null)
         {
            _assetLibrary.dispose();
            _assetLibrary = null;
         }
         if(_furniRevisions != null)
         {
            _furniRevisions.dispose();
            _furniRevisions = null;
         }
         if(var_406 != null)
         {
            var_406.dispose();
            var_406 = null;
         }
         if(var_404 != null)
         {
            var_404.dispose();
            var_404 = null;
         }
         if(var_572 != null)
         {
            var_572.dispose();
            var_572 = null;
         }
         if(var_273 != null)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc4_ = var_273.getWithIndex(_loc2_) as IGraphicAssetCollection;
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc2_++;
            }
            var_273.dispose();
            var_273 = null;
         }
         if(var_571 != null)
         {
            var_571.dispose();
            var_571 = null;
         }
         var_494 = [];
         _wallItems = [];
         var_1018 = null;
         _isDisposed = true;
      }
      
      private function getAssetLibrary(param1:String) : IAssetLibrary
      {
         var _loc4_:* = null;
         var _loc2_:String = getContentType(param1);
         _loc2_ = getRoomObjectOriginalName(_loc2_);
         var _loc3_:IAssetLibrary = var_407.getValue(getAssetLibraryName(_loc2_)) as IAssetLibrary;
         if(_loc3_ == null)
         {
            _loc4_ = var_571.getValue(_loc2_);
            if(_loc4_ != null)
            {
               _loc2_ = getContentType(_loc4_);
               _loc3_ = var_407.getValue(getAssetLibraryName(_loc2_)) as IAssetLibrary;
            }
         }
         return _loc3_;
      }
      
      public function getPlaceHolderTypes() : Array
      {
         return [const_337,const_490,ROOM_CONTENT,const_770,const_769];
      }
      
      public function addGraphicAsset(param1:String, param2:String, param3:BitmapData, param4:Boolean) : Boolean
      {
         var _loc5_:IGraphicAssetCollection = getGraphicAssetCollection(param1);
         if(_loc5_ != null)
         {
            return _loc5_.addAsset(param2,param3,param4);
         }
         return false;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      private function getObjectRevision(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = getObjectCategory(param1);
         if(_loc2_ == RoomObjectCategoryEnum.const_30 || _loc2_ == RoomObjectCategoryEnum.const_28)
         {
            if(param1.indexOf("poster") == 0)
            {
               param1 = "poster";
            }
            return int(_furniRevisions.getValue(param1));
         }
         return 0;
      }
      
      public function loadLegacyContent(param1:String, param2:IEventDispatcher) : Array
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:Array = param1.split(",");
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_].toString().length > 0 && var_2055.indexOf(_loc3_[_loc5_]) == -1)
            {
               _loc6_ = _loc3_[_loc5_].toString();
               while(_loc6_.indexOf(" ") >= 0)
               {
                  if(_loc6_.indexOf(" ") == 0)
                  {
                     _loc6_ = _loc6_.substr(1,_loc6_.length - 1);
                  }
                  else if(_loc6_.indexOf(" ") == _loc6_.length - 1)
                  {
                     _loc6_ = _loc6_.substr(0,_loc6_.length - 2);
                  }
               }
               _loc4_.push(_loc6_);
            }
            _loc5_++;
         }
         if(_loc4_.length > 0)
         {
            _loc7_ = _loc4_[0];
            _loc5_ = 1;
            while(_loc5_ < _loc4_.length)
            {
               _loc7_ += ",";
               _loc7_ += _loc4_[_loc5_];
               _loc5_++;
            }
            if(loadObjectContent(_loc7_,param2))
            {
               return [_loc4_[0]];
            }
         }
         return [];
      }
      
      public function extractObjectContent(param1:String, param2:String) : Boolean
      {
         var _loc3_:IAssetLibrary = getAssetLibrary(param1);
         var_571.add(param2,param1);
         if(initializeGraphicAssetCollection(param2,_loc3_))
         {
            return true;
         }
         var_571.remove(param2);
         return false;
      }
      
      public function getLogicType(param1:String) : String
      {
         var _loc6_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IAssetLibrary = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:IAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc3_ == null)
         {
            _loc3_ = _loc2_.getAssetByName("index");
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:XML = _loc3_.content as XML;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:String = _loc4_.@logic;
         if(_loc5_ != RoomObjectLogicEnum.const_168 && _loc5_ != RoomObjectLogicEnum.const_129)
         {
            _loc6_ = "@shadow";
            if(param1.indexOf(_loc6_) > -1)
            {
               if(param1.indexOf(_loc6_) == param1.length - _loc6_.length)
               {
                  _loc5_ = "null";
               }
            }
         }
         return _loc5_;
      }
      
      public function getActiveObjectType(param1:int) : String
      {
         var _loc2_:String = var_405.getValue(param1) as String;
         return getObjectType(_loc2_);
      }
      
      public function getPlaceHolderType(param1:String) : String
      {
         if(var_494.indexOf(param1) >= 0)
         {
            return const_337;
         }
         if(_wallItems.indexOf(param1) >= 0)
         {
            return const_490;
         }
         if(var_183 != null && (var_183.type == param1 || var_183.hasWorldType(param1)))
         {
            return ROOM_CONTENT;
         }
         return const_1096;
      }
      
      public function getContentType(param1:String) : String
      {
         if(param1.indexOf("@shadow") > -1)
         {
            if(param1.indexOf("@shadow") == param1.length - 7)
            {
               param1 = param1.substr(0,param1.length - 7);
            }
         }
         return param1;
      }
      
      public function removeObjectContent(param1:int, param2:int, param3:IAssetLibrary) : Boolean
      {
         var _loc4_:String = getAssetLibraryType(param3);
         var _loc5_:String = getContentType(_loc4_);
         if(false)
         {
            var_273.remove(_loc5_);
         }
         switch(param2)
         {
            case RoomObjectCategoryEnum.const_30:
               var_405.remove(param1);
               break;
            case RoomObjectCategoryEnum.const_28:
               _wallItemTypes.remove(param1);
               break;
            default:
               throw new Error("Removing content library for unsupported category " + param2 + "!");
         }
         return true;
      }
      
      private function getObjectColorIndex(param1:String) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc2_:int = 0;
         var _loc3_:int = param1.indexOf("*");
         if(_loc3_ >= 0)
         {
            _loc2_ = int(param1.substr(_loc3_ + 1));
         }
         return _loc2_;
      }
      
      private function getRoomObjectAlias(param1:String) : String
      {
         var _loc2_:* = null;
         if(var_406 != null)
         {
            _loc2_ = var_406.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function onContentLoadError(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:LibraryLoader = LibraryLoader(param1.target);
         var _loc3_:Array = getPlaceHolderTypes();
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = getObjectContentURLs(_loc4_);
            if(_loc5_.length > 0 && _loc5_[0] == _loc2_.url)
            {
               Core.crash("Failed to load asset: " + _loc2_.url,CoreComponent.const_1259);
               return;
            }
         }
      }
      
      private function getAssetLibraryName(param1:String) : String
      {
         return "RoomContentLoader " + param1;
      }
      
      public function getWallItemType(param1:int, param2:String = null) : String
      {
         var _loc3_:String = _wallItemTypes.getValue(param1) as String;
         if(_loc3_ == "poster" && param2 != null)
         {
            _loc3_ += param2;
         }
         return getObjectType(_loc3_);
      }
      
      private function onContentLoaded(param1:Event) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:IAssetLibrary = param1.target as IAssetLibrary;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         var _loc5_:String = getAssetLibraryType(_loc2_);
         _loc5_ = getRoomObjectOriginalName(_loc5_);
         if(_loc5_ != null)
         {
            _loc4_ = initializeGraphicAssetCollection(_loc5_,_loc2_);
         }
         if(_loc4_)
         {
            if(var_2061.indexOf(getVisualizationType(_loc5_)) >= 0)
            {
               _loc7_ = getVisualizationXML(_loc5_);
               _loc8_ = extractPublicRoomFromXML(_loc5_,_loc7_);
               var_1248.add(_loc5_,_loc8_);
               var_183 = _loc8_;
               extractPublicRoomFurnitures(_loc5_,_loc2_);
            }
            _loc3_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.const_279,_loc5_);
         }
         else
         {
            _loc3_ = new RoomContentLoadedEvent(RoomContentLoadedEvent.const_343,_loc5_);
         }
         var _loc6_:IEventDispatcher = getAssetLibraryEventDispatcher(_loc5_,true);
         if(_loc6_ != null && _loc3_ != null)
         {
            _loc6_.dispatchEvent(_loc3_);
         }
      }
      
      public function getObjectCategory(param1:String) : int
      {
         if(param1 == null)
         {
            return RoomObjectCategoryEnum.const_219;
         }
         if(var_494.indexOf(param1) >= 0)
         {
            return RoomObjectCategoryEnum.const_30;
         }
         if(_wallItems.indexOf(param1) >= 0)
         {
            return RoomObjectCategoryEnum.const_28;
         }
         if(param1.indexOf("poster") == 0)
         {
            return RoomObjectCategoryEnum.const_28;
         }
         if(var_183 != null && (var_183.type == param1 || var_183.hasWorldType(param1)))
         {
            return RoomObjectCategoryEnum.const_63;
         }
         if(param1 == "room")
         {
            return RoomObjectCategoryEnum.const_63;
         }
         if(param1 == "user")
         {
            return RoomObjectCategoryEnum.const_35;
         }
         if(param1 == "pet")
         {
            return RoomObjectCategoryEnum.const_35;
         }
         if(param1 == "bot")
         {
            return RoomObjectCategoryEnum.const_35;
         }
         if(param1 == "tile_cursor" || param1 == "selection_arrow")
         {
            return RoomObjectCategoryEnum.const_243;
         }
         return RoomObjectCategoryEnum.const_219;
      }
      
      public function getRoomObjectAdURL(param1:String) : String
      {
         if(var_572.getValue(param1) != null)
         {
            return var_572.getValue(param1);
         }
         return "";
      }
      
      private function initializeGraphicAssetCollection(param1:String, param2:IAssetLibrary) : Boolean
      {
         var _loc5_:* = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         var _loc4_:IGraphicAssetCollection = createGraphicAssetCollection(param1,param2);
         if(_loc4_ != null)
         {
            _loc5_ = getAssetXML(param1);
            if(_loc4_.define(_loc5_))
            {
               _loc3_ = true;
            }
            else
            {
               disposeGraphicAssetCollection(param1);
            }
         }
         return _loc3_;
      }
      
      public function getLogicXML(param1:String) : XML
      {
         return getXML(param1,"_logic");
      }
      
      private function continueInitilization() : void
      {
         if(var_2058)
         {
            var_46 = const_1097;
            if(var_1018 != null)
            {
               var_1018.dispatchEvent(new Event(const_696));
            }
         }
      }
      
      public function getPublicRoomWorldHeightScale(param1:String) : Number
      {
         if(var_183 != null)
         {
            return var_183.getWorldHeightScale(const_274 + param1);
         }
         return 1;
      }
      
      public function getAssetXML(param1:String) : XML
      {
         return getXML(param1,"_assets");
      }
      
      private function getAssetLibraryEventDispatcher(param1:String, param2:Boolean = false) : IEventDispatcher
      {
         var _loc3_:String = getContentType(param1);
         if(!param2)
         {
            return _events.getValue(_loc3_);
         }
         return _events.remove(_loc3_);
      }
      
      private function getObjectContentURLs(param1:String) : Array
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         _loc2_ = getContentType(param1);
         Logger.log("Getting content URL for object type: " + param1);
         switch(_loc2_)
         {
            case const_337:
               return ["PlaceHolderFurniture.swf"];
            case const_490:
               return ["PlaceHolderWallItem.swf"];
            case ROOM_CONTENT:
               return ["HabboRoomContent.swf"];
            case const_770:
               return ["TileCursor.swf"];
            case const_769:
               return ["SelectionArrow.swf"];
            default:
               _loc3_ = getObjectCategory(_loc2_);
               if(_loc3_ == RoomObjectCategoryEnum.const_30 || _loc3_ == RoomObjectCategoryEnum.const_28)
               {
                  _loc4_ = getRoomObjectAlias(_loc2_);
                  _loc5_ = var_2056;
                  _loc5_ = _loc5_.replace(/%typeid%/,_loc4_);
                  _loc6_ = getObjectRevision(_loc2_);
                  _loc5_ = _loc5_.replace(/%revision%/,_loc6_);
                  return [var_2059 + _loc5_];
               }
               _loc7_ = _loc2_.split(",");
               _loc8_ = [];
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc10_ = var_2057;
                  _loc10_ = _loc10_.replace(/%typeid%/,_loc7_[_loc9_]);
                  _loc8_.push(var_2060 + _loc10_);
                  _loc9_++;
               }
               return _loc8_;
         }
      }
      
      public function set visualizationFactory(param1:IRoomObjectVisualizationFactory) : void
      {
         var_393 = param1;
      }
      
      public function initialize(param1:IEventDispatcher, param2:IHabboConfigurationManager) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(var_46 >= const_768)
         {
            return;
         }
         if(_assetLibrary != null && param2 != null)
         {
            _loc3_ = param2.getKey("furnidata.load.url");
            _loc4_ = param2.getKey("external.hash");
            _loc3_ = _loc3_.replace("%hash%",_loc4_);
            _loc5_ = _assetLibrary.loadAssetFromFile(_loc3_,new URLRequest(_loc3_),"text/plain");
            _loc5_.addEventListener(AssetLoaderEvent.const_31,furniDataLoadedHandler);
            _loc5_.addEventListener(AssetLoaderEvent.const_43,furniDataLoadedHandler);
            var_1018 = param1;
            var_2059 = param2.getKey("flash.dynamic.download.url","furniture/");
            var_2056 = param2.getKey("flash.dynamic.download.name.template","%typeid%.swf");
            var_2060 = param2.getKey("public.room.dynamic.download.url","");
            var_2057 = param2.getKey("public.room.dynamic.download.name.template","%typeid%.swf");
         }
         var_46 = const_768;
      }
      
      public function getGraphicAssetCollection(param1:String) : IGraphicAssetCollection
      {
         var _loc2_:String = getContentType(param1);
         return var_273.getValue(_loc2_) as IGraphicAssetCollection;
      }
      
      private function disposeGraphicAssetCollection(param1:String) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:String = getContentType(param1);
         if(false)
         {
            _loc3_ = var_273.remove(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
            return true;
         }
         return false;
      }
      
      private function addAssetLibraryCollection(param1:String, param2:IEventDispatcher) : IAssetLibrary
      {
         var _loc3_:String = getContentType(param1);
         var _loc4_:IAssetLibrary = getAssetLibrary(param1);
         if(_loc4_ != null)
         {
            return _loc4_;
         }
         var _loc5_:String = getAssetLibraryName(_loc3_);
         _loc4_ = new AssetLibraryCollection(_loc5_);
         var_407.add(_loc5_,_loc4_);
         if(param2 != null && getAssetLibraryEventDispatcher(param1) == null)
         {
            _events.add(_loc3_,param2);
         }
         return _loc4_;
      }
      
      public function setRoomObjectAlias(param1:String, param2:String) : void
      {
         if(var_406 != null)
         {
            var_406.remove(param1);
            var_406.add(param1,param2);
         }
         if(var_404 != null)
         {
            var_404.remove(param2);
            var_404.add(param2,param1);
         }
      }
      
      public function getVisualizationXML(param1:String) : XML
      {
         return getXML(param1,"_visualization");
      }
      
      public function getVisualizationType(param1:String) : String
      {
         var _loc6_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IAssetLibrary = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:IAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc3_ == null)
         {
            _loc3_ = _loc2_.getAssetByName("index");
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:XML = _loc3_.content as XML;
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc5_:String = _loc4_.@visualization;
         if(_loc5_ != RoomObjectVisualizationEnum.const_168 && _loc5_ != RoomObjectVisualizationEnum.const_129)
         {
            _loc6_ = "@shadow";
            if(param1.indexOf(_loc6_) > -1)
            {
               if(param1.indexOf(_loc6_) == param1.length - _loc6_.length)
               {
                  _loc5_ = "null";
               }
            }
         }
         return _loc5_;
      }
      
      private function createGraphicAssetCollection(param1:String, param2:IAssetLibrary) : IGraphicAssetCollection
      {
         var _loc3_:IGraphicAssetCollection = getGraphicAssetCollection(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         if(param2 == null)
         {
            return null;
         }
         _loc3_ = var_393.createGraphicAssetCollection();
         if(_loc3_ != null)
         {
            _loc3_.assetLibrary = param2;
            var_273.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function isPublicRoomWorldType(param1:String) : Boolean
      {
         if(getObjectCategory(const_274 + param1) == RoomObjectCategoryEnum.const_63)
         {
            return true;
         }
         return false;
      }
      
      private function extractPublicRoomFurnitures(param1:String, param2:IAssetLibrary) : int
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(param2 == null)
         {
            return 0;
         }
         var _loc3_:Array = param2.nameArray;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_.indexOf("_index") > 0)
            {
               _loc7_ = _loc6_.slice(0,_loc6_.indexOf("_index"));
               if(extractObjectContent(param1,_loc7_))
               {
                  _loc4_++;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function getXML(param1:String, param2:String) : XML
      {
         var _loc3_:IAssetLibrary = getAssetLibrary(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:String = getContentType(param1);
         var _loc5_:String = getRoomObjectAlias(_loc4_);
         var _loc6_:IAsset = _loc3_.getAssetByName(_loc5_ + param2);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc7_:XML = _loc6_.content as XML;
         if(_loc7_ == null)
         {
            return null;
         }
         return _loc7_;
      }
      
      public function getActiveObjectColorIndex(param1:int) : int
      {
         var _loc2_:String = var_405.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         if(param1.indexOf(",") >= 0)
         {
            _loc3_ = param1;
            param1 = _loc3_.split(",")[0];
         }
         if(var_1248.getValue(param1) != null)
         {
            var_183 = var_1248.getValue(param1) as PublicRoomData;
         }
         if(getAssetLibrary(param1) != null || getAssetLibraryEventDispatcher(param1) != null)
         {
            return false;
         }
         var _loc4_:AssetLibraryCollection = addAssetLibraryCollection(param1,param2) as AssetLibraryCollection;
         if(_loc4_ == null)
         {
            return false;
         }
         if(_loc3_ != null)
         {
            _loc5_ = getObjectContentURLs(_loc3_);
         }
         else
         {
            _loc5_ = getObjectContentURLs(param1);
         }
         if(_loc5_ != null && _loc5_.length > 0)
         {
            _loc4_.addEventListener(AssetLibrary.const_360,onContentLoaded);
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = _loc4_.loadFromFile(new URLRequest(_loc5_[_loc6_]),true);
               _loc7_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,onContentLoadError);
               _loc6_++;
            }
            return true;
         }
         return false;
      }
      
      public function getPublicRoomWorldSize(param1:String) : int
      {
         if(var_183 != null)
         {
            return var_183.getWorldScale(const_274 + param1);
         }
         return 32;
      }
      
      private function getAssetLibraryType(param1:IAssetLibrary) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IAsset = param1.getAssetByName("index");
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:XML = _loc2_.content as XML;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.@type;
      }
   }
}
