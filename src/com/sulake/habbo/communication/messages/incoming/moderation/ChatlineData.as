package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChatlineData
   {
       
      
      private var var_1385:String;
      
      private var var_2193:int;
      
      private var var_2194:int;
      
      private var var_2191:int;
      
      private var var_2192:String;
      
      public function ChatlineData(param1:IMessageDataWrapper)
      {
         super();
         var_2193 = param1.readInteger();
         var_2191 = param1.readInteger();
         var_2194 = param1.readInteger();
         var_2192 = param1.readString();
         var_1385 = param1.readString();
      }
      
      public function get msg() : String
      {
         return var_1385;
      }
      
      public function get hour() : int
      {
         return var_2193;
      }
      
      public function get minute() : int
      {
         return var_2191;
      }
      
      public function get chatterName() : String
      {
         return var_2192;
      }
      
      public function get chatterId() : int
      {
         return var_2194;
      }
   }
}
