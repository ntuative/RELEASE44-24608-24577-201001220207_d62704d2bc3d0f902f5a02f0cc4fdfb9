package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PetReceivedMessageParser implements IMessageParser
   {
       
      
      private var var_978:PetData;
      
      private var var_1439:Boolean;
      
      public function PetReceivedMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1439 = param1.readBoolean();
         var_978 = new PetData(param1);
         Logger.log("Got PetReceived: " + var_1439 + ", " + var_978.id + ", " + var_978.name + ", " + pet.figure + ", " + var_978.type);
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get boughtAsGift() : Boolean
      {
         return var_1439;
      }
      
      public function get pet() : PetData
      {
         return var_978;
      }
   }
}
