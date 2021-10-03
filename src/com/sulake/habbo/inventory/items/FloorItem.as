package com.sulake.habbo.inventory.items
{
   public class FloorItem implements IItem
   {
       
      
      protected var var_2219:Boolean;
      
      protected var var_1350:Number;
      
      protected var var_2217:Boolean;
      
      protected var _type:int;
      
      protected var var_2218:Boolean;
      
      protected var var_1873:int;
      
      protected var var_2216:Boolean;
      
      protected var var_1316:String;
      
      protected var var_1625:int;
      
      protected var _id:int;
      
      protected var _ref:int;
      
      protected var var_1762:String;
      
      protected var var_1627:Boolean;
      
      protected var _category:int;
      
      protected var var_1628:int;
      
      protected var var_2221:int;
      
      protected var var_1623:int;
      
      public function FloorItem(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:String, param10:Number, param11:int, param12:int, param13:int, param14:int, param15:String, param16:int)
      {
         super();
         _id = param1;
         _type = param2;
         _ref = param3;
         _category = param4;
         var_1627 = param5;
         var_2216 = param6;
         var_2219 = param7;
         var_2217 = param8;
         var_1316 = param9;
         var_1350 = param10;
         var_2221 = param11;
         var_1623 = param12;
         var_1628 = param13;
         var_1625 = param14;
         var_1762 = param15;
         var_1873 = param16;
      }
      
      public function get locked() : Boolean
      {
         return var_2218;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get extra() : Number
      {
         return var_1350;
      }
      
      public function set locked(param1:Boolean) : void
      {
         var_2218 = param1;
      }
      
      public function get ref() : int
      {
         return _ref;
      }
      
      public function get songId() : int
      {
         return var_1873;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get sellable() : Boolean
      {
         return var_2217;
      }
      
      public function get slotId() : String
      {
         return var_1762;
      }
      
      public function get expires() : int
      {
         return var_2221;
      }
      
      public function get creationYear() : int
      {
         return var_1625;
      }
      
      public function get creationDay() : int
      {
         return var_1623;
      }
      
      public function get stuffData() : String
      {
         return var_1316;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get tradeable() : Boolean
      {
         return var_2216;
      }
      
      public function get groupable() : Boolean
      {
         return var_1627;
      }
      
      public function get creationMonth() : int
      {
         return var_1628;
      }
      
      public function get recyclable() : Boolean
      {
         return var_2219;
      }
   }
}
