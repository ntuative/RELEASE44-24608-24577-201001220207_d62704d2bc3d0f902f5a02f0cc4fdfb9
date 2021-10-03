package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneRectangleMask
   {
       
      
      private var var_1831:Number = 0;
      
      private var var_1830:Number = 0;
      
      private var var_1832:Number = 0;
      
      private var var_1829:Number = 0;
      
      public function RoomPlaneRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         var_1830 = param1;
         var_1832 = param2;
         var_1831 = param3;
         var_1829 = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return var_1830;
      }
      
      public function get leftSideLength() : Number
      {
         return var_1831;
      }
      
      public function get rightSideLoc() : Number
      {
         return var_1832;
      }
      
      public function get rightSideLength() : Number
      {
         return var_1829;
      }
   }
}
