package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   public class FurniData
   {
       
      
      private var var_1316:String;
      
      private var var_982:String;
      
      private var var_1958:Boolean;
      
      private var var_1350:int;
      
      private var var_1955:int;
      
      private var var_1954:Boolean;
      
      private var var_1762:String = "";
      
      private var var_1957:Boolean;
      
      private var _category:int;
      
      private var _objId:int;
      
      private var var_1255:int;
      
      private var var_1956:Boolean;
      
      private var var_1873:int = -1;
      
      private var var_1887:int;
      
      public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:int)
      {
         super();
         var_1955 = param1;
         var_982 = param2;
         _objId = param3;
         var_1255 = param4;
         _category = param5;
         var_1316 = param6;
         var_1958 = param7;
         var_1957 = param8;
         var_1956 = param9;
         var_1954 = param10;
         var_1887 = param11;
      }
      
      public function get slotId() : String
      {
         return var_1762;
      }
      
      public function get extra() : int
      {
         return var_1350;
      }
      
      public function get classId() : int
      {
         return var_1255;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get isSellable() : Boolean
      {
         return var_1954;
      }
      
      public function get isGroupable() : Boolean
      {
         return var_1958;
      }
      
      public function get stripId() : int
      {
         return var_1955;
      }
      
      public function get stuffData() : String
      {
         return var_1316;
      }
      
      public function get songId() : int
      {
         return var_1873;
      }
      
      public function setExtraData(param1:String, param2:int) : void
      {
         var_1762 = param1;
         var_1350 = param2;
      }
      
      public function get itemType() : String
      {
         return var_982;
      }
      
      public function get objId() : int
      {
         return _objId;
      }
      
      public function get expiryTime() : int
      {
         return var_1887;
      }
      
      public function get isTradeable() : Boolean
      {
         return var_1956;
      }
      
      public function get isRecyclable() : Boolean
      {
         return var_1957;
      }
   }
}
