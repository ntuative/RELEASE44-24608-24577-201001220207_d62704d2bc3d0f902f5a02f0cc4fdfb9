package com.sulake.core.assets
{
   import flash.display.DisplayObject;
   
   public class DisplayAsset implements IAsset
   {
       
      
      protected var var_35:DisplayObject;
      
      protected var _disposed:Boolean = false;
      
      protected var var_886:String;
      
      protected var var_429:AssetTypeDeclaration;
      
      public function DisplayAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         var_429 = param1;
         var_886 = param2;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return var_429;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is DisplayAsset)
         {
            var_35 = DisplayAsset(param1).var_35;
            var_429 = DisplayAsset(param1).var_429;
            return;
         }
         throw new Error("Provided asset should be of type DisplayAsset!");
      }
      
      public function get url() : String
      {
         return var_886;
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 is DisplayObject)
         {
            var_35 = param1 as DisplayObject;
            if(var_35 != null)
            {
               return;
            }
            throw new Error("Failed to convert DisplayObject to DisplayAsset!");
         }
         if(param1 is DisplayAsset)
         {
            var_35 = DisplayAsset(param1).var_35;
            var_429 = DisplayAsset(param1).var_429;
            if(var_35 == null)
            {
               throw new Error("Failed to read content from DisplayAsset!");
            }
         }
      }
      
      public function get content() : Object
      {
         return var_35;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(false)
            {
               if(var_35.loaderInfo.loader != null)
               {
                  var_35.loaderInfo.loader.unload();
               }
            }
            var_35 = null;
            var_429 = null;
            _disposed = true;
            var_886 = null;
         }
      }
   }
}
