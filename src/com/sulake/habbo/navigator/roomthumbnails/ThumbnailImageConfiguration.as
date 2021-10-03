package com.sulake.habbo.navigator.roomthumbnails
{
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ThumbnailImageConfiguration
   {
       
      
      private var _selected:Boolean;
      
      private var var_2072:BitmapData;
      
      private var var_695:IBitmapWrapperWindow;
      
      private var var_1502:int = 1;
      
      private var _navigator:HabboNavigator;
      
      private var _type:int;
      
      private var var_2073:BitmapData;
      
      private var var_2071:Rectangle;
      
      private var var_2074:String;
      
      private var _id:int;
      
      public function ThumbnailImageConfiguration(param1:HabboNavigator, param2:int, param3:int, param4:String, param5:BitmapData)
      {
         super();
         this._navigator = param1;
         this._id = param2;
         this._type = param3;
         this.var_2074 = param4;
         this.var_2073 = param5;
      }
      
      public function method_5() : BitmapData
      {
         if(this.var_2072 == null)
         {
            this.var_2072 = this._navigator.getButtonImage(this.var_2074);
         }
         return this.var_2072;
      }
      
      public function copyTo(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = this.method_5();
         param1.copyPixels(_loc2_,_loc2_.rect,new Point((param1.width - _loc2_.width) / 2,param1.height - _loc2_.height),null,null,true);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         refreshListImg();
      }
      
      public function registerListImg(param1:IBitmapWrapperWindow) : void
      {
         this.var_695 = param1;
         refreshListImg();
      }
      
      private function refreshListImg() : void
      {
         var _loc1_:* = null;
         if(this.var_2071 == null)
         {
            _loc1_ = var_695.bitmap.rect;
            this.var_2071 = new Rectangle(var_1502,var_1502,_loc1_.width - 2 * var_1502,_loc1_.height - 2 * var_1502);
         }
         var_695.bitmap.fillRect(var_695.bitmap.rect,4281545523);
         var_695.bitmap.fillRect(this.var_2071,4284900966);
         copyTo(var_695.bitmap);
         if(_selected)
         {
            var_695.bitmap.copyPixels(var_2073,var_2073.rect,new Point(0,0),null,null,true);
         }
         var_695.invalidate();
      }
      
      public function get picName() : String
      {
         return this.var_2074;
      }
   }
}
