package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ItemMessageData
   {
       
      
      private var var_95:Number = 0;
      
      private var _data:String = "";
      
      private var var_1350:int = 0;
      
      private var var_46:int = 0;
      
      private var _type:int = 0;
      
      private var _y:Number = 0;
      
      private var var_1970:Boolean = false;
      
      private var var_2319:String = "";
      
      private var _id:int = 0;
      
      private var var_193:Boolean = false;
      
      private var var_226:String = "";
      
      private var var_1972:int = 0;
      
      private var var_1971:int = 0;
      
      private var var_1760:int = 0;
      
      private var var_1755:int = 0;
      
      public function ItemMessageData(param1:int, param2:int, param3:Boolean)
      {
         super();
         _id = param1;
         _type = param2;
         var_1970 = param3;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_193)
         {
            _y = param1;
         }
      }
      
      public function get isOldFormat() : Boolean
      {
         return var_1970;
      }
      
      public function set type(param1:int) : void
      {
         if(!var_193)
         {
            _type = param1;
         }
      }
      
      public function get dir() : String
      {
         return var_226;
      }
      
      public function get state() : int
      {
         return var_46;
      }
      
      public function set localX(param1:Number) : void
      {
         if(!var_193)
         {
            var_1760 = param1;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set wallX(param1:Number) : void
      {
         if(!var_193)
         {
            var_1972 = param1;
         }
      }
      
      public function set wallY(param1:Number) : void
      {
         if(!var_193)
         {
            var_1971 = param1;
         }
      }
      
      public function set dir(param1:String) : void
      {
         if(!var_193)
         {
            var_226 = param1;
         }
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function set localY(param1:Number) : void
      {
         if(!var_193)
         {
            var_1755 = param1;
         }
      }
      
      public function set state(param1:int) : void
      {
         if(!var_193)
         {
            var_46 = param1;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get localX() : Number
      {
         return var_1760;
      }
      
      public function set data(param1:String) : void
      {
         if(!var_193)
         {
            _data = param1;
         }
      }
      
      public function get wallX() : Number
      {
         return var_1972;
      }
      
      public function get wallY() : Number
      {
         return var_1971;
      }
      
      public function get localY() : Number
      {
         return var_1755;
      }
      
      public function setReadOnly() : void
      {
         var_193 = true;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return var_95;
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_193)
         {
            var_95 = param1;
         }
      }
   }
}
