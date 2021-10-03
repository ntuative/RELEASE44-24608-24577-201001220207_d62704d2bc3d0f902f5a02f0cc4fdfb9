package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class VoteResultMessageParser implements IMessageParser
   {
       
      
      private var var_1102:int;
      
      private var var_1019:String;
      
      private var var_616:Array;
      
      private var var_917:Array;
      
      public function VoteResultMessageParser()
      {
         super();
      }
      
      public function get votes() : Array
      {
         return var_616.slice();
      }
      
      public function flush() : Boolean
      {
         var_1019 = "";
         var_917 = [];
         var_616 = [];
         var_1102 = 0;
         return true;
      }
      
      public function get totalVotes() : int
      {
         return var_1102;
      }
      
      public function get question() : String
      {
         return var_1019;
      }
      
      public function get choices() : Array
      {
         return var_917.slice();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1019 = param1.readString();
         var_917 = [];
         var_616 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.readInteger();
            var_917.push(param1.readString());
            var_616.push(param1.readInteger());
            _loc3_++;
         }
         var_1102 = param1.readInteger();
         return true;
      }
   }
}
