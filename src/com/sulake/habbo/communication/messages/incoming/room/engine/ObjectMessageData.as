package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ObjectMessageData
   {
       
      
      private var var_1022:int = 0;
      
      private var _data:String = "";
      
      private var var_1350:int = -1;
      
      private var var_46:int = 0;
      
      private var _type:int = 0;
      
      private var var_1023:int = 0;
      
      private var var_2319:String = "";
      
      private var var_1887:int = 0;
      
      private var _id:int = 0;
      
      private var var_193:Boolean = false;
      
      private var var_226:int = 0;
      
      private var var_1886:String = null;
      
      private var var_94:Number = 0;
      
      private var _y:Number = 0;
      
      private var var_95:Number = 0;
      
      public function ObjectMessageData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set type(param1:int) : void
      {
         if(!var_193)
         {
            _type = param1;
         }
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_193)
         {
            _y = param1;
         }
      }
      
      public function get dir() : int
      {
         return var_226;
      }
      
      public function get extra() : int
      {
         return var_1350;
      }
      
      public function get state() : int
      {
         return var_46;
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_193)
         {
            var_226 = param1;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set x(param1:Number) : void
      {
         if(!var_193)
         {
            var_94 = param1;
         }
      }
      
      public function set extra(param1:int) : void
      {
         if(!var_193)
         {
            var_1350 = param1;
         }
      }
      
      public function get z() : Number
      {
         return var_95;
      }
      
      public function set state(param1:int) : void
      {
         if(!var_193)
         {
            var_46 = param1;
         }
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function get expiryTime() : int
      {
         return var_1887;
      }
      
      public function get staticClass() : String
      {
         return var_1886;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set expiryTime(param1:int) : void
      {
         if(!var_193)
         {
            var_1887 = param1;
         }
      }
      
      public function set data(param1:String) : void
      {
         if(!var_193)
         {
            _data = param1;
         }
      }
      
      public function set staticClass(param1:String) : void
      {
         if(!var_193)
         {
            var_1886 = param1;
         }
      }
      
      public function setReadOnly() : void
      {
         var_193 = true;
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!var_193)
         {
            var_1022 = param1;
         }
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!var_193)
         {
            var_1023 = param1;
         }
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_193)
         {
            var_95 = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return var_1022;
      }
      
      public function get x() : Number
      {
         return var_94;
      }
      
      public function get sizeY() : int
      {
         return var_1023;
      }
   }
}
