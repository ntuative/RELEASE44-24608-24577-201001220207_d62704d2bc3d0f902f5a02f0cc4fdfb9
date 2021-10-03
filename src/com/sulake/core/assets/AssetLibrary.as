package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BinaryFileLoader;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.assets.loaders.IAssetLoader;
   import com.sulake.core.assets.loaders.SoundFileLoader;
   import com.sulake.core.assets.loaders.ZipFileLoader;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.ZipLoader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AssetLibrary extends EventDispatcher implements IAssetLibrary
   {
      
      private static var var_923:Array = new Array();
      
      private static var _sharedListOfTypesByMime:Dictionary;
      
      private static var var_525:uint = 0;
      
      public static const const_977:String = "AssetLibraryReady";
      
      public static const const_1250:String = "AssetLibraryUnloaded";
      
      public static const const_360:String = "AssetLibraryLoaded";
      
      public static const const_1306:String = "AssetLibraryLoadError";
       
      
      private var var_441:XML;
      
      private var var_372:Dictionary;
      
      private var var_329:Array;
      
      private var var_191:uint;
      
      private var var_1:LibraryLoader;
      
      private var var_373:Dictionary;
      
      private var _loadedAssets:Dictionary;
      
      private var var_289:Boolean;
      
      private var _file:String;
      
      private var var_1328:Boolean = false;
      
      private var var_620:Dictionary;
      
      private var _name:String;
      
      private var var_440:Boolean = true;
      
      private var var_328:Class;
      
      public function AssetLibrary(param1:String)
      {
         super();
         _name = param1;
         var_441 = new XML();
         var_191 = 0;
         var_329 = new Array();
         if(_sharedListOfTypesByMime == null)
         {
            _sharedListOfTypesByMime = new Dictionary(false);
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/octet-stream",UnknownAsset,BinaryFileLoader));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-shockwave-flash",DisplayAsset,BitmapFileLoader,"swf"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-font-truetype",ClassAsset,BinaryFileLoader,"ttf"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/zip",UnknownAsset,ZipFileLoader,"zip"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/xml",XmlAsset,BinaryFileLoader,"xml"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/html",XmlAsset,BinaryFileLoader,"htm","html"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/plain",TextAsset,BinaryFileLoader,"txt"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/jpeg",BitmapDataAsset,BitmapFileLoader,"jpg","jpeg"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/gif",BitmapDataAsset,BitmapFileLoader,"gif"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/png",BitmapDataAsset,BitmapFileLoader,"png"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/tiff",BitmapDataAsset,BitmapFileLoader,"tif","tiff"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("sound/mp3",SoundAsset,SoundFileLoader,"mp3"));
         }
         ++var_525;
         var_372 = new Dictionary(false);
         var_373 = new Dictionary(false);
         var_620 = new Dictionary(false);
         _loadedAssets = new Dictionary(false);
         var_923.push(this);
      }
      
      public static function get numAssetLibraryInstances() : uint
      {
         return var_525;
      }
      
      public static function get assetLibraryRefArray() : Array
      {
         return var_923;
      }
      
      private static function fetchLibraryContents(param1:AssetLibrary, param2:XML, param3:Class) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         if(param3 == null)
         {
            throw new Error("Library " + param1._file + " doesn\'t contain valid resource class!");
         }
         var _loc4_:XMLList = param2.child("library");
         if(_loc4_ == null)
         {
            throw Error("Provided manifest doesn\'t contain library node!");
         }
         _loc4_ = _loc4_[0].assets;
         if(_loc4_ != null)
         {
            _loc4_ = _loc4_.child("asset");
            _loc9_ = 0;
            while(_loc9_ < _loc4_.length())
            {
               _loc5_ = _loc4_[_loc9_];
               _loc6_ = _loc5_.attribute("name");
               _loc7_ = param1.getAssetTypeDeclarationByMimeType(_loc5_.attribute("mimeType"));
               if(_loc7_ != null)
               {
                  _loc8_ = new _loc7_.assetClass(_loc7_) as IAsset;
                  _loc8_.setUnknownContent(param3[_loc6_]);
                  if(_loc5_.child("param").length())
                  {
                     _loc8_.setParamsDesc(_loc5_.child("param"));
                  }
                  param1.setAsset(_loc6_,_loc8_);
               }
               else
               {
                  Logger.log("Failed to extract asset " + _loc6_ + " from Library " + param1._file + "!");
               }
               _loc9_++;
            }
         }
         return true;
      }
      
      public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:String = param1.substr(param1.lastIndexOf(".") + 1,param1.length);
         if(_loc3_.indexOf("?"))
         {
            _loc3_ = _loc3_.substr(0,_loc3_.indexOf("?") - 1);
         }
         if(param2)
         {
            for(_loc5_ in _sharedListOfTypesByMime)
            {
               _loc4_ = AssetTypeDeclaration(_sharedListOfTypesByMime[_loc5_]);
               if(_loc4_ != null)
               {
                  if(_loc4_.fileTypes.indexOf(_loc3_))
                  {
                     return _loc4_;
                  }
               }
            }
         }
         for(_loc5_ in var_372)
         {
            _loc4_ = AssetTypeDeclaration(var_372[_loc5_]);
            if(_loc4_ != null)
            {
               if(_loc4_.fileTypes.indexOf(_loc3_))
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function unload() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for(_loc1_ in var_373)
         {
            _loc2_ = var_373[_loc1_];
            _loc2_.assetLoader.dispose();
            delete var_373[_loc1_];
         }
         for(_loc1_ in _loadedAssets)
         {
            delete _loadedAssets[_loc1_];
         }
         for(_loc1_ in var_620)
         {
            delete var_620[_loc1_];
         }
         if(var_1 != null)
         {
            var_1.dispose();
            var_1 = null;
         }
         var_191 = 0;
         var_289 = false;
         _file = null;
         dispatchEvent(new Event(AssetLibrary.const_1250));
      }
      
      public function getAssetByContent(param1:Object) : IAsset
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for(_loc2_ in _loadedAssets)
         {
            _loc3_ = _loadedAssets[_loc2_];
            if(_loc3_.content === param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function libraryLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         var_441 = _loc2_.manifest.copy();
         var_328 = _loc2_.resource;
         if(var_440)
         {
            AssetLibrary.fetchLibraryContents(this,var_441,var_328);
         }
         var_289 = true;
         dispatchEvent(new Event(AssetLibrary.const_360));
         dispatchEvent(new Event(AssetLibrary.const_977));
         if(var_440)
         {
            var_1.dispose();
            var_1 = null;
            var_328 = null;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null) : AssetLoaderStruct
      {
         var _loc5_:* = null;
         if(getAssetByName(param1) != null)
         {
            throw new Error("Asset with name " + param1 + "already exists!");
         }
         var _loc4_:AssetLoaderStruct = var_373[param2.url];
         if(_loc4_ != null)
         {
            if(_loc4_.assetName == param1)
            {
               return _loc4_;
            }
         }
         if(param3 == null)
         {
            _loc5_ = solveAssetTypeDeclarationFromUrl(param2.url);
            if(_loc5_ == null)
            {
               throw new Error("Couldn\'t solve asset type for file " + param2.url + "!");
            }
         }
         else
         {
            _loc5_ = getAssetTypeDeclarationByMimeType(param3,true);
            if(_loc5_ == null)
            {
               throw new Error("Asset type declaration for mime type " + param3 + "not found!");
            }
         }
         var _loc6_:IAssetLoader = new _loc5_.loaderClass(_loc5_.mimeType,param2);
         if(_loc6_ == null)
         {
            throw new Error("Invalid file loader class defined for mime type " + param3 + "!");
         }
         _loc6_.addEventListener(AssetLoaderEvent.const_31,assetLoadEventHandler);
         _loc6_.addEventListener(AssetLoaderEvent.const_43,assetLoadEventHandler);
         _loc6_.addEventListener(AssetLoaderEvent.const_834,assetLoadEventHandler);
         _loc6_.addEventListener(AssetLoaderEvent.const_803,assetLoadEventHandler);
         _loc6_.addEventListener(AssetLoaderEvent.const_809,assetLoadEventHandler);
         _loc6_.addEventListener(AssetLoaderEvent.const_781,assetLoadEventHandler);
         _loc4_ = new AssetLoaderStruct(param1,_loc6_);
         var_373[param2.url] = _loc4_;
         return _loc4_;
      }
      
      public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean
      {
         if(param2)
         {
            if(_sharedListOfTypesByMime.hasOwnProperty(param1.mimeType))
            {
               throw new Error("Asset type " + param1.mimeType + " already registered!");
            }
            _sharedListOfTypesByMime[param1.mimeType] = param1;
         }
         else
         {
            if(var_372.hasOwnProperty(param1.mimeType))
            {
               throw new Error("Asset type " + param1.mimeType + " already registered!");
            }
            var_372[param1.mimeType] = param1;
         }
         return true;
      }
      
      public function get nameArray() : Array
      {
         return var_329;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            unload();
            super.dispose();
            var_923.splice(var_923.indexOf(this),1);
            --var_525;
            var_373 = null;
            var_620 = null;
            _loadedAssets = null;
            var_329 = null;
            var_441 = null;
            var_191 = 0;
            var_289 = false;
            _name = null;
         }
      }
      
      public function get isReady() : Boolean
      {
         return var_289;
      }
      
      public function getAssetByIndex(param1:uint) : IAsset
      {
         return param1 < var_329.length ? getAssetByName(var_329[param1]) : null;
      }
      
      public function get manifest() : XML
      {
         return var_441;
      }
      
      public function get numAssets() : uint
      {
         return var_191;
      }
      
      public function setAsset(param1:String, param2:IAsset, param3:Boolean = true) : Boolean
      {
         var _loc4_:Boolean = true;
         if((param3 || _loc4_) && param2)
         {
            if(_loc4_)
            {
               ++var_191;
               var_329.push(param1);
            }
            _loadedAssets[param1] = param2;
            return true;
         }
         return false;
      }
      
      private function loadErrorHandler(param1:Event) : void
      {
         var_289 = false;
         Logger.log("Cannot load the specified file:" + _file);
         dispatchEvent(new Event(AssetLibrary.const_1306));
      }
      
      public function getAssetIndex(param1:IAsset) : int
      {
         var _loc2_:* = null;
         for(_loc2_ in _loadedAssets)
         {
            if(_loadedAssets[_loc2_] == param1)
            {
               return var_329.indexOf(_loc2_);
            }
         }
         return -1;
      }
      
      public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2)
         {
            for(_loc4_ in _sharedListOfTypesByMime)
            {
               _loc3_ = AssetTypeDeclaration(_sharedListOfTypesByMime[_loc4_]);
               if(_loc3_ != null)
               {
                  if(_loc3_.assetClass == param1)
                  {
                     return _loc3_;
                  }
               }
            }
         }
         for(_loc4_ in var_372)
         {
            _loc3_ = AssetTypeDeclaration(var_372[_loc4_]);
            if(_loc3_ != null)
            {
               if(_loc3_.assetClass == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getClass(param1:String) : Class
      {
         var _loc2_:Class = var_620[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(var_1 != null)
         {
            if(var_1.hasDefinition(param1))
            {
               _loc2_ = var_1.getDefinition(param1) as Class;
               if(_loc2_ != null)
               {
                  var_620[param1] = _loc2_;
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function solveAssetTypeDeclarationFromUrl(param1:String) : AssetTypeDeclaration
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         _loc2_ = param1.indexOf("?",0);
         if(_loc2_ > 0)
         {
            param1 = param1.slice(0,_loc2_);
         }
         _loc2_ = param1.lastIndexOf(".");
         if(_loc2_ == -1)
         {
            return null;
         }
         param1 = param1.slice(_loc2_ + 1,param1.length);
         for(_loc5_ in var_372)
         {
            _loc3_ = var_372[_loc5_];
            _loc4_ = _loc3_.fileTypes;
            if(_loc4_ != null)
            {
               if(_loc4_.indexOf(param1,0) > -1)
               {
                  return _loc3_;
               }
            }
         }
         for(_loc5_ in _sharedListOfTypesByMime)
         {
            _loc3_ = _sharedListOfTypesByMime[_loc5_];
            _loc4_ = _loc3_.fileTypes;
            if(_loc4_ != null)
            {
               if(_loc4_.indexOf(param1,0) > -1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function loadFromFile(param1:URLRequest, param2:Boolean = true, param3:LoaderContext = null) : LibraryLoader
      {
         if(_file == param1.url && var_289)
         {
            if(!var_440 && param2)
            {
               AssetLibrary.fetchLibraryContents(this,var_441,var_328);
            }
            var_440 = param2;
            dispatchEvent(new Event(AssetLibrary.const_977));
         }
         else
         {
            if(var_1 == null)
            {
               var_1 = new LibraryLoader(var_1328);
               var_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,libraryLoadedHandler);
               var_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,loadErrorHandler);
            }
            var_440 = param2;
            _file = param1.url;
            var_1.load(param1,param3);
         }
         return var_1;
      }
      
      private function fetchAssetFromResource(param1:String) : IAsset
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(!var_328)
         {
            return null;
         }
         var _loc2_:XMLList = var_441.child("library");
         if(_loc2_ == null)
         {
            throw new Error("Provided manifest doesn\'t contain library node!");
         }
         if(_loc2_.length() == 0)
         {
            return null;
         }
         _loc2_ = _loc2_[0].assets;
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.child("asset");
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length())
            {
               _loc3_ = _loc2_[_loc6_];
               if(_loc3_.attribute("name") == param1)
               {
                  _loc4_ = getAssetTypeDeclarationByMimeType(_loc3_.attribute("mimeType"));
                  if(_loc4_ == null)
                  {
                     throw new Error("Failed to extract asset " + param1 + " from Library " + _file + "!");
                  }
                  _loc5_ = new _loc4_.assetClass(_loc4_) as IAsset;
                  _loc5_.setUnknownContent(var_328[param1]);
                  if(_loc3_.child("param").length())
                  {
                     _loc5_.setParamsDesc(_loc3_.child("param"));
                  }
                  setAsset(param1,_loc5_);
                  return _loc5_;
               }
               _loc6_++;
            }
         }
         return null;
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         var _loc2_:IAsset = _loadedAssets[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(var_440)
         {
            return null;
         }
         return fetchAssetFromResource(param1);
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      public function loadFromResource(param1:XML, param2:Class) : Boolean
      {
         return AssetLibrary.fetchLibraryContents(this,param1,param2);
      }
      
      private function assetLoadEventHandler(param1:AssetLoaderEvent) : void
      {
         var loader:IAssetLoader = null;
         var type:String = null;
         var decl:AssetTypeDeclaration = null;
         var asset:IAsset = null;
         var e:AssetLoaderEvent = param1;
         var remove:Boolean = false;
         loader = e.target as IAssetLoader;
         if(loader == null)
         {
            throw new Error("Failed to downcast object to asset loader!");
         }
         var struct:AssetLoaderStruct = var_373[loader.url];
         if(struct == null)
         {
            throw new Error("Asset loader structure was lost!");
         }
         switch(e.type)
         {
            case AssetLoaderEvent.const_31:
               type = loader.mimeType;
               decl = getAssetTypeDeclarationByMimeType(type);
               remove = true;
               if(decl != null)
               {
                  asset = new decl.assetClass(decl,loader.url);
                  try
                  {
                     asset.setUnknownContent(loader.content);
                  }
                  catch(error:Error)
                  {
                     asset.dispose();
                     e = new AssetLoaderEvent(AssetLoaderEvent.const_43,e.status);
                     break;
                  }
                  if(true)
                  {
                     ++var_191;
                     var_329.push(struct.assetName);
                  }
                  _loadedAssets[struct.assetName] = asset;
               }
               else
               {
                  e = new AssetLoaderEvent(AssetLoaderEvent.const_43,e.status);
               }
               break;
            case AssetLoaderEvent.const_43:
               remove = true;
         }
         struct.dispatchEvent(new AssetLoaderEvent(e.type,e.status));
         if(remove)
         {
            if(loader)
            {
               delete var_373[loader.url];
            }
            if(struct)
            {
               struct.dispose();
            }
         }
      }
      
      public function createAsset(param1:String, param2:AssetTypeDeclaration) : IAsset
      {
         if(hasAsset(param1) || !param2)
         {
            return null;
         }
         var _loc3_:* = new param2.assetClass(param2);
         if(!setAsset(param1,_loc3_))
         {
            _loc3_.dispose();
            _loc3_ = null;
         }
         return _loc3_;
      }
      
      public function removeAsset(param1:IAsset) : IAsset
      {
         var _loc2_:* = null;
         if(param1)
         {
            for(_loc2_ in _loadedAssets)
            {
               if(_loadedAssets[_loc2_] == param1)
               {
                  var_329.splice(var_329.indexOf(_loc2_),1);
                  delete _loadedAssets[_loc2_];
                  --var_191;
                  return param1;
               }
            }
         }
         return null;
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + ": " + _name;
      }
      
      public function get url() : String
      {
         return _file;
      }
      
      public function loadFromArchive(param1:URLRequest, param2:LoaderContext = null) : LibraryLoader
      {
         if(!(_file == param1.url && var_289))
         {
            if(var_1)
            {
               var_1.dispose();
               var_1 = null;
            }
            var_1 = new ZipLoader(var_1328);
            var_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,archiveLoadedHandler);
            var_1.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,loadErrorHandler);
            var_1.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
            var_440 = true;
            _file = param1.url;
            var_1.load(param1,param2);
         }
         return var_1;
      }
      
      public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:* = null;
         if(param2)
         {
            _loc3_ = AssetTypeDeclaration(_sharedListOfTypesByMime[param1]);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         _loc3_ = AssetTypeDeclaration(var_372[param1]);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         return null;
      }
      
      private function archiveLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         var cls:Class = null;
         var xmlClass:Class = null;
         var bytes:ByteArray = null;
         var xml:XML = null;
         var event:LibraryLoaderEvent = param1;
         var loader:ZipLoader = event.target as ZipLoader;
         var array:Array = loader.resources;
         for each(cls in array)
         {
            try
            {
               xmlClass = cls.manifest as Class;
               if(xmlClass)
               {
                  bytes = new xmlClass() as ByteArray;
                  xml = new XML(bytes.readUTFBytes(bytes.length));
                  AssetLibrary.fetchLibraryContents(this,xml,cls);
               }
            }
            catch(error:Error)
            {
               Logger.log("Failed to extract library from zip archive!");
               continue;
            }
         }
         var_289 = true;
         dispatchEvent(new Event(AssetLibrary.const_360));
         if(loader == var_1)
         {
            var_1.dispose();
            var_1 = null;
            var_328 = null;
         }
      }
      
      public function hasAsset(param1:String) : Boolean
      {
         return var_328 != null ? false : false;
      }
   }
}
