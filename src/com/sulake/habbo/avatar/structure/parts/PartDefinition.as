package com.sulake.habbo.avatar.structure.parts
{
   public class PartDefinition
   {
       
      
      private var _removeSetType:String;
      
      private var var_1348:int = -1;
      
      private var var_1082:Boolean;
      
      private var var_1081:String;
      
      private var var_1614:String;
      
      public function PartDefinition(param1:XML)
      {
         super();
         var_1614 = String(param1["set-type"]);
         var_1081 = String(param1["flipped-set-type"]);
         _removeSetType = String(param1["remove-set-type"]);
         var_1082 = false;
      }
      
      public function hasStaticId() : Boolean
      {
         return var_1348 >= 0;
      }
      
      public function get flippedSetType() : String
      {
         return var_1081;
      }
      
      public function get staticId() : int
      {
         return var_1348;
      }
      
      public function set staticId(param1:int) : void
      {
         var_1348 = param1;
      }
      
      public function get appendToFigure() : Boolean
      {
         return var_1082;
      }
      
      public function set appendToFigure(param1:Boolean) : void
      {
         var_1082 = param1;
      }
      
      public function set flippedSetType(param1:String) : void
      {
         var_1081 = param1;
      }
      
      public function get setType() : String
      {
         return var_1614;
      }
      
      public function get removeSetType() : String
      {
         return _removeSetType;
      }
   }
}
