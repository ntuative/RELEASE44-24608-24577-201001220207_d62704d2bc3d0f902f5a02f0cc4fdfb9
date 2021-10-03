package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1028:int = 1;
      
      private static const const_1021:int = 3;
      
      private static const const_1027:int = 2;
      
      private static const const_1026:int = 15;
       
      
      private var var_747:int;
      
      private var var_244:Array;
      
      public function FurnitureQueueTileVisualization()
      {
         var_244 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == const_1027)
         {
            var_244 = new Array();
            var_244.push(const_1028);
            var_747 = const_1026;
         }
         super.setAnimation(param1);
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(var_747 > 0)
         {
            --var_747;
         }
         if(var_747 == 0)
         {
            if(false)
            {
               super.setAnimation(var_244.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}
