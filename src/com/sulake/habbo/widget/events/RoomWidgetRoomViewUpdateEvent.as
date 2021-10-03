package com.sulake.habbo.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_691:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
      
      public static const const_504:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
      
      public static const const_267:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
       
      
      private var var_1336:Point;
      
      private var var_1337:Rectangle;
      
      private var var_200:Number = 0;
      
      public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle = null, param3:Point = null, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_1337 = param2;
         var_1336 = param3;
         var_200 = param4;
      }
      
      public function get rect() : Rectangle
      {
         if(var_1337 != null)
         {
            return var_1337.clone();
         }
         return null;
      }
      
      public function get scale() : Number
      {
         return var_200;
      }
      
      public function get positionDelta() : Point
      {
         if(var_1336 != null)
         {
            return var_1336.clone();
         }
         return null;
      }
   }
}
