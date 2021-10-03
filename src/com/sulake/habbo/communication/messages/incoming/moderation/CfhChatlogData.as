package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CfhChatlogData
   {
       
      
      private var var_1049:int;
      
      private var var_1736:int;
      
      private var var_1387:int;
      
      private var var_125:RoomChatlogData;
      
      public function CfhChatlogData(param1:IMessageDataWrapper)
      {
         super();
         var_1387 = param1.readInteger();
         var_1736 = param1.readInteger();
         var_1049 = param1.readInteger();
         var_125 = new RoomChatlogData(param1);
         Logger.log("READ CFHCHATLOGDATA: callId: " + var_1387);
      }
      
      public function get reportedUserId() : int
      {
         return var_1049;
      }
      
      public function get callerUserId() : int
      {
         return var_1736;
      }
      
      public function get callId() : int
      {
         return var_1387;
      }
      
      public function get room() : RoomChatlogData
      {
         return var_125;
      }
   }
}
