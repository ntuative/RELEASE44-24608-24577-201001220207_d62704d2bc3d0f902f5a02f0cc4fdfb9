package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class PublicRoomObjectMessageData
   {
       
      
      private var var_1023:int = 0;
      
      private var var_95:Number = 0;
      
      private var _y:Number = 0;
      
      private var var_193:Boolean = false;
      
      private var var_226:int = 0;
      
      private var _type:String = "";
      
      private var _name:String = "";
      
      private var var_94:Number = 0;
      
      private var var_1022:int = 0;
      
      public function PublicRoomObjectMessageData()
      {
         super();
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_193)
         {
            var_95 = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return var_1023;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get dir() : int
      {
         return var_226;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         if(!var_193)
         {
            _name = param1;
         }
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_193)
         {
            var_226 = param1;
         }
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_193)
         {
            _y = param1;
         }
      }
      
      public function setReadOnly() : void
      {
         var_193 = true;
      }
      
      public function get z() : Number
      {
         return var_95;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!var_193)
         {
            var_1023 = param1;
         }
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!var_193)
         {
            var_1022 = param1;
         }
      }
      
      public function set x(param1:Number) : void
      {
         if(!var_193)
         {
            var_94 = param1;
         }
      }
      
      public function get x() : Number
      {
         return var_94;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         if(!var_193)
         {
            _type = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return var_1022;
      }
   }
}
