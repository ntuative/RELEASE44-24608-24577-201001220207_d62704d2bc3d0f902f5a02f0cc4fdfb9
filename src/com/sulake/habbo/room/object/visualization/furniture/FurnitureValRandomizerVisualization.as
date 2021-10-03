package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1067:int = 31;
      
      private static const const_1021:int = 32;
      
      private static const const_493:int = 30;
      
      private static const const_756:int = 20;
      
      private static const const_492:int = 10;
       
      
      private var var_555:Boolean = false;
      
      private var var_244:Array;
      
      public function FurnitureValRandomizerVisualization()
      {
         var_244 = new Array();
         super();
         super.setAnimation(const_493);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
         {
            var_555 = true;
            var_244 = new Array();
            var_244.push(const_1067);
            var_244.push(const_1021);
            return;
         }
         if(param1 > 0 && param1 <= const_492)
         {
            if(var_555)
            {
               var_555 = false;
               var_244 = new Array();
               if(_direction == 2)
               {
                  var_244.push(const_756 + 5 - param1);
                  var_244.push(const_492 + 5 - param1);
               }
               else
               {
                  var_244.push(const_756 + param1);
                  var_244.push(const_492 + param1);
               }
               var_244.push(const_493);
               return;
            }
            super.setAnimation(const_493);
         }
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(super.getLastFramePlayed(11))
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
