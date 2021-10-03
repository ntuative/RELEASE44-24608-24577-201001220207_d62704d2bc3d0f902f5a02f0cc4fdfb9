package com.sulake.habbo.inventory.furni
{
   import flash.display.BitmapData;
   
   public class FurniItem
   {
       
      
      private var _isSelected:Boolean = false;
      
      private var var_1955:int;
      
      private var var_1957:Boolean;
      
      private var var_1873:int;
      
      private var var_1316:String;
      
      private var var_2062:Boolean = false;
      
      private var var_1887:int;
      
      private var var_427:int;
      
      private var var_982:String;
      
      private var var_1762:String;
      
      private var _image:BitmapData;
      
      private var _objId:int;
      
      private var var_1255:int;
      
      private var var_1956:Boolean;
      
      private var var_2063:int;
      
      public function FurniItem(param1:int, param2:String, param3:int, param4:int, param5:String, param6:Boolean, param7:Boolean, param8:int, param9:String, param10:int)
      {
         super();
         var_1955 = param1;
         var_982 = param2;
         _objId = param3;
         var_1255 = param4;
         var_1316 = param5;
         var_1957 = param6;
         var_1956 = param7;
         var_1887 = param8;
         var_1762 = param9;
         var_1873 = param10;
         var_427 = -1;
      }
      
      public function get songId() : int
      {
         return var_1873;
      }
      
      public function get iconCallbackId() : int
      {
         return var_427;
      }
      
      public function get expiryTime() : int
      {
         return var_1887;
      }
      
      public function set prevCallbackId(param1:int) : void
      {
         var_2063 = param1;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         var_2062 = param1;
      }
      
      public function set iconCallbackId(param1:int) : void
      {
         var_427 = param1;
      }
      
      public function get isTradeable() : Boolean
      {
         return var_1956;
      }
      
      public function get slotId() : String
      {
         return var_1762;
      }
      
      public function get classId() : int
      {
         return var_1255;
      }
      
      public function get isRecyclable() : Boolean
      {
         return var_1957;
      }
      
      public function get stuffData() : String
      {
         return var_1316;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function get stripId() : int
      {
         return var_1955;
      }
      
      public function get isLocked() : Boolean
      {
         return var_2062;
      }
      
      public function get prevCallbackId() : int
      {
         return var_2063;
      }
      
      public function get iconImage() : BitmapData
      {
         return _image;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get objId() : int
      {
         return _objId;
      }
      
      public function get itemType() : String
      {
         return var_982;
      }
   }
}
