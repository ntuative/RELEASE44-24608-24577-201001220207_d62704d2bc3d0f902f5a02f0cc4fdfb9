package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPollEvent extends RoomSessionEvent
   {
      
      public static const const_123:String = "RSPE_POLL_CONTENT";
      
      public static const const_112:String = "RSPE_POLL_OFFER";
      
      public static const const_59:String = "RSPE_POLL_ERROR";
       
      
      private var var_915:Array = null;
      
      private var var_1100:String = "";
      
      private var var_1251:String;
      
      private var var_1101:String = "";
      
      private var var_916:int = 0;
      
      private var _id:int = -1;
      
      public function RoomSessionPollEvent(param1:String, param2:IRoomSession, param3:int)
      {
         _id = param3;
         super(param1,param2);
      }
      
      public function get questionArray() : Array
      {
         return var_915;
      }
      
      public function get startMessage() : String
      {
         return var_1100;
      }
      
      public function get summary() : String
      {
         return var_1251;
      }
      
      public function set startMessage(param1:String) : void
      {
         var_1100 = param1;
      }
      
      public function set numQuestions(param1:int) : void
      {
         var_916 = param1;
      }
      
      public function set summary(param1:String) : void
      {
         var_1251 = param1;
      }
      
      public function get numQuestions() : int
      {
         return var_916;
      }
      
      public function set endMessage(param1:String) : void
      {
         var_1101 = param1;
      }
      
      public function get endMessage() : String
      {
         return var_1101;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set questionArray(param1:Array) : void
      {
         var_915 = param1;
      }
   }
}
