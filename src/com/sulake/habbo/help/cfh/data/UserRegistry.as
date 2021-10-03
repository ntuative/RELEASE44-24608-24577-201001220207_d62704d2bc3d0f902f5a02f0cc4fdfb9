package com.sulake.habbo.help.cfh.data
{
   import com.sulake.core.utils.Map;
   
   public class UserRegistry
   {
      
      private static const const_1053:int = 80;
       
      
      private var var_459:Map;
      
      private var var_645:String = "";
      
      private var var_1152:Array;
      
      public function UserRegistry()
      {
         var_459 = new Map();
         var_1152 = new Array();
         super();
      }
      
      private function addRoomNameForMissing() : void
      {
         var _loc1_:* = null;
         while(false)
         {
            _loc1_ = var_459.getValue(var_1152.shift());
            if(_loc1_ != null)
            {
               _loc1_.roomName = var_645;
            }
         }
      }
      
      public function registerUser(param1:int, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:* = null;
         if(var_459.getValue(param1) != null)
         {
            var_459.remove(param1);
         }
         if(param3)
         {
            _loc4_ = new UserRegistryItem(param1,param2,var_645);
         }
         else
         {
            _loc4_ = new UserRegistryItem(param1,param2);
         }
         if(param3 && var_645 == "")
         {
            var_1152.push(param1);
         }
         var_459.add(param1,_loc4_);
         purgeUserIndex();
      }
      
      public function getRegistry() : Map
      {
         return var_459;
      }
      
      public function unregisterRoom() : void
      {
         var_645 = "";
      }
      
      private function purgeUserIndex() : void
      {
         var _loc1_:int = 0;
         while(var_459.length > const_1053)
         {
            _loc1_ = var_459.getKey(0);
            var_459.remove(_loc1_);
         }
      }
      
      public function registerRoom(param1:String) : void
      {
         var_645 = param1;
         if(var_645 != "")
         {
            addRoomNameForMissing();
         }
      }
   }
}
