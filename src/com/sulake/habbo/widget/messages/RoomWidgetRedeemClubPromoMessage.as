package com.sulake.habbo.widget.messages
{
   public class RoomWidgetRedeemClubPromoMessage extends RoomWidgetMessage
   {
      
      public static const const_689:String = "rwrcp_redeem_club_promo";
       
      
      private var var_2094:String;
      
      private var var_2093:Boolean;
      
      public function RoomWidgetRedeemClubPromoMessage(param1:String, param2:String, param3:Boolean)
      {
         super(param1);
         var_2094 = param2;
         var_2093 = param3;
      }
      
      public function get code() : String
      {
         return var_2094;
      }
      
      public function get isTrial() : Boolean
      {
         return var_2093;
      }
   }
}
