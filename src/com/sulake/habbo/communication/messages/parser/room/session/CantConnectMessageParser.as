package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CantConnectMessageParser implements IMessageParser
   {
      
      public static const const_1451:int = 2;
      
      public static const const_309:int = 4;
      
      public static const const_1204:int = 1;
      
      public static const const_1181:int = 3;
       
      
      private var var_924:int = 0;
      
      private var var_761:String = "";
      
      public function CantConnectMessageParser()
      {
         super();
      }
      
      public function get reason() : int
      {
         return var_924;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_924 = param1.readInteger();
         if(var_924 == 3)
         {
            var_761 = param1.readString();
         }
         else
         {
            var_761 = "";
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_924 = 0;
         var_761 = "";
         return true;
      }
      
      public function get parameter() : String
      {
         return var_761;
      }
   }
}
