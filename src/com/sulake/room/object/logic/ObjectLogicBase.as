package com.sulake.room.object.logic
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.IEventDispatcher;
   
   public class ObjectLogicBase implements IRoomObjectEventHandler
   {
       
      
      private var var_248:IRoomObjectController;
      
      private var _events:IEventDispatcher;
      
      public function ObjectLogicBase()
      {
         super();
      }
      
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         _events = param1;
      }
      
      public function dispose() : void
      {
         var_248 = null;
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return _events;
      }
      
      public function update() : void
      {
      }
      
      public function get object() : IRoomObjectController
      {
         return var_248;
      }
      
      public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 != null)
         {
            if(var_248 != null)
            {
               var_248.setLocation(param1.loc);
               var_248.setDirection(param1.dir);
            }
         }
      }
      
      public function initialize(param1:XML) : void
      {
      }
      
      public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
      }
      
      public function set object(param1:IRoomObjectController) : void
      {
         if(var_248 == param1)
         {
            return;
         }
         if(var_248 != null)
         {
            var_248.setEventHandler(null);
         }
         if(param1 == null)
         {
            dispose();
            var_248 = null;
         }
         else
         {
            var_248 = param1;
            var_248.setEventHandler(this);
         }
      }
   }
}
