package com.sulake.habbo.widget.infostand
{
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandPetData
   {
       
      
      private var var_1647:int;
      
      private var var_1650:int;
      
      private var var_1979:int;
      
      private var _type:int;
      
      private var var_1096:int = -1;
      
      private var var_1977:int;
      
      private var _nutrition:int;
      
      private var var_1975:int;
      
      private var _energy:int;
      
      private var var_1978:int;
      
      private var var_1973:int;
      
      private var var_1976:int;
      
      private var var_1646:int;
      
      private var _petRespect:int;
      
      private var _canOwnerBeKicked:Boolean;
      
      private var _image:BitmapData;
      
      private var _ownerName:String;
      
      private var var_1974:Boolean;
      
      private var _name:String = "";
      
      private var var_1584:int;
      
      public function InfoStandPetData()
      {
         super();
      }
      
      public function get isOwnPet() : Boolean
      {
         return var_1974;
      }
      
      public function get level() : int
      {
         return var_1647;
      }
      
      public function get energy() : int
      {
         return _energy;
      }
      
      public function get nutrition() : int
      {
         return _nutrition;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get experienceMax() : int
      {
         return var_1975;
      }
      
      public function get id() : int
      {
         return var_1096;
      }
      
      public function get nutritionMax() : int
      {
         return var_1979;
      }
      
      public function get ownerId() : int
      {
         return var_1584;
      }
      
      public function setData(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         _name = param1.name;
         var_1096 = param1.id;
         _type = param1.petType;
         var_1978 = param1.petRace;
         _image = param1.image;
         var_1974 = param1.isOwnPet;
         var_1584 = param1.ownerId;
         _ownerName = param1.ownerName;
         _canOwnerBeKicked = param1.canOwnerBeKicked;
         var_1647 = param1.level;
         var_1977 = param1.levelMax;
         var_1650 = param1.experience;
         var_1975 = param1.experienceMax;
         _energy = param1.energy;
         var_1973 = param1.energyMax;
         _nutrition = param1.nutrition;
         var_1979 = param1.nutritionMax;
         _petRespect = param1.petRespect;
         var_1976 = param1.roomIndex;
         var_1646 = param1.age;
      }
      
      public function get roomIndex() : int
      {
         return var_1976;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get energyMax() : int
      {
         return var_1973;
      }
      
      public function get levelMax() : int
      {
         return var_1977;
      }
      
      public function get petRespect() : int
      {
         return _petRespect;
      }
      
      public function get race() : int
      {
         return var_1978;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get canOwnerBeKicked() : Boolean
      {
         return _canOwnerBeKicked;
      }
      
      public function get experience() : int
      {
         return var_1650;
      }
      
      public function get age() : int
      {
         return var_1646;
      }
   }
}
