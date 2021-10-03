package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomInviteMessageParser implements IMessageParser
   {
       
      
      private var var_1659:String;
      
      private var var_995:int;
      
      public function RoomInviteMessageParser()
      {
         super();
      }
      
      public function get senderId() : int
      {
         return this.var_995;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_995 = param1.readInteger();
         this.var_1659 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get messageText() : String
      {
         return this.var_1659;
      }
   }
}
