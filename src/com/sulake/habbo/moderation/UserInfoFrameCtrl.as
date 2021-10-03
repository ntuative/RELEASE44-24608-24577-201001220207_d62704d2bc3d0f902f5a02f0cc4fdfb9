package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class UserInfoFrameCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var var_839:UserInfoCtrl;
      
      private var _disposed:Boolean;
      
      private var _userId:int;
      
      private var var_63:IFrameWindow;
      
      private var var_60:ModerationManager;
      
      public function UserInfoFrameCtrl(param1:ModerationManager, param2:int)
      {
         super();
         var_60 = param1;
         _userId = param2;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_63 != null)
         {
            var_63.destroy();
            var_63 = null;
         }
         if(var_839 != null)
         {
            var_839.dispose();
            var_839 = null;
         }
         var_60 = null;
      }
      
      public function getId() : String
      {
         return "" + _userId;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1313;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      public function show() : void
      {
         var_63 = IFrameWindow(var_60.getXmlWindow("user_info_frame"));
         var_63.caption = "User Info";
         var _loc1_:IWindow = var_63.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_839 = new UserInfoCtrl(var_63,var_60,"",true);
         var_839.load(var_63.content,_userId);
         var_63.visible = true;
      }
      
      public function getFrame() : IFrameWindow
      {
         return var_63;
      }
   }
}
