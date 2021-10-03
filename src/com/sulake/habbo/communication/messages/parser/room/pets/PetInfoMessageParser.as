package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1646:int;
      
      private var var_558:String;
      
      private var var_1647:int;
      
      private var var_1645:int;
      
      private var var_1650:int;
      
      private var var_1648:int;
      
      private var _nutrition:int;
      
      private var var_1096:int;
      
      private var var_1649:int;
      
      private var var_1644:int;
      
      private var _energy:int;
      
      private var _name:String;
      
      private var _ownerName:String;
      
      private var var_1584:int;
      
      private var var_1651:int;
      
      public function PetInfoMessageParser()
      {
         super();
      }
      
      public function get level() : int
      {
         return var_1647;
      }
      
      public function get energy() : int
      {
         return _energy;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get maxEnergy() : int
      {
         return var_1648;
      }
      
      public function flush() : Boolean
      {
         var_1096 = -1;
         return true;
      }
      
      public function get maxLevel() : int
      {
         return var_1649;
      }
      
      public function get experienceRequiredToLevel() : int
      {
         return var_1644;
      }
      
      public function get maxNutrition() : int
      {
         return var_1651;
      }
      
      public function get figure() : String
      {
         return var_558;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get respect() : int
      {
         return var_1645;
      }
      
      public function get petId() : int
      {
         return var_1096;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1096 = param1.readInteger();
         _name = param1.readString();
         var_1647 = param1.readInteger();
         var_1649 = param1.readInteger();
         var_1650 = param1.readInteger();
         var_1644 = param1.readInteger();
         _energy = param1.readInteger();
         var_1648 = param1.readInteger();
         _nutrition = param1.readInteger();
         var_1651 = param1.readInteger();
         var_558 = param1.readString();
         var_1645 = param1.readInteger();
         var_1584 = param1.readInteger();
         var_1646 = param1.readInteger();
         _ownerName = param1.readString();
         return true;
      }
      
      public function get nutrition() : int
      {
         return _nutrition;
      }
      
      public function get experience() : int
      {
         return var_1650;
      }
      
      public function get ownerId() : int
      {
         return var_1584;
      }
      
      public function get age() : int
      {
         return var_1646;
      }
   }
}
