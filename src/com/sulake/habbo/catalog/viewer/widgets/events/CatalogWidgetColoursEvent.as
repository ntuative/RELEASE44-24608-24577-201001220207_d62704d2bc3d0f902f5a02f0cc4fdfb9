package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetColoursEvent extends Event
   {
       
      
      private var var_1079:Array;
      
      private var var_1684:String;
      
      private var var_1685:String;
      
      private var var_1686:String;
      
      public function CatalogWidgetColoursEvent(param1:Array, param2:String, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(WidgetEvent.CWE_COLOUR_ARRAY,param5,param6);
         var_1079 = param1;
         var_1684 = param2;
         var_1685 = param3;
         var_1686 = param4;
      }
      
      public function get colours() : Array
      {
         return var_1079;
      }
      
      public function get backgroundAssetName() : String
      {
         return var_1684;
      }
      
      public function get colourAssetName() : String
      {
         return var_1685;
      }
      
      public function get chosenColourAssetName() : String
      {
         return var_1686;
      }
   }
}
