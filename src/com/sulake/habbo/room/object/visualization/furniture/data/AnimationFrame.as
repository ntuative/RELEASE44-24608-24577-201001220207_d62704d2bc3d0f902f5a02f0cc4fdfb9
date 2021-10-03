package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class AnimationFrame
   {
      
      public static const const_612:int = -1;
      
      public static const const_778:int = -1;
       
      
      private var _y:int = 0;
      
      private var var_1656:int = -1;
      
      private var var_94:int = 0;
      
      private var var_1097:int = 1;
      
      private var var_753:int = 1;
      
      private var var_1655:Boolean = false;
      
      private var var_1654:int = 0;
      
      private var _id:int = 0;
      
      public function AnimationFrame(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int = -1, param7:int = 0)
      {
         super();
         _id = param1;
         var_94 = param2;
         _y = param3;
         var_1655 = param5;
         if(param4 < 0)
         {
            param4 = const_612;
         }
         var_753 = param4;
         var_1097 = param4;
         if(param6 >= 0)
         {
            var_1656 = param6;
            var_1654 = param7;
         }
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set method_2(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(var_753 > 0 && param1 > var_753)
         {
            param1 = var_753;
         }
         var_1097 = param1;
      }
      
      public function get frameRepeats() : int
      {
         return var_753;
      }
      
      public function get activeSequenceOffset() : int
      {
         return var_1654;
      }
      
      public function get id() : int
      {
         if(_id >= 0)
         {
            return _id;
         }
         return -_id * Math.random();
      }
      
      public function get method_2() : int
      {
         if(var_753 < 0)
         {
            return const_612;
         }
         return var_1097;
      }
      
      public function get activeSequence() : int
      {
         return var_1656;
      }
      
      public function get isLastFrame() : Boolean
      {
         return var_1655;
      }
      
      public function get x() : int
      {
         return var_94;
      }
   }
}
