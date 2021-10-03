package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.utils.Dictionary;
   
   public class FriendListView
   {
      
      private static const const_1396:String = "noconvinfo";
      
      private static const const_1397:String = "messageinput";
       
      
      private var var_1455:int = -1;
      
      private var var_749:IWindowContainer;
      
      private var _friendList:HabboFriendList;
      
      private var var_1454:int = -1;
      
      private var var_1188:ITextWindow;
      
      private var var_1189:FriendListTabsView;
      
      private var var_28:IFrameWindow;
      
      private var var_256:IWindowContainer;
      
      private var var_1922:Boolean;
      
      public function FriendListView(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
         var_1189 = new FriendListTabsView(_friendList);
      }
      
      private function prepare() : void
      {
         var_28 = IFrameWindow(_friendList.getXmlWindow("main_window"));
         var_28.findChildByTag("close").procedure = onWindowClose;
         var_749 = IWindowContainer(var_28.content.findChildByName("main_content"));
         var_256 = IWindowContainer(var_28.content.findChildByName("footer"));
         var_1189.prepare(var_749);
         var_28.procedure = onWindow;
         var_28.content.setParamFlag(HabboWindowParam.const_892,false);
         var_28.content.setParamFlag(HabboWindowParam.const_1169,true);
         var_28.header.setParamFlag(HabboWindowParam.const_600,false);
         var_28.header.setParamFlag(HabboWindowParam.const_798,true);
         var_28.content.setParamFlag(HabboWindowParam.const_600,false);
         var_28.content.setParamFlag(HabboWindowParam.const_798,true);
         var_28.findChildByName("open_edit_ctgs_but").procedure = onEditCategoriesButtonClick;
         var_1188 = ITextWindow(var_28.findChildByName("info_text"));
         var_1188.text = "";
         _friendList.refreshButton(var_28,"open_edit_ctgs",true,null,0);
         var_28.title.color = 4294623744;
         var_28.title.textColor = 4287851525;
         refresh("prepare");
         var_28.height = 350;
         var_28.width = 230;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close window");
         var_28.visible = false;
         _friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
      }
      
      public function showInfo(param1:WindowEvent, param2:String) : void
      {
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.type == WindowMouseEvent.const_29)
         {
            var_1188.text = "";
         }
         else if(_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            var_1188.text = param2;
         }
      }
      
      public function openFriendList() : void
      {
         if(var_28 == null)
         {
            prepare();
            _friendList.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_46,HabboToolbarIconEnum.FRIENDLIST,var_28));
         }
         else
         {
            var_28.visible = true;
            var_28.activate();
         }
      }
      
      private function getTitleBar() : IWindowContainer
      {
         return var_28.findChildByName("titlebar") as IWindowContainer;
      }
      
      public function get tabsView() : FriendListTabsView
      {
         return var_1189;
      }
      
      private function refreshWindowSize() : void
      {
         this.var_1922 = true;
         var_256.visible = false;
         var_256.y = Util.getLowestPoint(var_28.content);
         var_256.width = _friendList.tabs.windowWidth;
         var_256.visible = true;
         var_28.content.height = Util.getLowestPoint(var_28.content);
         var_28.content.width = _friendList.tabs.windowWidth - 10;
         var_28.header.width = _friendList.tabs.windowWidth - 10;
         var_28.height = var_28.content.height + 30;
         var_28.width = _friendList.tabs.windowWidth;
         this.var_1922 = false;
         var_28.scaler.setParamFlag(HabboWindowParam.const_624,false);
         var_28.scaler.setParamFlag(HabboWindowParam.const_954,this._friendList.tabs.findSelectedTab() != null);
         var_28.scaler.setParamFlag(HabboWindowParam.const_600,false);
         var_28.scaler.setParamFlag(HabboWindowParam.const_892,false);
         var_28.scaler.x = 0 - var_28.scaler.width;
         var_28.scaler.y = 0 - var_28.scaler.height;
         var_1454 = var_28.height;
         var_1455 = var_28.width;
         Logger.log("RESIZED: " + _friendList.tabs.windowWidth);
      }
      
      public function isFriendListOpen() : Boolean
      {
         return var_28 != null && false;
      }
      
      public function refresh(param1:String) : void
      {
         if(this.var_28 == null)
         {
            return;
         }
         var_1189.refresh(param1);
         refreshWindowSize();
      }
      
      public function get mainWindow() : IWindowContainer
      {
         return var_28;
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_44 || param2 != var_28)
         {
            return;
         }
         if(this.var_1922)
         {
            return;
         }
         var _loc3_:int = var_1454 == -1 ? 0 : int(0 - var_1454);
         var _loc4_:int = var_1455 == -1 ? 0 : int(0 - var_1455);
         _friendList.tabs.tabContentHeight = Math.max(100,_friendList.tabs.tabContentHeight + _loc3_);
         _friendList.tabs.windowWidth = Math.max(147,_friendList.tabs.windowWidth + _loc4_);
         refresh("resize: " + _loc3_);
      }
      
      private function onEditCategoriesButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.preferences}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Edit categories clicked");
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.friendlist.pref",new Dictionary(),_loc3_.stageX,_loc3_.stageY);
      }
      
      public function close() : void
      {
         if(this.var_28 != null)
         {
            this.var_28.visible = false;
         }
      }
   }
}
