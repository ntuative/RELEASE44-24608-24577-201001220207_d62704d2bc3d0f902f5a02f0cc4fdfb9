package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class PublicRoomData implements IDisposable
   {
       
      
      private var var_1840:int;
      
      private var var_2110:String;
      
      private var var_1844:int;
      
      private var _disposed:Boolean;
      
      private var var_2111:int;
      
      private var var_2042:String;
      
      private var var_1211:int;
      
      public function PublicRoomData(param1:IMessageDataWrapper)
      {
         super();
         var_2042 = param1.readString();
         var_1840 = param1.readInteger();
         var_1844 = param1.readInteger();
         var_2110 = param1.readString();
         var_2111 = param1.readInteger();
         var_1211 = param1.readInteger();
      }
      
      public function get maxUsers() : int
      {
         return var_2111;
      }
      
      public function get worldId() : int
      {
         return var_1844;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
      }
      
      public function get unitPropertySet() : String
      {
         return var_2042;
      }
      
      public function get unitPort() : int
      {
         return var_1840;
      }
      
      public function get castLibs() : String
      {
         return var_2110;
      }
      
      public function get nodeId() : int
      {
         return var_1211;
      }
   }
}
