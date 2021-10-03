package com.sulake.habbo.catalog.purchase
{
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
   
   public class GiftWrappingConfiguration
   {
       
      
      private var var_581:Array;
      
      private var var_1223:int;
      
      private var var_1346:Array;
      
      private var var_580:Array;
      
      private var var_1881:Boolean = false;
      
      public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var_1881 = _loc2_.isWrappingEnabled;
         var_1223 = _loc2_.wrappingPrice;
         var_1346 = _loc2_.stuffTypes;
         var_580 = _loc2_.boxTypes;
         var_581 = _loc2_.ribbonTypes;
      }
      
      public function get ribbonTypes() : Array
      {
         return var_581;
      }
      
      public function get stuffTypes() : Array
      {
         return var_1346;
      }
      
      public function get price() : int
      {
         return var_1223;
      }
      
      public function get boxTypes() : Array
      {
         return var_580;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_1881;
      }
   }
}
