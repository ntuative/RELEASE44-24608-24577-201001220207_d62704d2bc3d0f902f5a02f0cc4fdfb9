package com.sulake.core.localization
{
   public class LocalizationDefinition implements ILocalizationDefinition
   {
       
      
      private var _name:String;
      
      private var var_1456:String;
      
      private var var_886:String;
      
      private var var_1457:String;
      
      private var var_1458:String;
      
      public function LocalizationDefinition(param1:String, param2:String, param3:String)
      {
         super();
         var _loc4_:Array = param1.split("_");
         var_1458 = _loc4_[0];
         var _loc5_:Array = String(_loc4_[1]).split(".");
         var_1456 = _loc5_[0];
         var_1457 = _loc5_[1];
         _name = param2;
         var_886 = param3;
      }
      
      public function get countryCode() : String
      {
         return var_1456;
      }
      
      public function get languageCode() : String
      {
         return var_1458;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get url() : String
      {
         return var_886;
      }
      
      public function get encoding() : String
      {
         return var_1457;
      }
      
      public function get id() : String
      {
         return var_1458 + "_" + var_1456 + "." + var_1457;
      }
   }
}
