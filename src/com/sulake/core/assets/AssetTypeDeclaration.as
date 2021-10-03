package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
       
      
      private var var_1788:Class;
      
      private var var_1789:Class;
      
      private var var_1787:String;
      
      private var var_1142:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class, ... rest)
      {
         super();
         var_1787 = param1;
         var_1789 = param2;
         var_1788 = param3;
         if(rest == null)
         {
            var_1142 = new Array();
         }
         else
         {
            var_1142 = rest;
         }
      }
      
      public function get loaderClass() : Class
      {
         return var_1788;
      }
      
      public function get assetClass() : Class
      {
         return var_1789;
      }
      
      public function get mimeType() : String
      {
         return var_1787;
      }
      
      public function get fileTypes() : Array
      {
         return var_1142;
      }
   }
}
