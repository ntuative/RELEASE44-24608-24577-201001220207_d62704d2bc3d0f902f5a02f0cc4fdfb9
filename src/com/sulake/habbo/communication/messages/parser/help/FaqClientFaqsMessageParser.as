package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class FaqClientFaqsMessageParser implements IMessageParser
   {
       
      
      private var var_708:Map;
      
      private var var_707:Map;
      
      public function FaqClientFaqsMessageParser()
      {
         super();
      }
      
      public function get normalData() : Map
      {
         return var_708;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var_707 = new Map();
         var_708 = new Map();
         _loc5_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            var_707.add(_loc2_,_loc3_);
            _loc4_++;
         }
         _loc5_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            var_708.add(_loc2_,_loc3_);
            _loc4_++;
         }
         return true;
      }
      
      public function get urgentData() : Map
      {
         return var_707;
      }
      
      public function flush() : Boolean
      {
         if(var_707 != null)
         {
            var_707.dispose();
         }
         var_707 = null;
         if(var_708 != null)
         {
            var_708.dispose();
         }
         var_708 = null;
         return true;
      }
   }
}
