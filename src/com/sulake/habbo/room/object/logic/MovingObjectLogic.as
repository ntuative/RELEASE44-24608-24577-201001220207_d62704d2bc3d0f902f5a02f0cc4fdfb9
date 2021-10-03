package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.logic.ObjectLogicBase;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.utils.getTimer;
   
   public class MovingObjectLogic extends ObjectLogicBase
   {
       
      
      private var var_78:Vector3d;
      
      private var var_2315:Vector3d;
      
      private var var_1389:int = 500;
      
      private var var_226:Vector3d;
      
      private var var_938:Vector3d;
      
      private var var_1741:int;
      
      public function MovingObjectLogic()
      {
         super();
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_938 != null)
         {
            _loc1_ = getTimer() - var_1741;
            if(_loc1_ > var_1389)
            {
               _loc1_ = var_1389;
            }
            _loc2_ = Vector3d.product(var_938,_loc1_ / Number(var_1389));
            _loc3_ = Vector3d.sum(var_78,_loc2_);
            if(object != null)
            {
               object.setLocation(_loc3_);
            }
            if(_loc1_ == var_1389)
            {
               var_938 = null;
            }
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
         if(_loc2_ == null)
         {
            return;
         }
         if(object != null)
         {
            if(param1.loc != null)
            {
               var_78 = new Vector3d(param1.loc.x,param1.loc.y,param1.loc.z);
               _loc3_ = _loc2_.targetLoc;
               _loc4_ = Vector3d.dif(_loc3_,var_78);
               var_1741 = getTimer();
               var_938 = _loc4_;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
