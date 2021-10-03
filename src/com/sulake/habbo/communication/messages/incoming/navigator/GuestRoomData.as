package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class GuestRoomData implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1582:int;
      
      private var var_1669:String;
      
      private var var_1670:int;
      
      private var var_1672:int;
      
      private var var_623:Boolean;
      
      private var var_1557:Boolean;
      
      private var var_413:int;
      
      private var var_1099:String;
      
      private var var_1560:int;
      
      private var var_1098:int;
      
      private var _ownerName:String;
      
      private var var_645:String;
      
      private var var_1668:int;
      
      private var var_1673:RoomThumbnailData;
      
      private var var_1671:Boolean;
      
      private var var_602:Array;
      
      public function GuestRoomData(param1:IMessageDataWrapper)
      {
         var _loc4_:* = null;
         var_602 = new Array();
         super();
         var_413 = param1.readInteger();
         var_623 = param1.readBoolean();
         var_645 = param1.readString();
         _ownerName = param1.readString();
         var_1560 = param1.readInteger();
         var_1582 = param1.readInteger();
         var_1668 = param1.readInteger();
         var_1099 = param1.readString();
         var_1670 = param1.readInteger();
         var_1671 = param1.readBoolean();
         var_1672 = param1.readInteger();
         var_1098 = param1.readInteger();
         var_1669 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readString();
            var_602.push(_loc4_);
            _loc3_++;
         }
         var_1673 = new RoomThumbnailData(param1);
         var_1557 = param1.readBoolean();
      }
      
      public function get maxUserCount() : int
      {
         return var_1668;
      }
      
      public function get roomName() : String
      {
         return var_645;
      }
      
      public function get userCount() : int
      {
         return var_1582;
      }
      
      public function get score() : int
      {
         return var_1672;
      }
      
      public function get eventCreationTime() : String
      {
         return var_1669;
      }
      
      public function get allowTrading() : Boolean
      {
         return var_1671;
      }
      
      public function get tags() : Array
      {
         return var_602;
      }
      
      public function get allowPets() : Boolean
      {
         return var_1557;
      }
      
      public function get event() : Boolean
      {
         return var_623;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_602 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get categoryId() : int
      {
         return var_1098;
      }
      
      public function get srchSpecPrm() : int
      {
         return var_1670;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get thumbnail() : RoomThumbnailData
      {
         return var_1673;
      }
      
      public function get doorMode() : int
      {
         return var_1560;
      }
      
      public function get flatId() : int
      {
         return var_413;
      }
      
      public function get description() : String
      {
         return var_1099;
      }
   }
}
