package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LatencyPingReportMessageComposer implements IMessageComposer
   {
       
      
      private var var_1665:int;
      
      private var var_1667:int;
      
      private var var_1666:int;
      
      public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_1665 = param1;
         var_1667 = param2;
         var_1666 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1665,var_1667,var_1666];
      }
   }
}
