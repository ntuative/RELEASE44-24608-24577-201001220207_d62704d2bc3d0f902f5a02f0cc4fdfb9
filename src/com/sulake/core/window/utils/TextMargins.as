package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   
   public class TextMargins implements IMargins, IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_742:int;
      
      private var _right:int;
      
      private var var_743:int;
      
      private var var_744:int;
      
      private var var_186:Function;
      
      public function TextMargins(param1:int, param2:int, param3:int, param4:int, param5:Function)
      {
         super();
         var_743 = param1;
         var_744 = param2;
         _right = param3;
         var_742 = param4;
         var_186 = param5 != null ? param5 : nullCallback;
      }
      
      public function set bottom(param1:int) : void
      {
         var_742 = param1;
         var_186(this);
      }
      
      public function get left() : int
      {
         return var_743;
      }
      
      public function get isZeroes() : Boolean
      {
         return var_743 == 0 && _right == 0 && var_744 == 0 && var_742 == 0;
      }
      
      public function get right() : int
      {
         return _right;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set top(param1:int) : void
      {
         var_744 = param1;
         var_186(this);
      }
      
      public function get top() : int
      {
         return var_744;
      }
      
      public function set left(param1:int) : void
      {
         var_743 = param1;
         var_186(this);
      }
      
      public function get bottom() : int
      {
         return var_742;
      }
      
      public function clone(param1:Function) : TextMargins
      {
         return new TextMargins(var_743,var_744,_right,var_742,param1);
      }
      
      public function dispose() : void
      {
         var_186 = null;
         _disposed = true;
      }
      
      public function set right(param1:int) : void
      {
         _right = param1;
         var_186(this);
      }
      
      private function nullCallback(param1:IMargins) : void
      {
      }
   }
}
