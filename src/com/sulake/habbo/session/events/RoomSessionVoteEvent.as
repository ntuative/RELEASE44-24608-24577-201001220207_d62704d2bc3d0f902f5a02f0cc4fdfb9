package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionVoteEvent extends RoomSessionEvent
   {
      
      public static const const_127:String = "RSPE_VOTE_RESULT";
      
      public static const const_106:String = "RSPE_VOTE_QUESTION";
       
      
      private var var_1102:int = 0;
      
      private var var_1019:String = "";
      
      private var var_616:Array;
      
      private var var_917:Array;
      
      public function RoomSessionVoteEvent(param1:String, param2:IRoomSession, param3:String, param4:Array, param5:Array = null, param6:int = 0, param7:Boolean = false, param8:Boolean = false)
      {
         var_917 = [];
         var_616 = [];
         super(param1,param2,param7,param8);
         var_1019 = param3;
         var_917 = param4;
         var_616 = param5;
         if(var_616 == null)
         {
            var_616 = [];
         }
         var_1102 = param6;
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
