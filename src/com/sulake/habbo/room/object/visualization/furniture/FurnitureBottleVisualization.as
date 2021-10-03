package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1021:int = -1;
      
      private static const const_756:int = 20;
      
      private static const const_492:int = 9;
       
      
      private var var_555:Boolean = false;
      
      private var var_244:Array;
      
      public function FurnitureBottleVisualization()
      {
         var_244 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            var_555 = true;
            var_244 = new Array();
            var_244.push(const_1021);
            return;
         }
         if(param1 >= 0 && param1 <= 7)
         {
            if(var_555)
            {
               var_555 = false;
               var_244 = new Array();
               var_244.push(const_756);
               var_244.push(const_492 + param1);
               var_244.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(super.getLastFramePlayed(0))
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
