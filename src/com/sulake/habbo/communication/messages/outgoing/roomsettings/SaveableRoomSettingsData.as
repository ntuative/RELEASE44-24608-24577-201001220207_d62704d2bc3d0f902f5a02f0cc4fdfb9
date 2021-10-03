package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   public class SaveableRoomSettingsData
   {
       
      
      private var var_1559:int;
      
      private var _password:String;
      
      private var var_1560:int;
      
      private var var_1561:Boolean;
      
      private var var_1563:Array;
      
      private var var_1557:Boolean;
      
      private var var_1098:int;
      
      private var _name:String;
      
      private var var_602:Array;
      
      private var _roomId:int;
      
      private var var_1099:String;
      
      public function SaveableRoomSettingsData()
      {
         super();
      }
      
      public function get doorMode() : int
      {
         return var_1560;
      }
      
      public function set allowPets(param1:Boolean) : void
      {
         var_1557 = param1;
      }
      
      public function get maximumVisitors() : int
      {
         return var_1559;
      }
      
      public function set description(param1:String) : void
      {
         var_1099 = param1;
      }
      
      public function get categoryId() : int
      {
         return var_1098;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         var_1559 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get controllers() : Array
      {
         return var_1563;
      }
      
      public function get tags() : Array
      {
         return var_602;
      }
      
      public function get allowPets() : Boolean
      {
         return var_1557;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_1560 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         return var_1099;
      }
      
      public function set tags(param1:Array) : void
      {
         var_602 = param1;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
      
      public function set controllers(param1:Array) : void
      {
         var_1563 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_1098 = param1;
      }
      
      public function get password() : String
      {
         return _password;
      }
      
      public function get allowFoodConsume() : Boolean
      {
         return var_1561;
      }
      
      public function set password(param1:String) : void
      {
         _password = param1;
      }
      
      public function set allowFoodConsume(param1:Boolean) : void
      {
         var_1561 = param1;
      }
   }
}
