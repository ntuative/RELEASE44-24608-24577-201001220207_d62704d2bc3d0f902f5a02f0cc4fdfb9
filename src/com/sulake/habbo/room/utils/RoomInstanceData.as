package com.sulake.habbo.room.utils
{
   public class RoomInstanceData
   {
       
      
      private var var_788:LegacyWallGeometry = null;
      
      private var var_530:SelectedRoomObjectData = null;
      
      private var _roomCategory:int = 0;
      
      private var var_529:TileHeightMap = null;
      
      private var var_1779:String = null;
      
      private var _roomId:int = 0;
      
      private var var_787:RoomCamera = null;
      
      public function RoomInstanceData(param1:int, param2:int)
      {
         super();
         _roomId = param1;
         _roomCategory = param2;
         var_788 = new LegacyWallGeometry();
         var_787 = new RoomCamera();
      }
      
      public function set tileHeightMap(param1:TileHeightMap) : void
      {
         if(var_529 != null)
         {
            var_529.dispose();
         }
         var_529 = param1;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set worldType(param1:String) : void
      {
         var_1779 = param1;
      }
      
      public function get legacyGeometry() : LegacyWallGeometry
      {
         return var_788;
      }
      
      public function get roomCamera() : RoomCamera
      {
         return var_787;
      }
      
      public function dispose() : void
      {
         if(var_529 != null)
         {
            var_529.dispose();
            var_529 = null;
         }
         if(var_788 != null)
         {
            var_788.dispose();
            var_788 = null;
         }
         if(var_787 != null)
         {
            var_787.dispose();
            var_787 = null;
         }
         if(var_530 != null)
         {
            var_530.dispose();
            var_530 = null;
         }
      }
      
      public function get tileHeightMap() : TileHeightMap
      {
         return var_529;
      }
      
      public function get worldType() : String
      {
         return var_1779;
      }
      
      public function set selectedObject(param1:SelectedRoomObjectData) : void
      {
         if(var_530 != null)
         {
            var_530.dispose();
         }
         var_530 = param1;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get selectedObject() : SelectedRoomObjectData
      {
         return var_530;
      }
   }
}
