package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PublicSpaceCastLibsMessageParser implements IMessageParser
   {
       
      
      private var var_1840:int;
      
      private var var_2110:String;
      
      private var var_1211:int;
      
      public function PublicSpaceCastLibsMessageParser()
      {
         super();
      }
      
      public function get unitPort() : int
      {
         return var_1840;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get castLibs() : String
      {
         return var_2110;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1211 = param1.readInteger();
         this.var_2110 = param1.readString();
         this.var_1840 = param1.readInteger();
         return true;
      }
      
      public function get nodeId() : int
      {
         return var_1211;
      }
   }
}
