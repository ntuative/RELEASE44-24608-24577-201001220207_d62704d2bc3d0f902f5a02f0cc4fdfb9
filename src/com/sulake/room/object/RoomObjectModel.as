package com.sulake.room.object
{
   import flash.utils.Dictionary;
   
   public class RoomObjectModel implements IRoomObjectModelController
   {
       
      
      private var _updateID:int;
      
      private var _stringArrayReadOnlyList:Array;
      
      private var _numberArrayReadOnlyList:Array;
      
      private var var_466:Dictionary;
      
      private var var_468:Dictionary;
      
      private var var_976:Array;
      
      private var var_465:Dictionary;
      
      private var var_977:Array;
      
      private var var_467:Dictionary;
      
      public function RoomObjectModel()
      {
         super();
         var_465 = new Dictionary();
         var_467 = new Dictionary();
         var_468 = new Dictionary();
         var_466 = new Dictionary();
         var_976 = [];
         var_977 = [];
         _numberArrayReadOnlyList = [];
         _stringArrayReadOnlyList = [];
         _updateID = 0;
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(var_976.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_976.push(param1);
         }
         if(var_465[param1] != param2)
         {
            var_465[param1] = param2;
            ++_updateID;
         }
      }
      
      public function setStringArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(_stringArrayReadOnlyList.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            _stringArrayReadOnlyList.push(param1);
         }
         var _loc4_:* = [];
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_] is String)
            {
               _loc4_.push(param2[_loc5_]);
            }
            _loc5_++;
         }
         var _loc6_:Array = var_466[param1];
         var _loc7_:Boolean = true;
         if(_loc6_ != null && _loc6_.length == _loc4_.length)
         {
            _loc5_ = _loc4_.length - 1;
            while(_loc5_ >= 0)
            {
               if(_loc4_[_loc5_] as String != _loc6_[_loc5_] as String)
               {
                  _loc7_ = false;
                  break;
               }
               _loc5_--;
            }
         }
         else
         {
            _loc7_ = false;
         }
         if(_loc7_)
         {
            return;
         }
         var_466[param1] = _loc4_;
         ++_updateID;
      }
      
      public function getNumber(param1:String) : Number
      {
         return var_465[param1];
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(var_977.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_977.push(param1);
         }
         if(var_467[param1] != param2)
         {
            var_467[param1] = param2;
            ++_updateID;
         }
      }
      
      public function setNumberArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(_numberArrayReadOnlyList.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            _numberArrayReadOnlyList.push(param1);
         }
         var _loc4_:* = [];
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_] is Number)
            {
               _loc4_.push(param2[_loc5_]);
            }
            _loc5_++;
         }
         var _loc6_:Array = var_468[param1];
         var _loc7_:Boolean = true;
         if(_loc6_ != null && _loc6_.length == _loc4_.length)
         {
            _loc5_ = _loc4_.length - 1;
            while(_loc5_ >= 0)
            {
               if(_loc4_[_loc5_] as Number != _loc6_[_loc5_] as Number)
               {
                  _loc7_ = false;
                  break;
               }
               _loc5_--;
            }
         }
         else
         {
            _loc7_ = false;
         }
         if(_loc7_)
         {
            return;
         }
         var_468[param1] = _loc4_;
         ++_updateID;
      }
      
      public function getString(param1:String) : String
      {
         return var_467[param1];
      }
      
      public function getNumberArray(param1:String) : Array
      {
         var _loc2_:Array = var_468[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(var_465 != null)
         {
            for(_loc1_ in var_465)
            {
               delete var_465[_loc1_];
            }
            var_465 = null;
         }
         if(var_467 != null)
         {
            for(_loc1_ in var_467)
            {
               delete var_467[_loc1_];
            }
            var_467 = null;
         }
         if(var_468 != null)
         {
            for(_loc1_ in var_468)
            {
               delete var_468[_loc1_];
            }
            var_468 = null;
         }
         if(var_466 != null)
         {
            for(_loc1_ in var_466)
            {
               delete var_466[_loc1_];
            }
            var_466 = null;
         }
         var_977 = [];
         var_976 = [];
         _stringArrayReadOnlyList = [];
         _numberArrayReadOnlyList = [];
      }
      
      public function getStringArray(param1:String) : Array
      {
         var _loc2_:Array = var_466[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getUpdateID() : int
      {
         return _updateID;
      }
   }
}
