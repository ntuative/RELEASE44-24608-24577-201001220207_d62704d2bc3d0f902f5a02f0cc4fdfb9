package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendData
   {
       
      
      private var var_558:String;
      
      private var var_1119:String;
      
      private var var_1118:String;
      
      private var var_1098:int;
      
      private var _gender:int;
      
      private var var_1120:String;
      
      private var _name:String;
      
      private var var_1105:Boolean;
      
      private var var_656:Boolean;
      
      private var _id:int;
      
      public function FriendData(param1:IMessageDataWrapper)
      {
         super();
         this._id = param1.readInteger();
         this._name = param1.readString();
         this._gender = param1.readInteger();
         this.var_656 = param1.readBoolean();
         this.var_1105 = param1.readBoolean();
         this.var_558 = param1.readString();
         this.var_1098 = param1.readInteger();
         this.var_1118 = param1.readString();
         this.var_1119 = param1.readString();
         this.var_1120 = param1.readString();
      }
      
      public function get gender() : int
      {
         return _gender;
      }
      
      public function get realName() : String
      {
         return var_1120;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get motto() : String
      {
         return var_1118;
      }
      
      public function get categoryId() : int
      {
         return var_1098;
      }
      
      public function get online() : Boolean
      {
         return var_656;
      }
      
      public function get followingAllowed() : Boolean
      {
         return var_1105;
      }
      
      public function get lastAccess() : String
      {
         return var_1119;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get figure() : String
      {
         return var_558;
      }
   }
}
