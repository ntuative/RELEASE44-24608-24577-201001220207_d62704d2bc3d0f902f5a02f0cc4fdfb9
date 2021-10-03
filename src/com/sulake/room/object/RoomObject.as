package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObject implements IRoomObjectController
   {
      
      private static var var_1182:int = 0;
       
      
      private var var_78:Vector3d;
      
      private var _updateID:int;
      
      private var _type:String = "";
      
      private var _visualization:IRoomObjectVisualization;
      
      private var _model:RoomObjectModel;
      
      private var var_388:IRoomObjectEventHandler;
      
      private var var_1434:Vector3d;
      
      private var var_1902:int = 0;
      
      private var _id:int;
      
      private var var_1435:Vector3d;
      
      private var var_226:Vector3d;
      
      private var var_463:Array;
      
      public function RoomObject(param1:int, param2:int)
      {
         super();
         _id = param1;
         var_78 = new Vector3d();
         var_226 = new Vector3d();
         var_1434 = new Vector3d();
         var_1435 = new Vector3d();
         var_463 = new Array(param2);
         var _loc3_:Number = param2 - 1;
         while(_loc3_ >= 0)
         {
            var_463[_loc3_] = 0;
            _loc3_--;
         }
         _model = new RoomObjectModel();
         _visualization = null;
         var_388 = null;
         _updateID = 0;
         var_1902 = var_1182++;
      }
      
      public function getInstanceId() : int
      {
         return var_1902;
      }
      
      public function getId() : int
      {
         return _id;
      }
      
      public function getUpdateID() : int
      {
         return _updateID;
      }
      
      public function dispose() : void
      {
         var_78 = null;
         var_226 = null;
         if(_model != null)
         {
            _model.dispose();
            _model = null;
         }
         var_463 = null;
         setVisualization(null);
         setEventHandler(null);
      }
      
      public function getType() : String
      {
         return _type;
      }
      
      public function getLocation() : IVector3d
      {
         var_1434.assign(var_78);
         return var_1434;
      }
      
      public function setLocation(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_78.x != param1.x || var_78.y != param1.y || var_78.z != param1.z)
         {
            var_78.x = param1.x;
            var_78.y = param1.y;
            var_78.z = param1.z;
            ++_updateID;
         }
      }
      
      public function setDirection(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_226.x != param1.x || var_226.y != param1.y || var_226.z != param1.z)
         {
            var_226.x = (param1.x % 360 + 360) % 360;
            var_226.y = (param1.y % 360 + 360) % 360;
            var_226.z = (param1.z % 360 + 360) % 360;
            ++_updateID;
         }
      }
      
      public function setType(param1:String) : void
      {
         _type = param1;
      }
      
      public function getEventHandler() : IRoomObjectEventHandler
      {
         return var_388;
      }
      
      public function getDirection() : IVector3d
      {
         var_1435.assign(var_226);
         return var_1435;
      }
      
      public function setState(param1:int, param2:int) : Boolean
      {
         if(param2 >= 0 && param2 < var_463.length)
         {
            if(var_463[param2] != param1)
            {
               var_463[param2] = param1;
               ++_updateID;
            }
            return true;
         }
         return false;
      }
      
      public function setEventHandler(param1:IRoomObjectEventHandler) : void
      {
         if(param1 == var_388)
         {
            return;
         }
         var _loc2_:IRoomObjectEventHandler = var_388;
         if(_loc2_ != null)
         {
            var_388 = null;
            _loc2_.object = null;
         }
         var_388 = param1;
         if(var_388 != null)
         {
            var_388.object = this;
         }
      }
      
      public function getState(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_463.length)
         {
            return var_463[param1];
         }
         return -1;
      }
      
      public function setVisualization(param1:IRoomObjectVisualization) : void
      {
         if(param1 != _visualization)
         {
            if(_visualization != null)
            {
               _visualization.dispose();
            }
            _visualization = param1;
            if(_visualization != null)
            {
               _visualization.object = this;
            }
         }
      }
      
      public function getVisualization() : IRoomObjectVisualization
      {
         return _visualization;
      }
      
      public function getModel() : IRoomObjectModel
      {
         return _model;
      }
      
      public function getModelController() : IRoomObjectModelController
      {
         return _model;
      }
      
      public function getMouseHandler() : IRoomObjectMouseHandler
      {
         return getEventHandler();
      }
   }
}
