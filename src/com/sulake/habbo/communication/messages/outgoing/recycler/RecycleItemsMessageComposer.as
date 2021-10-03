package com.sulake.habbo.communication.messages.outgoing.recycler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RecycleItemsMessageComposer implements IMessageComposer
   {
       
      
      private var var_799:Array;
      
      public function RecycleItemsMessageComposer(param1:Array)
      {
         super();
         var_799 = new Array();
         var_799.push(param1.length);
         var_799 = var_799.concat(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_799;
      }
   }
}
