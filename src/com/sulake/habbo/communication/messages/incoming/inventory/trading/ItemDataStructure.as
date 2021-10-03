package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   public class ItemDataStructure
   {
       
      
      private var var_982:String;
      
      private var var_1622:int;
      
      private var var_1626:int;
      
      private var var_1350:int;
      
      private var var_1625:int;
      
      private var _category:int;
      
      private var var_2311:int;
      
      private var var_1623:int;
      
      private var var_1629:int;
      
      private var var_1624:int;
      
      private var var_1628:int;
      
      private var var_1627:Boolean;
      
      private var var_1316:String;
      
      public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int, param12:Boolean)
      {
         super();
         var_1622 = param1;
         var_982 = param2;
         var_1626 = param3;
         var_1624 = param4;
         _category = param5;
         var_1316 = param6;
         var_1350 = param7;
         var_1629 = param8;
         var_1623 = param9;
         var_1628 = param10;
         var_1625 = param11;
         var_1627 = param12;
      }
      
      public function get itemTypeID() : int
      {
         return var_1624;
      }
      
      public function get extra() : int
      {
         return var_1350;
      }
      
      public function get stuffData() : String
      {
         return var_1316;
      }
      
      public function get groupable() : Boolean
      {
         return var_1627;
      }
      
      public function get creationMonth() : int
      {
         return var_1628;
      }
      
      public function get roomItemID() : int
      {
         return var_1626;
      }
      
      public function get itemType() : String
      {
         return var_982;
      }
      
      public function get itemID() : int
      {
         return var_1622;
      }
      
      public function get songID() : int
      {
         return var_1350;
      }
      
      public function get timeToExpiration() : int
      {
         return var_1629;
      }
      
      public function get creationYear() : int
      {
         return var_1625;
      }
      
      public function get creationDay() : int
      {
         return var_1623;
      }
      
      public function get category() : int
      {
         return _category;
      }
   }
}
