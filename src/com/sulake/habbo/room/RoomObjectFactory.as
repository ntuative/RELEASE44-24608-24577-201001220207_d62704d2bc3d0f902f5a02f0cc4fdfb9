package com.sulake.habbo.room
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.room.object.RoomObjectLogicEnum;
   import com.sulake.habbo.room.object.logic.AvatarLogic;
   import com.sulake.habbo.room.object.logic.PetLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomDimmerLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureShadowLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic;
   import com.sulake.habbo.room.object.logic.furniture.FurnitureWindowLogic;
   import com.sulake.habbo.room.object.logic.room.RoomLogic;
   import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic;
   import com.sulake.habbo.room.object.logic.room.SelectionArrowLogic;
   import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomLogic;
   import com.sulake.habbo.room.object.logic.room.publicroom.PublicRoomParkLogic;
   import com.sulake.room.IRoomObjectFactory;
   import com.sulake.room.IRoomObjectManager;
   import com.sulake.room.RoomObjectManager;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   
   public class RoomObjectFactory extends Component implements IRoomObjectFactory
   {
       
      
      public function RoomObjectFactory(param1:IContext, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function createRoomObjectLogic(param1:String) : IRoomObjectEventHandler
      {
         var _loc4_:* = null;
         Logger.log("Creating room object logic instance of type: " + param1);
         var _loc2_:* = null;
         switch(param1)
         {
            case RoomObjectLogicEnum.const_168:
               _loc2_ = RoomLogic;
               break;
            case RoomObjectLogicEnum.const_263:
               _loc2_ = PublicRoomLogic;
               break;
            case RoomObjectLogicEnum.const_229:
               _loc2_ = PublicRoomParkLogic;
               break;
            case RoomObjectLogicEnum.const_129:
            case RoomObjectLogicEnum.BOT:
               _loc2_ = AvatarLogic;
               break;
            case RoomObjectLogicEnum.PET:
               _loc2_ = PetLogic;
               break;
            case RoomObjectLogicEnum.const_1297:
               _loc2_ = FurnitureLogic;
               break;
            case RoomObjectLogicEnum.const_1177:
               _loc2_ = FurnitureMultiStateLogic;
               break;
            case RoomObjectLogicEnum.const_1332:
               _loc2_ = FurnitureRandomStateLogic;
               break;
            case RoomObjectLogicEnum.const_163:
               _loc2_ = FurnitureShadowLogic;
               break;
            case RoomObjectLogicEnum.const_1197:
               _loc2_ = FurniturePlaceholderLogic;
               break;
            case RoomObjectLogicEnum.const_1239:
               _loc2_ = FurnitureCreditLogic;
               break;
            case RoomObjectLogicEnum.const_1135:
               _loc2_ = FurnitureStickieLogic;
               break;
            case RoomObjectLogicEnum.const_1260:
               _loc2_ = FurniturePresentLogic;
               break;
            case RoomObjectLogicEnum.const_1232:
               _loc2_ = FurnitureTrophyLogic;
               break;
            case RoomObjectLogicEnum.const_1143:
               _loc2_ = FurnitureEcotronBoxLogic;
               break;
            case RoomObjectLogicEnum.const_1349:
               _loc2_ = FurnitureDiceLogic;
               break;
            case RoomObjectLogicEnum.const_1179:
               _loc2_ = FurnitureHockeyScoreLogic;
               break;
            case RoomObjectLogicEnum.const_236:
               _loc2_ = FurnitureHabboWheelLogic;
               break;
            case RoomObjectLogicEnum.const_1322:
               _loc2_ = FurnitureOneWayDoorLogic;
               break;
            case RoomObjectLogicEnum.const_235:
               _loc2_ = FurniturePlanetSystemLogic;
               break;
            case RoomObjectLogicEnum.const_1126:
               _loc2_ = FurnitureWindowLogic;
               break;
            case RoomObjectLogicEnum.const_1283:
               _loc2_ = FurnitureRoomDimmerLogic;
               break;
            case RoomObjectLogicEnum.const_259:
               _loc2_ = RoomTileCursorLogic;
               break;
            case RoomObjectLogicEnum.const_224:
               _loc2_ = SelectionArrowLogic;
               break;
            case RoomObjectLogicEnum.const_1157:
               _loc2_ = FurnitureSoundMachineLogic;
               break;
            case RoomObjectLogicEnum.const_1290:
               _loc2_ = FurnitureJukeboxLogic;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Object = new _loc2_();
         if(_loc3_ is IRoomObjectEventHandler)
         {
            _loc4_ = _loc3_ as IRoomObjectEventHandler;
            _loc4_.eventDispatcher = this.events;
            return _loc4_;
         }
         return null;
      }
      
      public function createRoomObjectManager() : IRoomObjectManager
      {
         return new RoomObjectManager();
      }
   }
}
