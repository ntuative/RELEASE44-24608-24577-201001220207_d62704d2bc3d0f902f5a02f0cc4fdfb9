package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserUpdateMessageData
   {
       
      
      private var _y:Number = 0;
      
      private var var_95:Number = 0;
      
      private var var_226:int = 0;
      
      private var var_1687:int = 0;
      
      private var var_1690:Number = 0;
      
      private var var_1692:Number = 0;
      
      private var var_1689:Number = 0;
      
      private var var_1688:Number = 0;
      
      private var var_1691:Boolean = false;
      
      private var var_94:Number = 0;
      
      private var _id:int = 0;
      
      private var var_201:Array;
      
      public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
      {
         var_201 = [];
         super();
         _id = param1;
         var_94 = param2;
         _y = param3;
         var_95 = param4;
         var_1688 = param5;
         var_226 = param6;
         var_1687 = param7;
         var_1690 = param8;
         var_1692 = param9;
         var_1689 = param10;
         var_1691 = param11;
         var_201 = param12;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return var_95;
      }
      
      public function get dir() : int
      {
         return var_226;
      }
      
      public function get localZ() : Number
      {
         return var_1688;
      }
      
      public function get isMoving() : Boolean
      {
         return var_1691;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get dirHead() : int
      {
         return var_1687;
      }
      
      public function get targetX() : Number
      {
         return var_1690;
      }
      
      public function get targetY() : Number
      {
         return var_1692;
      }
      
      public function get targetZ() : Number
      {
         return var_1689;
      }
      
      public function get x() : Number
      {
         return var_94;
      }
      
      public function get actions() : Array
      {
         return var_201.slice();
      }
   }
}
