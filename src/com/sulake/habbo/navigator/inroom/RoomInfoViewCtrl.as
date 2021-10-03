package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.SimpleAlertView;
   import com.sulake.habbo.navigator.TagRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
   import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner
   {
       
      
      private var var_658:IWindowContainer;
      
      private var var_975:ITextWindow;
      
      private var var_199:RoomSettingsCtrl;
      
      private var var_1178:IContainerButtonWindow;
      
      private var _window:IWindowContainer;
      
      private var var_462:Timer;
      
      private var var_1177:ITextWindow;
      
      private var var_343:IWindowContainer;
      
      private var var_1901:IWindowContainer;
      
      private var var_1899:ITextWindow;
      
      private var var_810:IWindowContainer;
      
      private var var_1432:IButtonWindow;
      
      private var _ownerName:ITextWindow;
      
      private var var_645:ITextWindow;
      
      private var var_1431:IWindowContainer;
      
      private var var_1176:IWindowContainer;
      
      private var var_813:ITextWindow;
      
      private var var_973:ITextFieldWindow;
      
      private var var_294:IWindowContainer;
      
      private var var_811:ITextWindow;
      
      private var var_1429:IButtonWindow;
      
      private var var_974:ITextWindow;
      
      private var var_2256:int;
      
      private var var_1175:IContainerButtonWindow;
      
      private var var_812:IWindowContainer;
      
      private var var_1179:ITextWindow;
      
      private var var_1174:IContainerButtonWindow;
      
      private var var_1430:ITextWindow;
      
      private var var_1433:IButtonWindow;
      
      private var var_1042:TagRenderer;
      
      private var var_1900:ITextWindow;
      
      private var var_342:RoomEventViewCtrl;
      
      private var _navigator:HabboNavigator;
      
      private var var_657:ITextWindow;
      
      private var var_267:RoomThumbnailCtrl;
      
      private var var_1173:IContainerButtonWindow;
      
      private var var_1898:IWindowContainer;
      
      private var var_268:IWindowContainer;
      
      public function RoomInfoViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_342 = new RoomEventViewCtrl(_navigator);
         var_199 = new RoomSettingsCtrl(_navigator,this,true);
         var_267 = new RoomThumbnailCtrl(_navigator);
         var_1042 = new TagRenderer(_navigator);
         _navigator.roomSettingsCtrls.push(this.var_199);
         var_462 = new Timer(6000,1);
         var_462.addEventListener(TimerEvent.TIMER,hideInfo);
      }
      
      public function backToRoomSettings() : void
      {
         this.var_199.active = true;
         this.var_342.active = false;
         this.var_267.active = false;
         this.reload();
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      private function refreshEventButtons(param1:RoomEventData) : void
      {
         if(false)
         {
            return;
         }
         var_1432.visible = param1 == null && _navigator.data.currentRoomOwner;
         var_1433.visible = param1 != null && (_navigator.data.currentRoomOwner || _navigator.data.eventMod);
         var_1431.visible = Util.hasVisibleChildren(var_1431);
      }
      
      private function refreshRoomDetails(param1:GuestRoomData, param2:Boolean) : void
      {
         if(param1 == null || false || false)
         {
            return;
         }
         var_645.text = param1.roomName;
         var_645.height = NaN;
         _ownerName.text = param1.ownerName;
         var_813.text = param1.description;
         var_1042.refreshTags(var_343,param1.tags);
         var_813.visible = false;
         if(param1.description != "")
         {
            var_813.height = NaN;
            var_813.visible = true;
         }
         var _loc3_:* = _navigator.data.currentRoomRating == -1;
         _navigator.refreshButton(var_343,"thumb_up",_loc3_,onThumbUp,0);
         _navigator.refreshButton(var_343,"thumb_down",_loc3_,onThumbDown,0);
         var_1899.visible = _loc3_;
         var_811.visible = !_loc3_;
         var_1430.visible = !_loc3_;
         var_1430.text = "" + _navigator.data.currentRoomRating;
         _navigator.refreshButton(var_343,"home",param2,null,0);
         _navigator.refreshButton(var_343,"favourite",!param2 && _navigator.data.isCurrentRoomFavourite(),null,0);
         Util.moveChildrenToColumn(var_343,["room_name","owner_name_cont","tags","room_desc","rating_cont"],var_645.y,0);
         var_343.visible = true;
         var_343.height = Util.getLowestPoint(var_343);
      }
      
      private function getButtonsMinHeight() : int
      {
         return !!_navigator.data.currentRoomOwner ? 0 : 21;
      }
      
      private function hideInfo(param1:Event) : void
      {
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_416,HabboToolbarIconEnum.ROOMINFO,_window,false));
      }
      
      private function onThumbUp(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.send(new RateFlatMessageComposer(1));
      }
      
      private function getRoomInfoMinHeight() : int
      {
         return 37;
      }
      
      public function onAddFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         if(_navigator.data.isFavouritesFull())
         {
            _loc3_ = new SimpleAlertView(_navigator,"${navigator.favouritesfull.title}","${navigator.favouritesfull.body}");
            _loc3_.show();
         }
         else
         {
            _navigator.send(new AddFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
         }
      }
      
      private function refreshRoomButtons(param1:Boolean) : void
      {
         if(_navigator.data.enteredGuestRoom == null || false || false)
         {
            return;
         }
         var_1429.visible = _navigator.data.canEditRoomSettings;
         var _loc2_:Boolean = _navigator.data.isCurrentRoomFavourite();
         var_1178.visible = _navigator.data.canAddFavourite && !_loc2_;
         var_1173.visible = _navigator.data.canAddFavourite && _loc2_;
         var_1175.visible = _navigator.data.canEditRoomSettings && !param1;
         var_1174.visible = _navigator.data.canEditRoomSettings && param1;
         var_1176.visible = Util.hasVisibleChildren(var_1176);
      }
      
      public function open(param1:Boolean) : void
      {
         this.var_462.reset();
         this.var_342.active = false;
         this.var_199.active = false;
         this.var_267.active = false;
         if(param1)
         {
            this.startRoomSettingsEdit(_navigator.data.enteredGuestRoom.flatId);
         }
         refresh();
         _window.visible = true;
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_46,HabboToolbarIconEnum.ROOMINFO,_window,false));
         _window.parent.activate();
         _window.activate();
         if(!param1)
         {
            this.var_462.start();
         }
      }
      
      public function toggle() : void
      {
         this.var_462.reset();
         this.var_342.active = false;
         this.var_199.active = false;
         this.var_267.active = false;
         refresh();
         if(true)
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_46,HabboToolbarIconEnum.ROOMINFO,_window,false));
            _window.parent.activate();
         }
         else
         {
            _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_416,HabboToolbarIconEnum.ROOMINFO,_window,false));
         }
      }
      
      private function refreshRoom() : void
      {
         Util.hideChildren(var_294);
         var_294.findChildByName("close").visible = true;
         var _loc1_:GuestRoomData = _navigator.data.enteredGuestRoom;
         var _loc2_:Boolean = _navigator.data.settings != null && _loc1_ != null && _loc1_.flatId == _navigator.data.settings.homeRoomId;
         refreshRoomDetails(_loc1_,_loc2_);
         refreshPublicSpaceDetails(_navigator.data.enteredPublicSpace);
         refreshRoomButtons(_loc2_);
         this.var_199.refresh(var_294);
         this.var_267.refresh(var_294);
         Util.moveChildrenToColumn(var_294,["room_details","room_buttons"],0,2);
         var_294.height = Util.getLowestPoint(var_294);
         var_294.visible = true;
         Logger.log("XORP: undefined, undefined, undefined, undefined, undefined");
      }
      
      private function onCloseButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         hideInfo(null);
      }
      
      private function onEmbedSrcClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var_973.setSelection(0,var_973.text.length);
      }
      
      private function getEmbedData() : String
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_navigator.data.enteredGuestRoom != null)
         {
            _loc1_ = "private";
            _loc2_ = "" + _navigator.data.enteredGuestRoom.flatId;
         }
         else
         {
            _loc1_ = "public";
            _loc2_ = "" + _navigator.data.publicSpaceNodeId;
            Logger.log("Node id is: " + _loc2_);
         }
         var _loc3_:String = _navigator.configuration.getKey("user.hash","");
         _navigator.registerParameter("navigator.embed.src","roomType",_loc1_);
         _navigator.registerParameter("navigator.embed.src","embedCode",_loc3_);
         _navigator.registerParameter("navigator.embed.src","roomId",_loc2_);
         return _navigator.getText("navigator.embed.src");
      }
      
      private function onThumbDown(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         _navigator.send(new RateFlatMessageComposer(-1));
      }
      
      private function refreshEvent() : void
      {
         Util.hideChildren(var_268);
         var _loc1_:RoomEventData = _navigator.data.roomEventData;
         refreshEventDetails(_loc1_);
         refreshEventButtons(_loc1_);
         this.var_342.refresh(var_268);
         if(Util.hasVisibleChildren(var_268) && !this.var_267.active)
         {
            Util.moveChildrenToColumn(var_268,["event_details","event_buttons"],0,2);
            var_268.height = Util.getLowestPoint(var_268);
            var_268.visible = true;
         }
         else
         {
            var_268.visible = false;
         }
         Logger.log("EVENT: undefined, undefined");
      }
      
      public function startEventEdit() : void
      {
         this.var_462.reset();
         this.var_342.active = true;
         this.var_199.active = false;
         this.var_267.active = false;
         this.reload();
      }
      
      private function getEventInfoMinHeight() : int
      {
         return 18;
      }
      
      public function onRemoveFavouriteClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.enteredGuestRoom == null)
         {
            return;
         }
         _navigator.send(new DeleteFavouriteRoomMessageComposer(_navigator.data.enteredGuestRoom.flatId));
      }
      
      private function onHover(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            return;
         }
         var_462.reset();
      }
      
      private function refreshPublicSpaceDetails(param1:PublicRoomShortData) : void
      {
         if(param1 == null || false || false)
         {
            return;
         }
         var_975.text = _navigator.getPublicSpaceName(param1.unitPropertySet,param1.worldId);
         var_975.height = NaN;
         var_1177.text = _navigator.getPublicSpaceDesc(param1.unitPropertySet,param1.worldId);
         var_1177.height = NaN;
         Util.moveChildrenToColumn(var_658,["public_space_name","public_space_desc"],var_975.y,0);
         var_658.visible = true;
         var_658.height = Math.max(86,Util.getLowestPoint(var_658));
      }
      
      public function reload() : void
      {
         if(_window != null && false)
         {
            refresh();
         }
      }
      
      private function find(param1:String) : IWindow
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function refreshEmbed() : void
      {
         var _loc1_:* = _navigator.configuration.getKey("embed.showInRoomInfo","UserCountRenderer") == "true";
         if(_loc1_ && true && true && true)
         {
            var_812.visible = true;
            var_973.text = this.getEmbedData();
         }
         else
         {
            var_812.visible = false;
         }
      }
      
      public function startRoomSettingsEdit(param1:int) : void
      {
         this.var_462.reset();
         this.var_199.load(param1);
         this.var_199.active = true;
         this.var_342.active = false;
         this.var_267.active = false;
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
      }
      
      public function startThumbnailEdit() : void
      {
         this.var_462.reset();
         this.var_199.active = false;
         this.var_342.active = false;
         this.var_267.active = true;
         this.reload();
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IWindowContainer(_navigator.getXmlWindow("iro_room_details"));
         _window.setParamFlag(HabboWindowParam.const_64,false);
         _window.setParamFlag(HabboWindowParam.const_1240,true);
         var_294 = IWindowContainer(find("room_info"));
         var_343 = IWindowContainer(find("room_details"));
         var_658 = IWindowContainer(find("public_space_details"));
         var_1898 = IWindowContainer(find("owner_name_cont"));
         var_1901 = IWindowContainer(find("rating_cont"));
         var_1176 = IWindowContainer(find("room_buttons"));
         var_645 = ITextWindow(find("room_name"));
         var_975 = ITextWindow(find("public_space_name"));
         _ownerName = ITextWindow(find("owner_name"));
         var_813 = ITextWindow(find("room_desc"));
         var_1177 = ITextWindow(find("public_space_desc"));
         var_974 = ITextWindow(find("owner_caption"));
         var_811 = ITextWindow(find("rating_caption"));
         var_1899 = ITextWindow(find("rate_caption"));
         var_1430 = ITextWindow(find("rating_txt"));
         var_268 = IWindowContainer(find("event_info"));
         var_810 = IWindowContainer(find("event_details"));
         var_1431 = IWindowContainer(find("event_buttons"));
         var_1900 = ITextWindow(find("event_name"));
         var_657 = ITextWindow(find("event_desc"));
         var_1178 = IContainerButtonWindow(find("add_favourite_button"));
         var_1173 = IContainerButtonWindow(find("rem_favourite_button"));
         var_1175 = IContainerButtonWindow(find("make_home_button"));
         var_1174 = IContainerButtonWindow(find("unmake_home_button"));
         var_1429 = IButtonWindow(find("room_settings_button"));
         var_1432 = IButtonWindow(find("create_event_button"));
         var_1433 = IButtonWindow(find("edit_event_button"));
         var_812 = IWindowContainer(find("embed_info"));
         var_1179 = ITextWindow(find("embed_info_txt"));
         var_973 = ITextFieldWindow(find("embed_src_txt"));
         Util.setProcDirectly(var_1178,onAddFavouriteClick);
         Util.setProcDirectly(var_1173,onRemoveFavouriteClick);
         Util.setProcDirectly(var_1429,onRoomSettingsClick);
         Util.setProcDirectly(var_1175,onMakeHomeClick);
         Util.setProcDirectly(var_1174,onUnmakeHomeClick);
         Util.setProcDirectly(var_1432,onEventSettingsClick);
         Util.setProcDirectly(var_1433,onEventSettingsClick);
         Util.setProcDirectly(var_973,onEmbedSrcClick);
         _navigator.refreshButton(var_1178,"favourite",true,null,0);
         _navigator.refreshButton(var_1173,"favourite",true,null,0);
         _navigator.refreshButton(var_1175,"home",true,null,0);
         _navigator.refreshButton(var_1174,"home",true,null,0);
         _window.findChildByName("close").procedure = onCloseButtonClick;
         Util.setProcDirectly(var_294,onHover);
         Util.setProcDirectly(var_268,onHover);
         var_974.width = var_974.textWidth;
         Util.moveChildrenToRow(var_1898,["owner_caption","owner_name"],var_974.x,var_974.y,3);
         var_811.width = var_811.textWidth;
         Util.moveChildrenToRow(var_1901,["rating_caption","rating_txt"],var_811.x,var_811.y,3);
         var_1179.height = NaN;
         Util.moveChildrenToColumn(var_812,["embed_info_txt","embed_src_txt"],var_1179.y,2);
         var_812.height = Util.getLowestPoint(var_812) + 5;
         var_2256 = NaN;
      }
      
      private function refreshEventDetails(param1:RoomEventData) : void
      {
         if(param1 == null || false)
         {
            return;
         }
         var_1900.text = param1.eventName;
         var_657.text = param1.eventDescription;
         var_1042.refreshTags(var_810,[_navigator.getText("roomevent_type_" + param1.eventType),param1.tags[0],param1.tags[1]]);
         var_657.visible = false;
         if(param1.eventDescription != "")
         {
            var_657.height = NaN;
            var_657.y = Util.getLowestPoint(var_810) + 2;
            var_657.visible = true;
         }
         var_810.visible = true;
         var_810.height = Util.getLowestPoint(var_810);
      }
      
      private function refresh() : void
      {
         prepareWindow();
         refreshRoom();
         refreshEvent();
         refreshEmbed();
         Util.moveChildrenToColumn(this._window,["room_info","event_info","embed_info"],0,2);
         _window.height = Util.getLowestPoint(_window);
         _window.y = _window.desktop.height - 0 - 5;
         Logger.log("MAIN: undefined, undefined, undefined");
      }
      
      private function onRoomSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = _navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         startRoomSettingsEdit(_loc3_.flatId);
      }
      
      private function onUnmakeHomeClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("CLEARING HOME ROOM:");
         _navigator.send(new UpdateNavigatorSettingsMessageComposer(0));
      }
      
      private function onEventSettingsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(_navigator.data.roomEventData == null)
         {
            if(_navigator.data.currentRoomOwner)
            {
               _navigator.send(new CanCreateEventMessageComposer());
            }
         }
         else
         {
            startEventEdit();
         }
      }
      
      public function roomSettingsRefreshNeeded() : void
      {
         refresh();
      }
      
      public function close() : void
      {
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_855,HabboToolbarIconEnum.ROOMINFO,_window,false));
         if(_window == null)
         {
            return;
         }
         this._window.visible = false;
         _navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
      }
      
      private function onMakeHomeClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:GuestRoomData = _navigator.data.enteredGuestRoom;
         if(_loc3_ == null)
         {
            Logger.log("No entered room data?!");
            return;
         }
         Logger.log("SETTING HOME ROOM TO: " + _loc3_.flatId);
         _navigator.send(new UpdateNavigatorSettingsMessageComposer(_loc3_.flatId));
      }
   }
}
