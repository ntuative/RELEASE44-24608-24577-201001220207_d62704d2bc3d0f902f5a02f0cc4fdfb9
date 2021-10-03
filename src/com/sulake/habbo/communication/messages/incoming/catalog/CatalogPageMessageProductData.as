package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageProductData
   {
      
      public static const const_218:String = "e";
      
      public static const const_77:String = "i";
      
      public static const const_73:String = "s";
       
      
      private var var_968:String;
      
      private var var_1155:String;
      
      private var var_1158:int;
      
      private var var_1586:int;
      
      private var var_967:int;
      
      public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
      {
         super();
         var_1155 = param1.readString();
         var_1586 = param1.readInteger();
         var_968 = param1.readString();
         var_967 = param1.readInteger();
         var_1158 = param1.readInteger();
      }
      
      public function get productCount() : int
      {
         return var_967;
      }
      
      public function get productType() : String
      {
         return var_1155;
      }
      
      public function get expiration() : int
      {
         return var_1158;
      }
      
      public function get furniClassId() : int
      {
         return var_1586;
      }
      
      public function get extraParam() : String
      {
         return var_968;
      }
   }
}
