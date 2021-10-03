package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserMessageData
   {
      
      public static const const_1270:String = "F";
      
      public static const const_880:String = "M";
       
      
      private var var_94:Number = 0;
      
      private var var_558:String = "";
      
      private var var_1766:int = 0;
      
      private var var_1731:String = "";
      
      private var var_1733:int = 0;
      
      private var var_1732:int = 0;
      
      private var var_1734:String = "";
      
      private var var_1184:String = "";
      
      private var _id:int = 0;
      
      private var var_193:Boolean = false;
      
      private var var_226:int = 0;
      
      private var var_1765:String = "";
      
      private var _name:String = "";
      
      private var var_1730:int = 0;
      
      private var _y:Number = 0;
      
      private var var_95:Number = 0;
      
      public function UserMessageData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get z() : Number
      {
         return var_95;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get dir() : int
      {
         return var_226;
      }
      
      public function set dir(param1:int) : void
      {
         if(!var_193)
         {
            var_226 = param1;
         }
      }
      
      public function set name(param1:String) : void
      {
         if(!var_193)
         {
            _name = param1;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get userType() : int
      {
         return var_1766;
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!var_193)
         {
            var_1733 = param1;
         }
      }
      
      public function get subType() : String
      {
         return var_1765;
      }
      
      public function set groupID(param1:String) : void
      {
         if(!var_193)
         {
            var_1734 = param1;
         }
      }
      
      public function set subType(param1:String) : void
      {
         if(!var_193)
         {
            var_1765 = param1;
         }
      }
      
      public function set xp(param1:int) : void
      {
         if(!var_193)
         {
            var_1732 = param1;
         }
      }
      
      public function set figure(param1:String) : void
      {
         if(!var_193)
         {
            var_558 = param1;
         }
      }
      
      public function set userType(param1:int) : void
      {
         if(!var_193)
         {
            var_1766 = param1;
         }
      }
      
      public function set sex(param1:String) : void
      {
         if(!var_193)
         {
            var_1184 = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return var_1733;
      }
      
      public function get groupID() : String
      {
         return var_1734;
      }
      
      public function set webID(param1:int) : void
      {
         if(!var_193)
         {
            var_1730 = param1;
         }
      }
      
      public function set custom(param1:String) : void
      {
         if(!var_193)
         {
            var_1731 = param1;
         }
      }
      
      public function setReadOnly() : void
      {
         var_193 = true;
      }
      
      public function get sex() : String
      {
         return var_1184;
      }
      
      public function get figure() : String
      {
         return var_558;
      }
      
      public function get webID() : int
      {
         return var_1730;
      }
      
      public function get custom() : String
      {
         return var_1731;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_193)
         {
            _y = param1;
         }
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_193)
         {
            var_95 = param1;
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
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get xp() : int
      {
         return var_1732;
      }
   }
}
