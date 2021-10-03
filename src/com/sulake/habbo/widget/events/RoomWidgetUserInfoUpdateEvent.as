package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_212:String = "RWUIUE_PEER";
      
      public static const const_195:String = "RWUIUE_OWN_USER";
      
      public static const TRADE_REASON_NO_OWN_RIGHT:int = 1;
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const const_1358:String = "BOT";
      
      public static const const_955:int = 2;
      
      public static const const_1295:int = 0;
      
      public static const const_812:int = 3;
       
      
      private var var_1118:String = "";
      
      private var var_1807:Boolean = false;
      
      private var var_1732:int = 0;
      
      private var var_1808:int = 0;
      
      private var var_1812:Boolean = false;
      
      private var var_1120:String = "";
      
      private var var_1811:Boolean = false;
      
      private var var_784:int = 0;
      
      private var var_1802:Boolean = true;
      
      private var var_1041:int = 0;
      
      private var var_1804:Boolean = false;
      
      private var var_1287:Boolean = false;
      
      private var var_1806:Boolean = false;
      
      private var var_1810:int = 0;
      
      private var var_1805:Boolean = false;
      
      private var _image:BitmapData = null;
      
      private var var_283:Array;
      
      private var var_1285:Boolean = false;
      
      private var _name:String = "";
      
      private var var_1730:int = 0;
      
      private var var_1801:Boolean = false;
      
      private var var_1809:int = 0;
      
      private var var_1803:String = "";
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         var_283 = [];
         super(param1,param2,param3);
      }
      
      public function get userRoomId() : int
      {
         return var_1808;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_1808 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_1807;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_1802;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_1802 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_1811 = param1;
      }
      
      public function get motto() : String
      {
         return var_1118;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_1804 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_1287;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_1118 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_1801;
      }
      
      public function get groupBadgeId() : String
      {
         return var_1803;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_1287 = param1;
      }
      
      public function get hasFlatControl() : Boolean
      {
         return var_1805;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_1810 = param1;
      }
      
      public function get badges() : Array
      {
         return var_283;
      }
      
      public function get amIController() : Boolean
      {
         return var_1812;
      }
      
      public function set amIController(param1:Boolean) : void
      {
         var_1812 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_1801 = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_1809 = param1;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_1803 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         var_1120 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_1811;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_1804;
      }
      
      public function get carryItem() : int
      {
         return var_1810;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_1285;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_1285 = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_784 = param1;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get canTradeReason() : int
      {
         return var_1809;
      }
      
      public function get realName() : String
      {
         return var_1120;
      }
      
      public function set webID(param1:int) : void
      {
         var_1730 = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_283 = param1;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_1806 = param1;
      }
      
      public function set hasFlatControl(param1:Boolean) : void
      {
         var_1805 = param1;
      }
      
      public function get respectLeft() : int
      {
         return var_784;
      }
      
      public function get webID() : int
      {
         return var_1730;
      }
      
      public function set groupId(param1:int) : void
      {
         var_1041 = param1;
      }
      
      public function get xp() : int
      {
         return var_1732;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_1807 = param1;
      }
      
      public function get groupId() : int
      {
         return var_1041;
      }
      
      public function get canTrade() : Boolean
      {
         return var_1806;
      }
      
      public function set xp(param1:int) : void
      {
         var_1732 = param1;
      }
   }
}
