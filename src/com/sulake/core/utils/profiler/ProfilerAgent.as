package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.IDisposable;
   import flash.utils.getQualifiedClassName;
   
   public class ProfilerAgent extends ProfilerAgentTask implements IDisposable
   {
       
      
      protected var var_887:ICoreUpdateReceiver;
      
      public function ProfilerAgent(param1:ICoreUpdateReceiver)
      {
         var_887 = param1;
         var _loc2_:String = getQualifiedClassName(var_887);
         super(_loc2_.slice(_loc2_.lastIndexOf(":") + 1,_loc2_.length));
      }
      
      override public function dispose() : void
      {
         var_887 = null;
         super.dispose();
      }
      
      public function get receiver() : ICoreUpdateReceiver
      {
         return var_887;
      }
      
      public function update(param1:int) : void
      {
         super.start();
         var_887.update(param1);
         super.stop();
      }
   }
}
