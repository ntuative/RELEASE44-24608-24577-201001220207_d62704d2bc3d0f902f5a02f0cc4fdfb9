package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RoomDimmerSavePresetMessageComposer implements IMessageComposer
   {
       
      
      private var var_1799:int;
      
      private var var_1798:int;
      
      private var var_1943:Boolean;
      
      private var var_1945:String;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1944:int;
      
      public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int = 0, param7:int = 0)
      {
         super();
         _roomId = param6;
         _roomCategory = param7;
         var_1798 = param1;
         var_1799 = param2;
         var_1945 = param3;
         var_1944 = param4;
         var_1943 = param5;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1798,var_1799,var_1945,var_1944,int(var_1943)];
      }
      
      public function dispose() : void
      {
      }
   }
}
