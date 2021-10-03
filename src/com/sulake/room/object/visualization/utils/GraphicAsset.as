package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import flash.display.BitmapData;
   
   public class GraphicAsset implements IGraphicAsset
   {
       
      
      private var _height:int;
      
      private var _width:int;
      
      private var var_990:Boolean;
      
      private var _offsetX:int;
      
      private var var_794:int;
      
      private var _name:String;
      
      private var var_827:IAsset;
      
      private var var_989:Boolean;
      
      public function GraphicAsset(param1:String, param2:IAsset, param3:Boolean, param4:Boolean, param5:int, param6:int)
      {
         var _loc8_:* = null;
         super();
         _name = param1;
         var _loc7_:BitmapDataAsset = param2 as BitmapDataAsset;
         if(_loc7_ != null)
         {
            _loc8_ = _loc7_.content as BitmapData;
         }
         if(_loc8_ != null)
         {
            var_827 = param2;
            _width = _loc8_.width;
            _height = _loc8_.height;
         }
         else
         {
            var_827 = null;
            _width = 0;
            _height = 0;
         }
         var_989 = param3;
         var_990 = param4;
         _offsetX = param5;
         var_794 = param6;
      }
      
      public function get flipH() : Boolean
      {
         return var_989;
      }
      
      public function get flipV() : Boolean
      {
         return var_990;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function dispose() : void
      {
         var_827 = null;
      }
      
      public function get offsetX() : int
      {
         if(!var_989)
         {
            return _offsetX;
         }
         return -(_width + _offsetX);
      }
      
      public function get offsetY() : int
      {
         if(!var_990)
         {
            return var_794;
         }
         return -(_height + var_794);
      }
      
      public function get asset() : IAsset
      {
         return var_827;
      }
   }
}
