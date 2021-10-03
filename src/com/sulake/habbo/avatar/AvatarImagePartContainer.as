package com.sulake.habbo.avatar
{
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
       
      
      private var _frames:Array;
      
      private var var_2104:int;
      
      private var var_2107:String;
      
      private var var_1406:IActionDefinition;
      
      private var var_2105:Boolean;
      
      private var _color:IPartColor;
      
      private var var_2106:String;
      
      private var var_2108:String;
      
      private var var_1790:Boolean;
      
      private var var_2109:ColorTransform;
      
      private var var_1791:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:int, param4:IPartColor, param5:Array, param6:IActionDefinition, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         var_2107 = param1;
         var_2106 = param2;
         var_2104 = param3;
         _color = param4;
         _frames = param5;
         var_1406 = param6;
         var_1790 = param7;
         var_1791 = param8;
         var_2108 = param9;
         var_2105 = param10;
         var_2109 = new ColorTransform(1,1,1,param11);
      }
      
      public function get isColorable() : Boolean
      {
         return var_1790;
      }
      
      public function get partType() : String
      {
         return var_2106;
      }
      
      public function getFrameIndex(param1:int) : int
      {
         return 0;
      }
      
      public function get paletteMapId() : int
      {
         return var_1791;
      }
      
      public function get isBlendable() : Boolean
      {
         return var_2105;
      }
      
      public function get color() : IPartColor
      {
         return _color;
      }
      
      public function get partId() : int
      {
         return var_2104;
      }
      
      public function get flippedPartType() : String
      {
         return var_2108;
      }
      
      public function get bodyPartId() : String
      {
         return var_2107;
      }
      
      public function get action() : IActionDefinition
      {
         return var_1406;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return var_2109;
      }
   }
}
