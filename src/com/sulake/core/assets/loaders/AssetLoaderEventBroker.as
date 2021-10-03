package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventDispatcher;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   
   class AssetLoaderEventBroker extends EventDispatcher implements IDisposable
   {
       
      
      protected var var_363:int = 0;
      
      function AssetLoaderEventBroker()
      {
         super();
      }
      
      protected function loadEventHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case HTTPStatusEvent.HTTP_STATUS:
               var_363 = HTTPStatusEvent(param1).status;
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_809,var_363));
               break;
            case Event.COMPLETE:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_31,var_363));
               break;
            case Event.UNLOAD:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_834,var_363));
               break;
            case Event.OPEN:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_781,var_363));
               break;
            case ProgressEvent.PROGRESS:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_803,var_363));
               break;
            case IOErrorEvent.IO_ERROR:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_43,var_363));
               break;
            case SecurityErrorEvent.SECURITY_ERROR:
               dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.const_43,var_363));
               break;
            default:
               Logger.log("Unknown asset loader event! AssetLoaderEventBroker::loadEventHandler(" + param1 + ")");
         }
      }
   }
}
