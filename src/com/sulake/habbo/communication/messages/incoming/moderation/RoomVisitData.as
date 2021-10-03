package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class RoomVisitData
   {
       
      
      private var var_645:String;
      
      private var var_1751:int;
      
      private var var_1443:Boolean;
      
      private var _roomId:int;
      
      private var var_1752:int;
      
      public function RoomVisitData(param1:IMessageDataWrapper)
      {
         super();
         var_1443 = param1.readBoolean();
         _roomId = param1.readInteger();
         var_645 = param1.readString();
         var_1752 = param1.readInteger();
         var_1751 = param1.readInteger();
      }
      
      public function get isPublic() : Boolean
      {
         return var_1443;
      }
      
      public function get roomName() : String
      {
         return var_645;
      }
      
      public function get enterMinute() : int
      {
         return var_1751;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get enterHour() : int
      {
         return var_1752;
      }
   }
}
