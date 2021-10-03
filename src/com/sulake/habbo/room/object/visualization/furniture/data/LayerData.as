package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class LayerData
   {
      
      public static const const_363:int = 255;
      
      public static const INK_DARKEN:int = 3;
      
      public static const const_410:int = 0;
      
      public static const const_862:int = 2;
      
      public static const const_1000:int = 1;
      
      public static const const_649:Boolean = false;
      
      public static const const_563:String = "";
      
      public static const const_346:int = 0;
      
      public static const const_364:int = 0;
      
      public static const const_428:int = 0;
       
      
      private var var_1928:int = 0;
      
      private var var_1638:String = "";
      
      private var var_1537:int = 0;
      
      private var var_1925:int = 0;
      
      private var var_1926:Number = 0;
      
      private var var_1927:int = 255;
      
      private var var_1924:Boolean = false;
      
      public function LayerData()
      {
         super();
      }
      
      public function get yOffset() : int
      {
         return var_1928;
      }
      
      public function copyValues(param1:LayerData) : void
      {
         if(param1 != null)
         {
            tag = param1.tag;
            ink = param1.ink;
            alpha = param1.alpha;
            ignoreMouse = param1.ignoreMouse;
            xOffset = param1.xOffset;
            yOffset = param1.yOffset;
            zOffset = param1.zOffset;
         }
      }
      
      public function set ink(param1:int) : void
      {
         var_1537 = param1;
      }
      
      public function get zOffset() : Number
      {
         return var_1926;
      }
      
      public function set xOffset(param1:int) : void
      {
         var_1925 = param1;
      }
      
      public function set yOffset(param1:int) : void
      {
         var_1928 = param1;
      }
      
      public function get tag() : String
      {
         return var_1638;
      }
      
      public function get alpha() : int
      {
         return var_1927;
      }
      
      public function get ink() : int
      {
         return var_1537;
      }
      
      public function set zOffset(param1:Number) : void
      {
         var_1926 = param1;
      }
      
      public function get xOffset() : int
      {
         return var_1925;
      }
      
      public function set ignoreMouse(param1:Boolean) : void
      {
         var_1924 = param1;
      }
      
      public function get ignoreMouse() : Boolean
      {
         return var_1924;
      }
      
      public function set tag(param1:String) : void
      {
         var_1638 = param1;
      }
      
      public function set alpha(param1:int) : void
      {
         var_1927 = param1;
      }
   }
}
