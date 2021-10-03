package com.sulake.core.runtime
{
   import flash.utils.getQualifiedClassName;
   
   final class InterfaceStruct implements IDisposable
   {
       
      
      private var var_367:uint;
      
      private var var_904:IUnknown;
      
      private var var_1070:String;
      
      private var var_903:IID;
      
      function InterfaceStruct(param1:IID, param2:IUnknown)
      {
         super();
         var_903 = param1;
         var_1070 = getQualifiedClassName(var_903);
         var_904 = param2;
         var_367 = 0;
      }
      
      public function get iid() : IID
      {
         return var_903;
      }
      
      public function get disposed() : Boolean
      {
         return var_904 == null;
      }
      
      public function get references() : uint
      {
         return var_367;
      }
      
      public function release() : uint
      {
         return references > 0 ? uint(--var_367) : uint(0);
      }
      
      public function get unknown() : IUnknown
      {
         return var_904;
      }
      
      public function get iis() : String
      {
         return var_1070;
      }
      
      public function reserve() : uint
      {
         return ++var_367;
      }
      
      public function dispose() : void
      {
         var_903 = null;
         var_1070 = null;
         var_904 = null;
         var_367 = 0;
      }
   }
}
