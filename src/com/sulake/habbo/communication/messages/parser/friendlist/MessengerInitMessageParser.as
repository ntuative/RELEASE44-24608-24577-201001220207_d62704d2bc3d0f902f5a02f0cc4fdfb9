package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   
   public class MessengerInitMessageParser implements IMessageParser
   {
       
      
      private var var_2252:int;
      
      private var var_2251:int;
      
      private var var_2250:int;
      
      private var var_218:Array;
      
      private var var_2253:int;
      
      private var var_2249:int;
      
      private var var_338:Array;
      
      public function MessengerInitMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_338 = new Array();
         this.var_218 = new Array();
         return true;
      }
      
      public function get extendedFriendLimit() : int
      {
         return this.var_2252;
      }
      
      public function get friends() : Array
      {
         return this.var_218;
      }
      
      public function get normalFriendLimit() : int
      {
         return this.var_2250;
      }
      
      public function get categories() : Array
      {
         return this.var_338;
      }
      
      public function get friendRequestLimit() : int
      {
         return this.var_2251;
      }
      
      public function get userFriendLimit() : int
      {
         return this.var_2249;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         this.var_2249 = param1.readInteger();
         this.var_2250 = param1.readInteger();
         this.var_2252 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            this.var_338.push(new FriendCategoryData(param1));
            _loc4_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.var_218.push(new FriendData(param1));
            _loc4_++;
         }
         this.var_2251 = param1.readInteger();
         this.var_2253 = param1.readInteger();
         return true;
      }
      
      public function get friendRequestCount() : int
      {
         return this.var_2253;
      }
   }
}
