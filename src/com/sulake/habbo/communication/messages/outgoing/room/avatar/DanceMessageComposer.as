package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class DanceMessageComposer implements IMessageComposer
   {
       
      
      private var var_89:int;
      
      public function DanceMessageComposer(param1:int)
      {
         super();
         var_89 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_89];
      }
   }
}
