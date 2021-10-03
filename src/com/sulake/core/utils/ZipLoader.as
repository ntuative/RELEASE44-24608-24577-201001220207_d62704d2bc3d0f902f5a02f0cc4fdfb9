package com.sulake.core.utils
{
   import deng.fzip.FZip;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   
   public class ZipLoader extends LibraryLoader
   {
       
      
      private var var_418:FZip;
      
      private var var_1296:Array;
      
      private var var_2178:uint = 0;
      
      private var var_871:int = 0;
      
      private var var_2340:Array;
      
      public function ZipLoader(param1:Boolean)
      {
         super(param1);
         var_1296 = new Array();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         Logger.log(param1.text);
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,0));
      }
      
      public function get resources() : Array
      {
         return var_1296;
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:String = getQualifiedClassName(var_1.content);
         var_1296.push(var_1.contentLoaderInfo.applicationDomain.getDefinition(_loc3_));
         ++var_871;
         if(var_1296.length == var_2178)
         {
            var_1.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaderComplete);
            var_1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
            dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,0));
         }
         else
         {
            var_1.loadBytes(var_418.getFileAt(var_871).content);
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null, param3:int = 1) : void
      {
         var_317 = param1;
         if(var_418)
         {
            var_418.close();
         }
         var_418 = new FZip();
         var_418.addEventListener(Event.COMPLETE,onComplete);
         var_418.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         var_418.addEventListener(ProgressEvent.PROGRESS,onProgress);
         var_418.load(var_317);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_PROGRESS,0));
      }
      
      private function onComplete(param1:Event) : void
      {
         var_871 = 0;
         var_2178 = var_418.getFileCount();
         removeEventListeners();
         var_1.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
         var_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         var_1.loadBytes(var_418.getFileAt(var_871).content);
      }
   }
}
