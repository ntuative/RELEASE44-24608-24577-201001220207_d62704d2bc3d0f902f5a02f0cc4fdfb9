package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetPetInfoMessageComposer implements IMessageComposer
   {
       
      
      private var var_1096:int;
      
      public function GetPetInfoMessageComposer(param1:int)
      {
         super();
         var_1096 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1096];
      }
      
      public function dispose() : void
      {
      }
   }
}
