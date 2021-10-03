package com.sulake.habbo.avatar.pets
{
   public class PetEditorInfo
   {
       
      
      private var var_1880:Boolean;
      
      private var var_1879:Boolean;
      
      public function PetEditorInfo(param1:XML)
      {
         super();
         var_1880 = Boolean(parseInt(param1.@club));
         var_1879 = Boolean(parseInt(param1.@selectable));
      }
      
      public function get isClub() : Boolean
      {
         return var_1880;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_1879;
      }
   }
}
