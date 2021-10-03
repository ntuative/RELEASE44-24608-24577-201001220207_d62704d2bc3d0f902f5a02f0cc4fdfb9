package com.sulake.habbo.communication.messages.parser.moderation
{
   import flash.utils.getTimer;
   
   public class IssueMessageData
   {
      
      public static const const_153:int = 1;
      
      public static const const_1194:int = 3;
      
      public static const const_465:int = 2;
       
      
      private var var_1842:int;
      
      private var var_1840:int;
      
      private var var_1834:int;
      
      private var var_1844:int;
      
      private var var_46:int;
      
      private var var_413:int;
      
      private var var_1071:int;
      
      private var var_1695:int;
      
      private var var_1049:int;
      
      private var _roomResources:String;
      
      private var var_1837:int;
      
      private var var_1836:int;
      
      private var var_1839:String;
      
      private var var_1843:String;
      
      private var var_1833:int = 0;
      
      private var var_1308:String;
      
      private var _message:String;
      
      private var var_1835:int;
      
      private var var_1838:String;
      
      private var var_1098:int;
      
      private var var_645:String;
      
      private var var_1841:String;
      
      private var var_1414:int;
      
      public function IssueMessageData()
      {
         super();
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_1049 = param1;
      }
      
      public function set temporalPriority(param1:int) : void
      {
         var_1833 = param1;
      }
      
      public function get reporterUserId() : int
      {
         return var_1836;
      }
      
      public function set roomName(param1:String) : void
      {
         var_645 = param1;
      }
      
      public function set chatRecordId(param1:int) : void
      {
         var_1837 = param1;
      }
      
      public function get state() : int
      {
         return var_46;
      }
      
      public function get roomResources() : String
      {
         return _roomResources;
      }
      
      public function set roomResources(param1:String) : void
      {
         _roomResources = param1;
      }
      
      public function get roomName() : String
      {
         return var_645;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function set worldId(param1:int) : void
      {
         var_1844 = param1;
      }
      
      public function set state(param1:int) : void
      {
         var_46 = param1;
      }
      
      public function get unitPort() : int
      {
         return var_1840;
      }
      
      public function get priority() : int
      {
         return var_1842 + var_1833;
      }
      
      public function set issueId(param1:int) : void
      {
         var_1695 = param1;
      }
      
      public function get pickerUserName() : String
      {
         return var_1843;
      }
      
      public function getOpenTime() : String
      {
         var _loc1_:int = (getTimer() - var_1414) / 1000;
         var _loc2_:int = _loc1_ % 60;
         var _loc3_:int = _loc1_ / 60;
         var _loc4_:int = _loc3_ % 60;
         var _loc5_:int = _loc3_ / 60;
         var _loc6_:String = _loc2_ < 10 ? "0" + _loc2_ : "" + _loc2_;
         var _loc7_:String = _loc4_ < 10 ? "0" + _loc4_ : "" + _loc4_;
         var _loc8_:String = _loc5_ < 10 ? "0" + _loc5_ : "" + _loc5_;
         return _loc8_ + ":" + _loc7_ + ":" + _loc6_;
      }
      
      public function get categoryId() : int
      {
         return var_1098;
      }
      
      public function set reporterUserId(param1:int) : void
      {
         var_1836 = param1;
      }
      
      public function get roomType() : int
      {
         return var_1071;
      }
      
      public function set flatType(param1:String) : void
      {
         var_1839 = param1;
      }
      
      public function get chatRecordId() : int
      {
         return var_1837;
      }
      
      public function set message(param1:String) : void
      {
         _message = param1;
      }
      
      public function get worldId() : int
      {
         return var_1844;
      }
      
      public function set flatOwnerName(param1:String) : void
      {
         var_1841 = param1;
      }
      
      public function set reportedUserName(param1:String) : void
      {
         var_1308 = param1;
      }
      
      public function get issueId() : int
      {
         return var_1695;
      }
      
      public function set priority(param1:int) : void
      {
         var_1842 = param1;
      }
      
      public function set unitPort(param1:int) : void
      {
         var_1840 = param1;
      }
      
      public function get flatType() : String
      {
         return var_1839;
      }
      
      public function set reportedCategoryId(param1:int) : void
      {
         var_1834 = param1;
      }
      
      public function set pickerUserName(param1:String) : void
      {
         var_1843 = param1;
      }
      
      public function set pickerUserId(param1:int) : void
      {
         var_1835 = param1;
      }
      
      public function get reportedUserName() : String
      {
         return var_1308;
      }
      
      public function set roomType(param1:int) : void
      {
         var_1071 = param1;
      }
      
      public function get reportedCategoryId() : int
      {
         return var_1834;
      }
      
      public function set flatId(param1:int) : void
      {
         var_413 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_1098 = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         var_1414 = param1;
      }
      
      public function get pickerUserId() : int
      {
         return var_1835;
      }
      
      public function set reporterUserName(param1:String) : void
      {
         var_1838 = param1;
      }
      
      public function get timeStamp() : int
      {
         return var_1414;
      }
      
      public function get reportedUserId() : int
      {
         return var_1049;
      }
      
      public function get flatId() : int
      {
         return var_413;
      }
      
      public function get flatOwnerName() : String
      {
         return var_1841;
      }
      
      public function get reporterUserName() : String
      {
         return var_1838;
      }
   }
}
