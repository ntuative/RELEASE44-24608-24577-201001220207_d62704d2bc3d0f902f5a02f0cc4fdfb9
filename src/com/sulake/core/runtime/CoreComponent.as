package com.sulake.core.runtime
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.profiler.ProfilerViewer;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public final class CoreComponent extends ComponentContext implements ICore
   {
      
      private static const const_130:uint = 3;
      
      private static const const_1060:String = "library";
      
      public static const const_1258:int = 6;
      
      private static const const_1057:String = "library";
      
      public static const const_1301:int = 99;
      
      private static const const_1059:String = "library";
      
      private static const const_1061:String = "zip-libraries";
      
      public static const const_1255:int = 7;
      
      public static const const_828:int = 1;
      
      public static const const_1334:int = 10;
      
      public static const const_1231:int = 2;
      
      private static const const_1062:String = "library";
      
      private static const const_1058:String = "asset-libraries";
      
      public static const const_1153:int = 5;
      
      public static const const_1123:int = 20;
      
      public static const const_620:int = 30;
      
      public static const const_622:int = 4;
      
      public static const const_1259:int = 3;
      
      private static const const_1063:String = "service-libraries";
      
      private static const const_1064:String = "component-libraries";
       
      
      private var var_546:Number = 0;
      
      private var var_112:ICoreConfigStatusListener;
      
      private var var_265:uint;
      
      private var var_266:Array;
      
      private var var_262:uint;
      
      private var var_126:DisplayObjectContainer;
      
      private var var_809:Profiler;
      
      private var var_264:Array;
      
      private var var_225:Array;
      
      private var var_461:Array;
      
      private var var_545:Array;
      
      private var var_263:Array;
      
      private var var_655:ProfilerViewer;
      
      public function CoreComponent(param1:DisplayObjectContainer, param2:uint)
      {
         super(this,Component.COMPONENT_FLAG_CONTEXT,new AssetLibraryCollection("_core_assets"));
         var_1328 = (param2 & 0) != 0;
         var_461 = new Array();
         var_545 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < CoreComponent.const_130)
         {
            var_461.push(new Array());
            var_545.push(0);
            _loc3_++;
         }
         var_265 = getTimer();
         attachComponent(this,[new IIDCore()]);
         var_126 = param1;
         switch(param2 & 0)
         {
            case Core.const_1268:
               debug("Core; using simple frame update handler");
               var_126.addEventListener(Event.ENTER_FRAME,simpleFrameUpdateHandler);
               break;
            case Core.const_859:
               debug("Core; using complex frame update handler");
               var_126.addEventListener(Event.ENTER_FRAME,complexFrameUpdateHandler);
               break;
            case Core.const_1252:
               debug("Core; using profiler frame update handler");
               var_126.addEventListener(Event.ENTER_FRAME,profilerFrameUpdateHandler);
               var_809 = new Profiler(this);
               attachComponent(var_809,[new IIDProfiler()]);
               var_655 = new ProfilerViewer();
               var_126.addChild(var_655);
               break;
            case Core.CORE_SETUP_DEBUG:
               debug("Core; using debug frame update handler");
               var_126.addEventListener(Event.ENTER_FRAME,debugFrameUpdateHandler);
         }
      }
      
      override public function removeUpdateReceiver(param1:ICoreUpdateReceiver) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < CoreComponent.const_130)
         {
            _loc3_ = var_461[_loc4_] as Array;
            _loc2_ = _loc3_.indexOf(param1);
            if(_loc2_ > -1)
            {
               _loc3_[_loc2_] = null;
               return;
            }
            _loc4_++;
         }
      }
      
      public function getLastErrorMessage() : String
      {
         return var_898;
      }
      
      override public function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
      {
         if(param2)
         {
            if(param4 != null)
            {
               ErrorReportStorage.setParameter("error_data",String(param4.getStackTrace()));
            }
            ErrorReportStorage.setParameter("error_cat",String(param3));
            ErrorReportStorage.setParameter("error_desc",param1);
         }
         super.error(param1,param2,param3);
         if(param2)
         {
            dispose();
         }
      }
      
      private function debugFrameUpdateHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc2_:uint = getTimer();
         var _loc3_:uint = _loc2_ - var_265;
         var_265 = _loc2_;
         _loc4_ = 0;
         while(_loc4_ < CoreComponent.const_130)
         {
            var_545[_loc4_] = 0;
            _loc5_ = var_461[_loc4_];
            _loc8_ = 0;
            _loc7_ = uint(_loc5_.length);
            while(_loc8_ != _loc7_)
            {
               _loc6_ = ICoreUpdateReceiver(_loc5_[_loc8_]);
               if(_loc6_ == null || _loc6_.disposed)
               {
                  _loc5_.splice(_loc8_,1);
                  _loc7_--;
               }
               else
               {
                  _loc6_.update(_loc3_);
                  _loc8_++;
               }
            }
            _loc4_++;
         }
      }
      
      public function initialize() : void
      {
         _events.dispatchEvent(new Event(Component.COMPONENT_EVENT_RUNNING));
         Logger.log(toXMLString());
      }
      
      private function updateConfigStatusListener() : void
      {
         var _loc1_:* = NaN;
         if(var_112)
         {
            _loc1_ = NaN;
            if(var_546 > 0)
            {
               _loc1_ += var_546 + var_225.length - 1;
            }
            else
            {
               _loc1_ += var_225.length;
            }
            var_112.percent = (Number(var_262) - _loc1_) / Number(var_262);
         }
      }
      
      private function profilerFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_265;
         var_265 = msCurrentTime;
         var_809.start();
         criticality = 0;
         while(criticality < CoreComponent.const_130)
         {
            var_545[criticality] = 0;
            receivers = var_461[criticality];
            index = 0;
            length = receivers.length;
            while(index != length)
            {
               receiver = ICoreUpdateReceiver(receivers[index]);
               if(receiver == null || receiver.disposed)
               {
                  receivers.splice(index,1);
                  length--;
               }
               else
               {
                  try
                  {
                     var_809.update(receiver,msSinceLastUpdate);
                  }
                  catch(e:Error)
                  {
                     error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID,e);
                     return;
                  }
                  index++;
               }
            }
            criticality++;
         }
         var_809.stop();
         var_655.refresh(var_809);
      }
      
      private function complexFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var skip:Boolean = false;
         var t:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_265;
         var maxTimePerFrame:uint = 1000 / DisplayObject(var_126).stage.frameRate;
         var_265 = msCurrentTime;
         criticality = 0;
         while(criticality < CoreComponent.const_130)
         {
            t = getTimer();
            skip = false;
            if(t - msCurrentTime > maxTimePerFrame)
            {
               if(var_545[criticality] < criticality)
               {
                  ++0;
                  skip = true;
               }
            }
            if(!skip)
            {
               var_545[criticality] = 0;
               receivers = var_461[criticality];
               index = 0;
               length = receivers.length;
               while(index != length)
               {
                  receiver = ICoreUpdateReceiver(receivers[index]);
                  if(receiver == null || receiver.disposed)
                  {
                     receivers.splice(index,1);
                     length--;
                  }
                  else
                  {
                     try
                     {
                        receiver.update(msSinceLastUpdate);
                     }
                     catch(e:Error)
                     {
                        trace(e.getStackTrace());
                        error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID,e);
                        return;
                     }
                     index++;
                  }
               }
            }
            criticality++;
         }
      }
      
      private function simpleFrameUpdateHandler(param1:Event) : void
      {
         var criticality:uint = 0;
         var receivers:Array = null;
         var receiver:ICoreUpdateReceiver = null;
         var length:uint = 0;
         var index:uint = 0;
         var event:Event = param1;
         var msCurrentTime:uint = getTimer();
         var msSinceLastUpdate:uint = msCurrentTime - var_265;
         var_265 = msCurrentTime;
         criticality = 0;
         while(criticality < CoreComponent.const_130)
         {
            var_545[criticality] = 0;
            receivers = var_461[criticality];
            index = 0;
            length = receivers.length;
            while(index != length)
            {
               receiver = ICoreUpdateReceiver(receivers[index]);
               if(receiver == null || receiver.disposed)
               {
                  receivers.splice(index,1);
                  length--;
               }
               else
               {
                  try
                  {
                     receiver.update(msSinceLastUpdate);
                  }
                  catch(e:Error)
                  {
                     trace(e.getStackTrace());
                     error("Error in update receiver \"" + getQualifiedClassName(receiver) + "\": " + e.message,true,e.errorID,e);
                     return;
                  }
                  index++;
               }
            }
            criticality++;
         }
      }
      
      public function loadExternalConfigDocument(param1:URLRequest, param2:ICoreConfigStatusListener = null) : void
      {
         if(var_112)
         {
            if(var_112 != param2)
            {
               var_112.dispose();
            }
         }
         if(param2)
         {
            var_112 = param2;
         }
         var _loc3_:AssetLoaderStruct = _assets.loadAssetFromFile("config.xml",param1);
         debug("Loading config document \"" + _loc3_.assetLoader.url + "\"");
         _loc3_.addEventListener(AssetLoaderEvent.const_31,configLoadedHandler);
         _loc3_.addEventListener(AssetLoaderEvent.const_43,configLoadedHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            debug("Disposing core");
            var_126.removeEventListener(Event.ENTER_FRAME,simpleFrameUpdateHandler);
            var_126.removeEventListener(Event.ENTER_FRAME,complexFrameUpdateHandler);
            var_126.removeEventListener(Event.ENTER_FRAME,profilerFrameUpdateHandler);
            var_126 = null;
            _loc3_ = 0;
            while(_loc3_ < CoreComponent.const_130)
            {
               _loc2_ = var_461[_loc3_] as Array;
               _loc1_ = uint(_loc2_.length);
               while(_loc1_-- > 0)
               {
                  _loc2_.pop();
               }
               _loc3_++;
            }
            if(var_225 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_225.pop();
               }
            }
            if(var_263 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_263.pop();
               }
            }
            if(var_266 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_266.pop();
               }
            }
            if(var_264 != null)
            {
               _loc1_ = 0;
               while(_loc1_-- > 0)
               {
                  var_264.pop();
               }
            }
            if(var_655 != null)
            {
               var_655.dispose();
               var_655 = null;
            }
            if(var_112)
            {
               var_112.dispose();
               var_112 = null;
            }
            super.dispose();
         }
      }
      
      public function readConfigDocument(param1:XML, param2:ICoreConfigStatusListener = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(var_112)
         {
            if(var_112 != param2)
            {
               var_112.dispose();
            }
         }
         if(param2)
         {
            var_112 = param2;
         }
         debug("Parsing config document");
         if(var_225 == null)
         {
            var_225 = new Array();
         }
         _loc3_ = param1.child(const_1061)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_1060);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url").toString();
               var_225.push(_loc6_);
               ++var_262;
            }
         }
         if(var_263 == null)
         {
            var_263 = new Array();
         }
         _loc3_ = param1.child(const_1058)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_1057);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url").toString();
               var_263.push(_loc6_);
               ++var_262;
            }
         }
         if(var_266 == null)
         {
            var_266 = new Array();
         }
         _loc3_ = param1.child(const_1063)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_1062);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url").toString();
               var_266.push(_loc6_);
               ++var_262;
            }
         }
         if(var_264 == null)
         {
            var_264 = new Array();
         }
         _loc3_ = param1.child(const_1064)[0];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.child(const_1059);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = _loc5_.attribute("url").toString();
               var_264.push(_loc6_);
               ++var_262;
            }
         }
         if(var_112)
         {
            var_112.percent = 0;
         }
         updateLoadingProcess();
      }
      
      private function updateLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 != null)
         {
            if(param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE || param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR)
            {
               _loc2_ = param1.target as LibraryLoader;
               _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,updateArchiveLoadingItemProgress);
               _loc3_ = _loc2_.url;
               debug("Loading library \"" + _loc3_ + "\" " + (param1.type == LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE ? "ready" : "failed\n" + _loc2_.getLastErrorMessage()));
               if(false)
               {
                  if(var_225[0] == _loc3_)
                  {
                     var_546 = 0;
                     var_225.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_263[0] == _loc3_)
                  {
                     var_263.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_266[0] == _loc3_)
                  {
                     var_266.splice(0,1);
                  }
               }
               if(false)
               {
                  if(var_264[0] == _loc3_)
                  {
                     var_264.splice(0,1);
                  }
               }
            }
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = _assets.loadFromArchive(new URLRequest(_loc3_),null);
            if(_loc2_.ready)
            {
               var_225.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,updateArchiveLoadingItemProgress);
               debug("Loading zip library " + _loc3_);
            }
            updateConfigStatusListener();
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc4_ = new LoaderContext(false,new ApplicationDomain());
            _loc2_ = _assets.loadFromFile(new URLRequest(_loc3_),true,_loc4_);
            if(_loc2_.ready)
            {
               var_263.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               var_546 = 1;
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading asset library " + _loc3_);
            }
            updateConfigStatusListener();
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = loadFromFile(new URLRequest(_loc3_),new LoaderContext(false,ApplicationDomain.currentDomain,null));
            if(_loc2_.ready)
            {
               var_266.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading service library " + _loc3_);
            }
            updateConfigStatusListener();
            return;
         }
         if(false)
         {
            _loc3_ = "null";
            _loc2_ = loadFromFile(new URLRequest(_loc3_),new LoaderContext(false,ApplicationDomain.currentDomain,null));
            if(_loc2_.ready)
            {
               var_264.splice(0,1);
               updateLoadingProcess();
            }
            else
            {
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,updateLoadingProcess);
               _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,errorInLoadingProcess);
               debug("Loading component library " + _loc3_);
            }
            updateConfigStatusListener();
            return;
         }
         if(var_112)
         {
            var_112.complete();
         }
         debug("All libraries loaded, Core is now running");
      }
      
      private function errorInLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:LibraryLoader = LibraryLoader(param1.target);
         error("Failed to download library \"" + _loc2_.url + "\" HTTP status " + param1.status + ": " + _loc2_.getLastErrorMessage(),true,const_1231);
         updateLoadingProcess(param1);
      }
      
      private function updateArchiveLoadingItemProgress(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         var_546 = 1 - _loc2_.bytesLoaded / _loc2_.bytesTotal;
         if(var_546 > 0)
         {
            updateConfigStatusListener();
         }
      }
      
      public function getLastDebugMessage() : String
      {
         return var_2235;
      }
      
      override public function registerUpdateReceiver(param1:ICoreUpdateReceiver, param2:uint) : void
      {
         removeUpdateReceiver(param1);
         param2 = param2 >= CoreComponent.const_130 ? 4294967295 : uint(param2);
         var _loc3_:Array = var_461[param2] as Array;
         _loc3_.push(param1);
      }
      
      private function configLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _loc2_ = param1.target as AssetLoaderStruct;
         _loc2_.removeEventListener(AssetLoaderEvent.const_31,configLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_43,configLoadedHandler);
         if(param1.type == AssetLoaderEvent.const_31)
         {
            debug("Config document \"" + _loc2_.assetLoader.url + "\" loaded");
            _loc3_ = _assets.getAssetByName(_loc2_.assetName) as XmlAsset;
            _loc4_ = _loc3_.content as XML;
            readConfigDocument(_loc4_,var_112);
         }
         else
         {
            error("Failed to download external configuration document " + _loc2_.assetLoader.url + "!",true,const_828);
            _events.dispatchEvent(new Event(Component.COMPONENT_EVENT_ERROR));
         }
      }
      
      public function get root() : DisplayObjectContainer
      {
         return var_126;
      }
   }
}
