package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindowContext;
   import flash.display.DisplayObject;
   
   public class InternalWindowServices implements IInternalWindowServices
   {
       
      
      private var var_126:DisplayObject;
      
      private var var_2286:uint;
      
      private var var_863:IWindowToolTipAgentService;
      
      private var var_866:IWindowMouseScalingService;
      
      private var var_383:IWindowContext;
      
      private var var_865:IWindowFocusManagerService;
      
      private var var_864:IWindowMouseListenerService;
      
      private var var_867:IWindowMouseDraggingService;
      
      public function InternalWindowServices(param1:IWindowContext, param2:DisplayObject)
      {
         super();
         var_2286 = 0;
         var_126 = param2;
         var_383 = param1;
         var_867 = new WindowMouseDragger(param2);
         var_866 = new WindowMouseScaler(param2);
         var_864 = new WindowMouseListener(param2);
         var_865 = new FocusManager(param2);
         var_863 = new WindowToolTipAgent(param2);
      }
      
      public function getMouseScalingService() : IWindowMouseScalingService
      {
         return var_866;
      }
      
      public function getFocusManagerService() : IWindowFocusManagerService
      {
         return var_865;
      }
      
      public function getToolTipAgentService() : IWindowToolTipAgentService
      {
         return var_863;
      }
      
      public function dispose() : void
      {
         if(var_867 != null)
         {
            var_867.dispose();
            var_867 = null;
         }
         if(var_866 != null)
         {
            var_866.dispose();
            var_866 = null;
         }
         if(var_864 != null)
         {
            var_864.dispose();
            var_864 = null;
         }
         if(var_865 != null)
         {
            var_865.dispose();
            var_865 = null;
         }
         if(var_863 != null)
         {
            var_863.dispose();
            var_863 = null;
         }
         var_383 = null;
      }
      
      public function getMouseListenerService() : IWindowMouseListenerService
      {
         return var_864;
      }
      
      public function getMouseDraggingService() : IWindowMouseDraggingService
      {
         return var_867;
      }
   }
}
