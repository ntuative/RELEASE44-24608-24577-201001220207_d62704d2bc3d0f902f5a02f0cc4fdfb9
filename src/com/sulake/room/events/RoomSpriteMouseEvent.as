package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
       
      
      private var var_1758:Boolean = false;
      
      private var var_1757:Boolean = false;
      
      private var var_1594:String = "";
      
      private var _type:String = "";
      
      private var var_1753:Boolean = false;
      
      private var var_1760:Number = 0;
      
      private var var_1754:Number = 0;
      
      private var var_1759:Number = 0;
      
      private var var_1756:String = "";
      
      private var var_1755:Number = 0;
      
      private var var_1761:Boolean = false;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number = 0, param7:Number = 0, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false)
      {
         super();
         _type = param1;
         var_1756 = param2;
         var_1594 = param3;
         var_1754 = param4;
         var_1759 = param5;
         var_1760 = param6;
         var_1755 = param7;
         var_1761 = param8;
         var_1757 = param9;
         var_1753 = param10;
         var_1758 = param11;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_1761;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_1758;
      }
      
      public function get localX() : Number
      {
         return var_1760;
      }
      
      public function get localY() : Number
      {
         return var_1755;
      }
      
      public function get canvasId() : String
      {
         return var_1756;
      }
      
      public function get altKey() : Boolean
      {
         return var_1757;
      }
      
      public function get spriteTag() : String
      {
         return var_1594;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get screenX() : Number
      {
         return var_1754;
      }
      
      public function get screenY() : Number
      {
         return var_1759;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_1753;
      }
   }
}
