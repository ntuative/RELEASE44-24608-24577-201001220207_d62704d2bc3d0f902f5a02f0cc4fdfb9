package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class UserObjectMessageParser implements IMessageParser
   {
       
      
      private var _id:int;
      
      private var var_558:String;
      
      private var var_2259:String;
      
      private var var_2260:int;
      
      private var var_2258:int;
      
      private var var_1184:String;
      
      private var var_1120:String;
      
      private var _name:String;
      
      private var var_455:int;
      
      private var var_784:int;
      
      private var var_2257:int;
      
      private var _respectTotal:int;
      
      private var var_2261:String;
      
      public function UserObjectMessageParser()
      {
         super();
      }
      
      public function get directMail() : int
      {
         return this.var_2258;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get realName() : String
      {
         return this.var_1120;
      }
      
      public function get customData() : String
      {
         return this.var_2259;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get petRespectLeft() : int
      {
         return this.var_455;
      }
      
      public function get photoFilm() : int
      {
         return this.var_2260;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get poolFigure() : String
      {
         return this.var_2261;
      }
      
      public function get figure() : String
      {
         return this.var_558;
      }
      
      public function get respectTotal() : int
      {
         return this._respectTotal;
      }
      
      public function get sex() : String
      {
         return this.var_1184;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._id = int(param1.readString());
         this._name = param1.readString();
         this.var_558 = param1.readString();
         this.var_1184 = param1.readString();
         this.var_2259 = param1.readString();
         this.var_1120 = param1.readString();
         this.var_2257 = param1.readInteger();
         this.var_2261 = param1.readString();
         this.var_2260 = param1.readInteger();
         this.var_2258 = param1.readInteger();
         this._respectTotal = param1.readInteger();
         this.var_784 = param1.readInteger();
         this.var_455 = param1.readInteger();
         return true;
      }
      
      public function get tickets() : int
      {
         return this.var_2257;
      }
      
      public function get respectLeft() : int
      {
         return this.var_784;
      }
   }
}
