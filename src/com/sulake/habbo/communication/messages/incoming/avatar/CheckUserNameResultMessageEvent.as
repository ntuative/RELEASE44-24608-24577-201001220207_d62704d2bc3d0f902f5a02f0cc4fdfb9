package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   
   public class CheckUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public static var var_1054:int = 3;
      
      public static var var_1056:int = 5;
      
      public static var var_885:int = 0;
      
      public static var var_1052:int = 4;
      
      public static var var_1053:int = 2;
      
      public static var var_1055:int = 1;
       
      
      public function CheckUserNameResultMessageEvent(param1:Function)
      {
         super(param1,CheckUserNameResultMessageParser);
      }
      
      public function getParser() : CheckUserNameResultMessageParser
      {
         return var_21 as CheckUserNameResultMessageParser;
      }
   }
}
