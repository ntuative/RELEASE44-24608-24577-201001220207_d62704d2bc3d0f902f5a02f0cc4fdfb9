package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboSearchResultData
   {
       
      
      private var var_2270:Boolean;
      
      private var var_2269:int;
      
      private var var_2268:Boolean;
      
      private var var_1428:String;
      
      private var var_1120:String;
      
      private var var_1857:int;
      
      private var var_1896:String;
      
      private var var_2271:String;
      
      private var var_1897:String;
      
      public function HabboSearchResultData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1857 = param1.readInteger();
         this.var_1428 = param1.readString();
         this.var_1896 = param1.readString();
         this.var_2270 = param1.readBoolean();
         this.var_2268 = param1.readBoolean();
         param1.readString();
         this.var_2269 = param1.readInteger();
         this.var_1897 = param1.readString();
         this.var_2271 = param1.readString();
         this.var_1120 = param1.readString();
      }
      
      public function get realName() : String
      {
         return this.var_1120;
      }
      
      public function get avatarName() : String
      {
         return this.var_1428;
      }
      
      public function get avatarId() : int
      {
         return this.var_1857;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.var_2270;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.var_2271;
      }
      
      public function get avatarFigure() : String
      {
         return this.var_1897;
      }
      
      public function get canFollow() : Boolean
      {
         return this.var_2268;
      }
      
      public function get avatarMotto() : String
      {
         return this.var_1896;
      }
      
      public function get avatarGender() : int
      {
         return this.var_2269;
      }
   }
}
