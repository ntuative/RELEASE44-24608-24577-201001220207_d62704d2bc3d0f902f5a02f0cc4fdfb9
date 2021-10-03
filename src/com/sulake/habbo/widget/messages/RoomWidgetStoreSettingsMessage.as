package com.sulake.habbo.widget.messages
{
   public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage
   {
      
      public static const const_673:String = "RWSSM_STORE_SOUND";
      
      public static const const_642:String = "RWSSM_PREVIEW_SOUND";
      
      public static const const_1226:String = "RWSSM_STORE_SETTINGS";
       
      
      private var var_618:Number;
      
      public function RoomWidgetStoreSettingsMessage(param1:String)
      {
         super(param1);
      }
      
      public function set volume(param1:Number) : void
      {
         var_618 = param1;
      }
      
      public function get volume() : Number
      {
         return var_618;
      }
   }
}
