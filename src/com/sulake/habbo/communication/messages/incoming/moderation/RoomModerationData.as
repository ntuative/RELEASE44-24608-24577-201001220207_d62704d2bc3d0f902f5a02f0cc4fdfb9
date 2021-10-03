package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomModerationData implements IDisposable
   {
       
      
      private var var_125:RoomData;
      
      private var _disposed:Boolean;
      
      private var var_1582:int;
      
      private var var_413:int;
      
      private var var_623:RoomData;
      
      private var var_1584:int;
      
      private var _ownerName:String;
      
      private var var_1583:Boolean;
      
      public function RoomModerationData(param1:IMessageDataWrapper)
      {
         super();
         var_413 = param1.readInteger();
         var_1582 = param1.readInteger();
         var_1583 = param1.readBoolean();
         var_1584 = param1.readInteger();
         _ownerName = param1.readString();
         var_125 = new RoomData(param1);
         var_623 = new RoomData(param1);
      }
      
      public function get userCount() : int
      {
         return var_1582;
      }
      
      public function get event() : RoomData
      {
         return var_623;
      }
      
      public function get room() : RoomData
      {
         return var_125;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_125 != null)
         {
            var_125.dispose();
            var_125 = null;
         }
         if(var_623 != null)
         {
            var_623.dispose();
            var_623 = null;
         }
      }
      
      public function get flatId() : int
      {
         return var_413;
      }
      
      public function get ownerId() : int
      {
         return var_1584;
      }
      
      public function get ownerInRoom() : Boolean
      {
         return var_1583;
      }
   }
}
