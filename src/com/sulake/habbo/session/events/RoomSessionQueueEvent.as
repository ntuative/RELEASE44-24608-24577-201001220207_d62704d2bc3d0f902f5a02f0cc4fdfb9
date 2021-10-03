package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionQueueEvent extends RoomSessionEvent
   {
      
      public static const const_467:String = "RSQE_QUEUE_STATUS";
      
      public static const const_939:int = 2;
      
      public static const const_890:String = "c";
      
      public static const const_1288:String = "d";
      
      public static const const_827:int = 1;
       
      
      private var var_1092:Map;
      
      private var _name:String;
      
      private var var_2333:String;
      
      private var var_260:Boolean;
      
      private var _target:int;
      
      public function RoomSessionQueueEvent(param1:IRoomSession, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super(const_467,param1,param5,param6);
         _name = param2;
         _target = param3;
         var_1092 = new Map();
         var_260 = param4;
      }
      
      public function getQueueSize(param1:String) : int
      {
         return var_1092.getValue(param1);
      }
      
      public function get queueTypes() : Array
      {
         return var_1092.getKeys();
      }
      
      public function get queueSetTarget() : int
      {
         return _target;
      }
      
      public function get isActive() : Boolean
      {
         return var_260;
      }
      
      public function get queueSetName() : String
      {
         return _name;
      }
      
      public function addQueue(param1:String, param2:int) : void
      {
         var_1092.add(param1,param2);
      }
   }
}
