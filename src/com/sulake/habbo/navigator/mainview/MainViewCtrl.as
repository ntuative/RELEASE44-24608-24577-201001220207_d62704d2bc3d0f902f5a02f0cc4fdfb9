package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.LatestEventsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTagSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tab;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MainViewCtrl implements ICoreUpdateReceiver
   {
      
      public static const const_505:int = 2;
      
      public static const const_1005:int = 4;
      
      private static const const_479:int = 2;
      
      private static const const_740:int = 1;
      
      public static const const_1450:int = 3;
      
      private static const const_1037:int = 4;
      
      private static const const_480:int = 22;
      
      public static const const_399:int = 1;
      
      private static const const_739:int = 3;
       
      
      private var var_1705:int = 0;
      
      private var var_1114:IRegionWindow;
      
      private var var_374:int;
      
      private var var_1116:Boolean = true;
      
      private var var_1377:GuestRoomListCtrl;
      
      private var var_28:IFrameWindow;
      
      private var var_493:Timer;
      
      private var var_256:IWindowContainer;
      
      private var var_192:IWindowContainer;
      
      private var var_214:IWindowContainer;
      
      private var var_12:IWindow;
      
      private var var_1113:Boolean;
      
      private var var_1706:OfficialRoomListCtrl;
      
      private var var_35:IWindowContainer;
      
      private var var_1378:PopularTagsListCtrl;
      
      private var _navigator:HabboNavigator;
      
      private var var_1115:int = 0;
      
      private var var_213:ITabContextWindow;
      
      public function MainViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_1378 = new PopularTagsListCtrl(_navigator);
         var_1377 = new GuestRoomListCtrl(_navigator);
         var_1706 = new OfficialRoomListCtrl(_navigator);
         var_493 = new Timer(300,1);
         var_493.addEventListener(TimerEvent.TIMER,onResizeTimer);
      }
      
      private function getSearchMsg(param1:int, param2:String) : IMessageComposer
      {
         if(param1 == Tabs.const_614)
         {
            return new MyFavouriteRoomsSearchMessageComposer();
         }
         if(param1 == Tabs.const_687)
         {
            return new MyFriendsRoomsSearchMessageComposer();
         }
         if(param1 == Tabs.const_672)
         {
            return new MyRoomHistorySearchMessageComposer();
         }
         if(param1 == Tabs.const_215)
         {
            return new MyRoomsSearchMessageComposer();
         }
         if(param1 == Tabs.const_329)
         {
            return new PopularRoomsSearchMessageComposer(param2);
         }
         if(param1 == Tabs.const_595)
         {
            return new RoomsWhereMyFriendsAreSearchMessageComposer();
         }
         if(param1 == Tabs.const_599)
         {
            return new RoomsWithHighestScoreSearchMessageComposer();
         }
         if(param1 == Tabs.const_295)
         {
            return new RoomTagSearchMessageComposer(param2);
         }
         if(param1 == Tabs.const_193)
         {
            return new RoomTextSearchMessageComposer(param2);
         }
         if(param1 == Tabs.const_431)
         {
            return new LatestEventsSearchMessageComposer(param2);
         }
         Logger.log("No message for searchType: " + param1);
         return null;
      }
      
      private function prepare() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var_28 = IFrameWindow(_navigator.getXmlWindow("grs_main_window"));
         var_213 = ITabContextWindow(var_28.findChildByName("tab_context"));
         var_35 = IWindowContainer(var_28.findChildByName("tab_content"));
         var_214 = IWindowContainer(var_28.findChildByName("custom_content"));
         var_192 = IWindowContainer(var_28.findChildByName("list_content"));
         var_256 = IWindowContainer(var_28.findChildByName("custom_footer"));
         var_12 = var_28.findChildByName("loading_text");
         var _loc1_:IWindow = var_28.findChildByTag("close");
         _loc1_.procedure = onWindowClose;
         var_1114 = IRegionWindow(var_28.findChildByName("to_hotel_view"));
         var_1114.procedure = onHotelView;
         refreshToHotelViewButton(false);
         var_28.procedure = onWindow;
         for each(_loc2_ in _navigator.tabs.tabs)
         {
            _loc3_ = var_213.method_13(_loc2_.id);
            _loc3_.setParamFlag(HabboWindowParam.const_39,true);
            _loc3_.procedure = onTabClick;
            _loc2_.button = _loc3_;
         }
         var_28.scaler.setParamFlag(HabboWindowParam.const_624,false);
         var_28.scaler.setParamFlag(HabboWindowParam.const_1279,true);
      }
      
      public function get mainWindow() : IFrameWindow
      {
         return var_28;
      }
      
      private function onTabClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_52)
         {
            return;
         }
         var _loc3_:int = param2.id;
         if(var_1113)
         {
            var_1113 = false;
            return;
         }
         var _loc4_:Tab = _navigator.tabs.getTab(_loc3_);
         _loc4_.sendSearchRequest();
         switch(_loc4_.id)
         {
            case Tabs.const_275:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS));
               break;
            case Tabs.const_256:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME));
               break;
            case Tabs.const_299:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL));
               break;
            case Tabs.const_231:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS));
               break;
            case Tabs.const_197:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH));
         }
      }
      
      private function refreshScrollbar(param1:IViewCtrl) : void
      {
         if(param1.content == null || !param1.content.visible)
         {
            return;
         }
         var _loc2_:IItemListWindow = IItemListWindow(param1.content.findChildByName("item_list"));
         var _loc3_:IWindow = param1.content.findChildByName("scroller");
         var _loc4_:* = _loc2_.scrollableRegion.height > _loc2_.height;
         if(_loc3_.visible)
         {
            if(_loc4_)
            {
               return;
            }
            _loc3_.visible = false;
            _loc2_.width += const_480;
         }
         else
         {
            if(!_loc4_)
            {
               return;
            }
            _loc3_.visible = true;
            _loc2_.width -= const_480;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close window");
         this.close();
      }
      
      private function sendTrackingEvent(param1:int) : void
      {
         switch(param1)
         {
            case Tabs.const_431:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS));
               break;
            case Tabs.const_614:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES));
               break;
            case Tabs.const_687:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS));
               break;
            case Tabs.const_672:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY));
               break;
            case Tabs.const_215:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS));
               break;
            case Tabs.const_636:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS));
               break;
            case Tabs.const_329:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS));
               break;
            case Tabs.const_595:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE));
               break;
            case Tabs.const_599:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE));
               break;
            case Tabs.const_295:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH));
               break;
            case Tabs.const_193:
               _navigator.events.dispatchEvent(new Event(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH));
         }
      }
      
      private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String) : void
      {
         var _loc5_:* = null;
         if(!param2)
         {
            return;
         }
         if(param3.content == null)
         {
            _loc5_ = var_192.getChildByName(param4);
            param3.content = IWindowContainer(_loc5_);
         }
         if(param1)
         {
            param3.refresh();
         }
         param3.content.visible = true;
      }
      
      public function isOpen() : Boolean
      {
         return var_28 != null && false;
      }
      
      private function refreshListContent(param1:Boolean) : void
      {
         Util.hideChildren(var_192);
         refreshGuestRooms(param1,_navigator.data.guestRoomSearchArrived);
         refreshPopularTags(param1,_navigator.data.popularTagsArrived);
         refreshOfficialRooms(param1,_navigator.data.officialRoomsArrived);
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshScrollbar(var_1378);
         refreshScrollbar(var_1377);
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:IWindowContainer) : void
      {
         var _loc3_:IWindow = param1.content.findChildByName("scroller");
         if(_loc3_.visible)
         {
            return;
         }
         param2.width += const_480;
      }
      
      public function startSearch(param1:int, param2:int, param3:String = "-1", param4:int = 1) : void
      {
         var _loc5_:Tab = _navigator.tabs.getSelected();
         _navigator.tabs.setSelectedTab(param1);
         var _loc6_:Tab = _navigator.tabs.getSelected();
         ErrorReportStorage.addDebugData("StartSearch","Start search " + _loc5_.id + " => " + _loc6_.id);
         this.var_1116 = _loc5_ != _loc6_;
         if(_loc5_ != _loc6_)
         {
            _loc6_.tabPageDecorator.tabSelected();
         }
         _navigator.data.startLoading();
         if(param4 == const_399)
         {
            _navigator.send(getSearchMsg(param2,param3));
         }
         else if(param4 == const_505)
         {
            _navigator.send(new GetPopularRoomTagsMessageComposer());
         }
         else
         {
            _navigator.send(new GetOfficialRoomsMessageComposer());
         }
         if(!isOpen())
         {
            open();
            this.var_374 = const_479;
            this.var_192.blend = 0;
            if(this.var_214.visible)
            {
               this.var_214.blend = 0;
               this.var_256.blend = 0;
            }
         }
         else
         {
            this.var_374 = const_740;
         }
         this.var_1115 = 0;
         _navigator.registerUpdateReceiver(this,2);
         sendTrackingEvent(param2);
      }
      
      private function refreshCustomContent() : void
      {
         Util.hideChildren(var_214);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshCustomContent(var_214);
         if(Util.hasVisibleChildren(var_214))
         {
            var_214.visible = true;
         }
         else
         {
            var_214.visible = false;
            var_214.blend = 1;
         }
      }
      
      public function dispose() : void
      {
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_44 || param2 != var_28)
         {
            return;
         }
         if(!this.var_493.running)
         {
            this.var_493.reset();
            this.var_493.start();
         }
      }
      
      private function refreshOfficialRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_1706,"official_rooms");
      }
      
      private function refreshPopularTags(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_1378,"popular_tags");
      }
      
      private function refreshGuestRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_1377,"guest_rooms");
      }
      
      private function refreshTab() : void
      {
         var _loc1_:Tab = _navigator.tabs.getSelected();
         var _loc2_:ISelectableWindow = var_213.selector.getSelected();
         if(_loc1_.button != _loc2_)
         {
            var_1113 = true;
            var_213.selector.setSelected(_loc1_.button);
         }
      }
      
      public function onNavigatorToolBarIconClick() : Boolean
      {
         if(isOpen())
         {
            close();
            return false;
         }
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
         return true;
      }
      
      public function open() : void
      {
         var _loc1_:Boolean = false;
         if(this.var_28 == null)
         {
            prepare();
            _loc1_ = true;
         }
         refresh();
         var_28.visible = true;
         var_28.activate();
         if(_loc1_)
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_46,HabboToolbarIconEnum.NAVIGATOR,var_28));
         }
      }
      
      private function refreshFooter() : void
      {
         Util.hideChildren(var_256);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshFooter(var_256);
         if(Util.hasVisibleChildren(var_256))
         {
            var_256.visible = true;
         }
         else
         {
            var_256.visible = false;
         }
      }
      
      public function reloadRoomList(param1:int) : Boolean
      {
         ErrorReportStorage.addDebugData("MainViewCtrl","Reloading RoomList");
         if(this.isOpen() && this._navigator.data.guestRoomSearchResults != null && this._navigator.data.guestRoomSearchResults.searchType == param1)
         {
            startSearch(_navigator.tabs.getSelected().id,param1,"");
            return true;
         }
         return false;
      }
      
      private function onHotelView(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            refreshToHotelViewButton(true);
         }
         else if(param1.type == WindowMouseEvent.const_29)
         {
            refreshToHotelViewButton(false);
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            _navigator.send(new QuitMessageComposer());
         }
      }
      
      public function refresh() : void
      {
         if(var_28 == null)
         {
            return;
         }
         refreshTab();
         refreshCustomContent();
         refreshListContent(true);
         refreshFooter();
         var_214.height = Util.getLowestPoint(var_214);
         var_256.height = Util.getLowestPoint(var_256);
         var _loc1_:int = 0;
         Util.moveChildrenToColumn(var_35,["custom_content","list_content"],var_214.y,8);
         var_192.height = var_192.height + _loc1_ - 0 - 0 + var_1705;
         Util.moveChildrenToColumn(var_35,["list_content","custom_footer"],var_192.y,8);
         var_1705 = var_256.height;
         onResizeTimer(null);
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         if(this.var_192 == null)
         {
            return;
         }
         var _loc2_:Number = param1 / 150;
         if(var_374 == const_740)
         {
            _loc3_ = Math.min(1,Math.max(0,this.var_192.blend - _loc2_));
            this.var_192.blend = _loc3_;
            this.var_214.blend = !!var_1116 ? Number(_loc3_) : Number(1);
            this.var_256.blend = !!var_1116 ? Number(_loc3_) : Number(1);
            if(_loc3_ == 0)
            {
               var_374 = const_479;
            }
         }
         else if(var_374 == const_479)
         {
            if(var_1115 % 10 == 1)
            {
               var_12.visible = true;
            }
            ++var_1115;
            if(!_navigator.data.isLoading())
            {
               var_374 = const_739;
            }
         }
         else if(var_374 == const_739)
         {
            this.refresh();
            var_374 = const_1037;
         }
         else
         {
            var_12.visible = false;
            _loc3_ = Math.min(1,Math.max(0,this.var_192.blend + _loc2_));
            this.var_192.blend = _loc3_;
            this.var_214.blend = !!var_1116 ? Number(_loc3_) : Number(1);
            this.var_256.blend = !!var_1116 ? Number(_loc3_) : Number(1);
            if(false)
            {
               _navigator.removeUpdateReceiver(this);
            }
         }
      }
      
      private function refreshToHotelViewButton(param1:Boolean) : void
      {
         _navigator.refreshButton(var_1114,"icon_hotelview",!param1,null,0);
         _navigator.refreshButton(var_1114,"icon_hotelview_reactive",param1,null,0);
      }
      
      public function close() : void
      {
         if(var_28 != null)
         {
            var_28.visible = false;
         }
      }
   }
}
