package com.sulake.habbo.help.cfh.data
{
   public class CallForHelpData
   {
       
      
      private var var_2207:int;
      
      private var var_1308:String = "";
      
      private var var_1049:int;
      
      public function CallForHelpData()
      {
         super();
      }
      
      public function set reportedUserName(param1:String) : void
      {
         var_1308 = param1;
      }
      
      public function get topicIndex() : int
      {
         return var_2207;
      }
      
      public function set topicIndex(param1:int) : void
      {
         var_2207 = param1;
      }
      
      public function get reportedUserName() : String
      {
         return var_1308;
      }
      
      public function flush() : void
      {
         var_1049 = 0;
         var_1308 = "";
      }
      
      public function get userSelected() : Boolean
      {
         return var_1049 > 0;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_1049 = param1;
      }
      
      public function getTopicKey(param1:int) : String
      {
         return (!!userSelected ? "help.cfh.topicwithharasser." : "help.cfh.topic.") + param1;
      }
      
      public function get reportedUserId() : int
      {
         return var_1049;
      }
   }
}
