package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class OfficialRoomEntryData implements IDisposable
   {
      
      public static const const_1360:int = 4;
      
      public static const const_522:int = 3;
      
      public static const const_498:int = 2;
      
      public static const const_788:int = 1;
       
      
      private var var_1992:String;
      
      private var _disposed:Boolean;
      
      private var var_1582:int;
      
      private var var_1993:Boolean;
      
      private var var_782:String;
      
      private var var_829:PublicRoomData;
      
      private var var_1989:int;
      
      private var _index:int;
      
      private var var_1990:String;
      
      private var _type:int;
      
      private var var_1638:String;
      
      private var var_830:GuestRoomData;
      
      private var var_1991:String;
      
      private var _open:Boolean;
      
      public function OfficialRoomEntryData(param1:IMessageDataWrapper)
      {
         super();
         _index = param1.readInteger();
         var_1992 = param1.readString();
         var_1991 = param1.readString();
         var_1993 = param1.readInteger() == 1;
         var_1990 = param1.readString();
         var_782 = param1.readString();
         var_1989 = param1.readInteger();
         var_1582 = param1.readInteger();
         _type = param1.readInteger();
         if(_type == const_788)
         {
            var_1638 = param1.readString();
         }
         else if(_type == const_522)
         {
            var_829 = new PublicRoomData(param1);
         }
         else if(_type == const_498)
         {
            var_830 = new GuestRoomData(param1);
         }
      }
      
      public function get folderId() : int
      {
         return var_1989;
      }
      
      public function get popupCaption() : String
      {
         return var_1992;
      }
      
      public function get userCount() : int
      {
         return var_1582;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function get showDetails() : Boolean
      {
         return var_1993;
      }
      
      public function get maxUsers() : int
      {
         if(this.type == const_788)
         {
            return 0;
         }
         if(this.type == const_498)
         {
            return this.var_830.maxUserCount;
         }
         if(this.type == const_522)
         {
            return this.var_829.maxUsers;
         }
         return 0;
      }
      
      public function get popupDesc() : String
      {
         return var_1991;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(this.var_830 != null)
         {
            this.var_830.dispose();
            this.var_830 = null;
         }
         if(this.var_829 != null)
         {
            this.var_829.dispose();
            this.var_829 = null;
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get guestRoomData() : GuestRoomData
      {
         return var_830;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get picText() : String
      {
         return var_1990;
      }
      
      public function get publicRoomData() : PublicRoomData
      {
         return var_829;
      }
      
      public function get picRef() : String
      {
         return var_782;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get tag() : String
      {
         return var_1638;
      }
      
      public function toggleOpen() : void
      {
         _open = !_open;
      }
   }
}
