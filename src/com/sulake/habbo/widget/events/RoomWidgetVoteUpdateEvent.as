package com.sulake.habbo.widget.events
{
   public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_127:String = "RWPUE_VOTE_RESULT";
      
      public static const const_106:String = "RWPUE_VOTE_QUESTION";
       
      
      private var var_1102:int;
      
      private var var_1019:String;
      
      private var var_616:Array;
      
      private var var_917:Array;
      
      public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array = null, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_1019 = param2;
         var_917 = param3;
         var_616 = param4;
         if(var_616 == null)
         {
            var_616 = [];
         }
         var_1102 = param5;
      }
      
      public function get votes() : Array
      {
         return var_616.slice();
      }
      
      public function get totalVotes() : int
      {
         return var_1102;
      }
      
      public function get question() : String
      {
         return var_1019;
      }
      
      public function get choices() : Array
      {
         return var_917.slice();
      }
   }
}
