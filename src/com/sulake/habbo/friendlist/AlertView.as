package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements IDisposable
   {
      
      private static var var_1366:Dictionary = new Dictionary();
       
      
      private var _disposed:Boolean;
      
      private var var_253:IFrameWindow;
      
      private var _title:String;
      
      private var _friendList:HabboFriendList;
      
      private var var_1106:String;
      
      public function AlertView(param1:HabboFriendList, param2:String, param3:String = null)
      {
         super();
         _friendList = param1;
         var_1106 = param2;
         _title = param3;
      }
      
      function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      public function get friendList() : HabboFriendList
      {
         return _friendList;
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
         if(var_253 != null)
         {
            var_253.destroy();
            var_253 = null;
         }
         _friendList = null;
      }
      
      private function getAlert() : IFrameWindow
      {
         var _loc1_:IFrameWindow = IFrameWindow(_friendList.getXmlWindow(this.var_1106));
         var _loc2_:IWindow = _loc1_.findChildByTag("close");
         _loc2_.procedure = onClose;
         return _loc1_;
      }
      
      function setupContent(param1:IWindowContainer) : void
      {
      }
      
      public function show() : void
      {
         var _loc1_:IFrameWindow = IFrameWindow(var_1366[var_1106]);
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
         var_253 = getAlert();
         if(_title != null)
         {
            var_253.caption = _title;
         }
         setupContent(var_253.content);
         var _loc2_:Rectangle = Util.getLocationRelativeTo(_friendList.view.mainWindow,var_253.width,var_253.height);
         var_253.x = _loc2_.x;
         var_253.y = _loc2_.y;
         var_1366[var_1106] = var_253;
      }
   }
}
