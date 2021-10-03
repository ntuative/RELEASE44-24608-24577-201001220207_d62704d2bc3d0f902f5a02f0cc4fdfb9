package com.sulake.habbo.room.object.logic.room.publicroom
{
   import com.sulake.habbo.room.RoomVariableEnum;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.logic.room.RoomLogic;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class PublicRoomLogic extends RoomLogic
   {
       
      
      private var var_961:int = 0;
      
      private var var_778:Boolean = false;
      
      public function PublicRoomLogic()
      {
         super();
      }
      
      public function adDelayTimeout() : void
      {
         if(object == null)
         {
            return;
         }
         var _loc1_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.setNumber(RoomObjectVariableEnum.const_473,Number(false));
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.setString(RoomObjectVariableEnum.const_304,"");
         _loc2_.setString(RoomObjectVariableEnum.const_700,"");
         _loc2_.setNumber(RoomObjectVariableEnum.const_473,Number(false));
         var_778 = true;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:RoomObjectRoomAdUpdateMessage = param1 as RoomObjectRoomAdUpdateMessage;
         if(_loc3_ != null)
         {
            switch(_loc3_.type)
            {
               case RoomObjectRoomAdUpdateMessage.const_946:
                  _loc2_.setString(RoomObjectVariableEnum.const_304,_loc3_.asset);
                  _loc2_.setString(RoomObjectVariableEnum.const_700,_loc3_.clickUrl);
                  _loc2_.setNumber(RoomObjectVariableEnum.const_473,Number(true));
                  var_961 = getTimer() + _loc2_.getNumber(RoomVariableEnum.const_932);
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(var_961 > 0 && getTimer() > var_961)
         {
            adDelayTimeout();
            var_961 = 0;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc7_:* = null;
         super.mouseEvent(param1,param2);
         var _loc3_:RoomSpriteMouseEvent = param1;
         if(_loc3_ == null)
         {
            return;
         }
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = object.getId();
         var _loc6_:String = object.getType();
         switch(_loc3_.type)
         {
            case MouseEvent.CLICK:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_404)
               {
                  _loc7_ = _loc4_.getString(RoomObjectVariableEnum.const_700);
                  if(_loc7_ != null && _loc7_.indexOf("http") == 0)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_268,_loc5_,_loc6_,_loc7_));
                     HabboWebTools.openWebPage(_loc7_);
                  }
               }
               break;
            case MouseEvent.ROLL_OVER:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_404)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_291,_loc5_,_loc6_));
               }
               break;
            case MouseEvent.ROLL_OUT:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_404)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_310,_loc5_,_loc6_));
               }
         }
      }
   }
}
