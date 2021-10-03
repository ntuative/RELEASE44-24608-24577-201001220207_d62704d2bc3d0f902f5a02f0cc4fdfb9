package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   
   public class RoomEntryInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1595:int;
      
      private var var_412:Boolean;
      
      private var var_1596:Boolean;
      
      private var var_732:PublicRoomShortData;
      
      public function RoomEntryInfoMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1596 = param1.readBoolean();
         if(var_1596)
         {
            var_1595 = param1.readInteger();
            var_412 = param1.readBoolean();
         }
         else
         {
            var_732 = new PublicRoomShortData(param1);
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         if(var_732 != null)
         {
            var_732.dispose();
            var_732 = null;
         }
         return true;
      }
      
      public function get guestRoomId() : int
      {
         return var_1595;
      }
      
      public function get owner() : Boolean
      {
         return var_412;
      }
      
      public function get guestRoom() : Boolean
      {
         return var_1596;
      }
      
      public function get publicSpace() : PublicRoomShortData
      {
         return var_732;
      }
   }
}
