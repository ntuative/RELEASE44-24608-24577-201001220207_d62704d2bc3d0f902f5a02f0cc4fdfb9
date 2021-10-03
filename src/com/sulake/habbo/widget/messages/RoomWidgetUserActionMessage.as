package com.sulake.habbo.widget.messages
{
   public class RoomWidgetUserActionMessage extends RoomWidgetMessage
   {
      
      public static const const_554:String = "RWUAM_RESPECT_USER";
      
      public static const const_576:String = "RWUAM_GIVE_RIGHTS";
      
      public static const const_506:String = "RWUAM_START_TRADING";
      
      public static const const_675:String = "RWUAM_TAKE_RIGHTS";
      
      public static const const_684:String = "RWUAM_WHISPER_USER";
      
      public static const const_617:String = "RWUAM_IGNORE_USER";
      
      public static const const_464:String = "RWUAM_REQUEST_PET_UPDATE";
      
      public static const const_728:String = "RWUAM_BAN_USER";
      
      public static const const_712:String = "RWUAM_UNIGNORE_USER";
      
      public static const const_409:String = "RWUAM_KICK_USER";
      
      public static const const_581:String = "RWUAM_SEND_FRIEND_REQUEST";
      
      public static const const_544:String = " RWUAM_RESPECT_PET";
      
      public static const const_442:String = "RWUAM_KICK_BOT";
      
      public static const const_1191:String = "RWUAM_TRAIN_PET";
      
      public static const const_516:String = "RWUAM_PICKUP_PET";
      
      public static const const_640:String = "RWUAM_OPEN_HOME_PAGE";
      
      public static const const_635:String = "RWUAM_REPORT";
       
      
      private var _userId:int = 0;
      
      public function RoomWidgetUserActionMessage(param1:String, param2:int = 0)
      {
         super(param1);
         _userId = param2;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}
