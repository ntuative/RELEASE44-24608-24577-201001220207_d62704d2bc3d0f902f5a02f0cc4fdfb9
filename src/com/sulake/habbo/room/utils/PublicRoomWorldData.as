package com.sulake.habbo.room.utils
{
   public class PublicRoomWorldData
   {
       
      
      private var var_2137:Number = 1;
      
      private var var_200:Number = 1;
      
      private var var_1779:String = "";
      
      public function PublicRoomWorldData(param1:String, param2:Number, param3:Number)
      {
         super();
         var_1779 = param1;
         var_200 = param2;
         var_2137 = param3;
      }
      
      public function get scale() : Number
      {
         return var_200;
      }
      
      public function get heightScale() : Number
      {
         return var_2137;
      }
   }
}
