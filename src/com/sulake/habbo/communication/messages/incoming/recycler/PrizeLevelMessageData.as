package com.sulake.habbo.communication.messages.incoming.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeLevelMessageData
   {
       
      
      private var var_1865:int;
      
      private var var_1228:int;
      
      private var var_673:Array;
      
      public function PrizeLevelMessageData(param1:IMessageDataWrapper)
      {
         super();
         var_1228 = param1.readInteger();
         var_1865 = param1.readInteger();
         var_673 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            var_673.push(new PrizeMessageData(param1));
            _loc3_++;
         }
      }
      
      public function get probabilityDenominator() : int
      {
         return var_1865;
      }
      
      public function get prizes() : Array
      {
         return var_673;
      }
      
      public function get prizeLevelId() : int
      {
         return var_1228;
      }
   }
}
