package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.IAssetLoader;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventDispatcher;
   
   public class AssetLoaderStruct extends EventDispatcher implements IDisposable
   {
       
      
      private var var_651:IAssetLoader;
      
      private var var_1202:String;
      
      public function AssetLoaderStruct(param1:String, param2:IAssetLoader)
      {
         super();
         var_1202 = param1;
         var_651 = param2;
      }
      
      public function get assetLoader() : IAssetLoader
      {
         return var_651;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_651 != null)
            {
               if(true)
               {
                  var_651.dispose();
                  var_651 = null;
               }
            }
            super.dispose();
         }
      }
      
      public function get assetName() : String
      {
         return var_1202;
      }
   }
}
