package com.sulake.habbo.session
{
   public class PetInfo implements IPetInfo
   {
       
      
      private var var_1647:int;
      
      private var var_1645:int;
      
      private var var_1650:int;
      
      private var var_1979:int;
      
      private var _nutrition:int;
      
      private var var_1096:int;
      
      private var var_1977:int;
      
      private var var_1975:int;
      
      private var _energy:int;
      
      private var var_1646:int;
      
      private var var_1973:int;
      
      private var _ownerName:String;
      
      private var var_1584:int;
      
      public function PetInfo()
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
      
      public function set respect(param1:int) : void
      {
         var_1645 = param1;
      }
      
      public function set energy(param1:int) : void
      {
         _energy = param1;
      }
      
      public function set level(param1:int) : void
      {
         var_1647 = param1;
      }
      
      public function get petId() : int
      {
         return var_1096;
      }
      
      public function get experienceMax() : int
      {
         return var_1975;
      }
      
      public function get nutritionMax() : int
      {
         return var_1979;
      }
      
      public function set levelMax(param1:int) : void
      {
         var_1977 = param1;
      }
      
      public function get ownerId() : int
      {
         return var_1584;
      }
      
      public function get nutrition() : int
      {
         return _nutrition;
      }
      
      public function set petId(param1:int) : void
      {
         var_1096 = param1;
      }
      
      public function set nutrition(param1:int) : void
      {
         _nutrition = param1;
      }
      
      public function get energyMax() : int
      {
         return var_1973;
      }
      
      public function get respect() : int
      {
         return var_1645;
      }
      
      public function get levelMax() : int
      {
         return var_1977;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set experienceMax(param1:int) : void
      {
         var_1975 = param1;
      }
      
      public function set experience(param1:int) : void
      {
         var_1650 = param1;
      }
      
      public function set nutritionMax(param1:int) : void
      {
         var_1979 = param1;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_1584 = param1;
      }
      
      public function get experience() : int
      {
         return var_1650;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set energyMax(param1:int) : void
      {
         var_1973 = param1;
      }
      
      public function set age(param1:int) : void
      {
         var_1646 = param1;
      }
      
      public function get age() : int
      {
         return var_1646;
      }
   }
}
