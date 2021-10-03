package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class VersionCheckMessageComposer implements IMessageComposer
   {
       
      
      private var var_1580:String;
      
      private var var_1225:String;
      
      private var var_1581:int;
      
      public function VersionCheckMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         var_1581 = param1;
         var_1225 = param2;
         var_1580 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1581,var_1225,var_1580];
      }
      
      public function dispose() : void
      {
      }
   }
}
