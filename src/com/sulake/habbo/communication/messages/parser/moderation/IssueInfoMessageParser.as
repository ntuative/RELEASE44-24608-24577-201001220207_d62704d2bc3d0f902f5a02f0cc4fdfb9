package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.getTimer;
   
   public class IssueInfoMessageParser implements IMessageParser
   {
       
      
      private var var_65:IssueMessageData;
      
      public function IssueInfoMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_65 = new IssueMessageData();
         var_65.issueId = param1.readInteger();
         var_65.state = param1.readInteger();
         var_65.categoryId = param1.readInteger();
         var_65.reportedCategoryId = param1.readInteger();
         var_65.timeStamp = getTimer() - param1.readInteger();
         var_65.priority = param1.readInteger();
         var_65.reporterUserId = param1.readInteger();
         var_65.reporterUserName = param1.readString();
         var_65.reportedUserId = param1.readInteger();
         var_65.reportedUserName = param1.readString();
         var_65.pickerUserId = param1.readInteger();
         var_65.pickerUserName = param1.readString();
         var_65.message = param1.readString();
         var_65.chatRecordId = param1.readInteger();
         var_65.roomName = param1.readString();
         var_65.roomType = param1.readInteger();
         if(false)
         {
            var_65.roomResources = param1.readString();
            var_65.unitPort = param1.readInteger();
            var_65.worldId = param1.readInteger();
         }
         if(false)
         {
            var_65.flatType = param1.readString();
            var_65.flatId = param1.readInteger();
            var_65.flatOwnerName = param1.readString();
         }
         return true;
      }
      
      public function get issueData() : IssueMessageData
      {
         return var_65;
      }
      
      public function flush() : Boolean
      {
         var_65 = null;
         return true;
      }
   }
}
