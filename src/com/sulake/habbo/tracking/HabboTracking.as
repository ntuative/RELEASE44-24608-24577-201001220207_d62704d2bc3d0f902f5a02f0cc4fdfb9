package com.sulake.habbo.tracking
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.advertisement.IAdManager;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.HabboCatalogTrackingEvent;
   import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
   import com.sulake.habbo.communication.enum.HabboHotelViewEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.localization.enum.LocalizationEvent;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.navigator.events.HabboNavigatorTrackingEvent;
   import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.events.warnings.AvatarWalkWarpingWarningEvent;
   import com.sulake.habbo.widget.IRoomWidgetFactory;
   import com.sulake.habbo.widget.memenu.enum.HabboMeMenuTrackingEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowTrackingEvent;
   import com.sulake.iid.IIDHabboAdManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomWidget;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   import iid.IIDHabboWindowManager;
   
   public class HabboTracking extends Component implements IHabboTracking, ICoreUpdateReceiver
   {
      
      private static const const_763:uint = 11;
       
      
      private var var_232:LatencyTracker = null;
      
      private var var_233:PerformanceTracker = null;
      
      private var var_454:IAdManager;
      
      private var _roomEngine:IRoomEngine = null;
      
      private var var_403:IHabboHelp;
      
      private var _coreComponent:CoreComponent;
      
      private var var_1007:int = -1;
      
      private var var_1231:LagWarningLogger = null;
      
      private var var_838:IHabboWindowManager;
      
      private var var_1483:int = 0;
      
      private var var_1232:Array;
      
      private var var_2023:Boolean = false;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _navigator:IHabboNavigator;
      
      private var var_96:IHabboCatalog;
      
      private var var_179:IHabboFriendList;
      
      private var var_26:IHabboInventory;
      
      private var var_2024:Boolean = false;
      
      private var var_2328:Boolean = false;
      
      private var var_1484:int = 0;
      
      private var _widgets:IRoomWidgetFactory;
      
      private var var_180:IHabboConfigurationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _connection:IConnection = null;
      
      public function HabboTracking(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_233 = new PerformanceTracker();
         var_232 = new LatencyTracker();
         var_1231 = new LagWarningLogger();
         var_1232 = new Array(const_763);
         var _loc4_:int = 0;
         while(_loc4_ < const_763)
         {
            var_1232[_loc4_] = 0;
            _loc4_++;
         }
         var _loc5_:CoreComponent = param1 as CoreComponent;
         if(_loc5_ != null)
         {
            _loc5_.events.addEventListener(Component.COMPONENT_EVENT_ERROR,onError);
            _loc5_.events.addEventListener(Component.COMPONENT_EVENT_RUNNING,onCoreRunning);
            _coreComponent = _loc5_;
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_1208,new Date().getTime().toString());
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_1185,!true ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown");
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_1242,Capabilities.serverString);
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_674,String(false));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_884,String(0));
         }
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboNavigator(),onNavigatorReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboInventory(),onInventoryReady);
         queueInterface(new IIDHabboFriendList(),onFriendlistReady);
         queueInterface(new IIDHabboRoomWidget(),onRoomWidgetReady);
         queueInterface(new IIDHabboHelp(),onHelpReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboAdManager(),onAdManagerReady);
         registerUpdateReceiver(this,1);
      }
      
      private function onRoomAdClick(param1:RoomObjectRoomAdEvent) : void
      {
         track("room_ad","click",[getAliasFromAdTechUrl(param1.clickUrl)]);
      }
      
      private function onConnectionEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboCommunicationEvent.INIT:
               trackLoginStep(HabboLoginTrackingStep.const_13);
               break;
            case HabboCommunicationEvent.const_570:
               trackLoginStep(HabboLoginTrackingStep.const_12,String(_communication.port));
               break;
            case HabboCommunicationEvent.const_21:
               trackLoginStep(HabboLoginTrackingStep.const_21);
               break;
            case HabboCommunicationEvent.const_9:
               trackLoginStep(HabboLoginTrackingStep.const_9);
               break;
            case HabboCommunicationEvent.const_23:
               setErrorContextFlag(2,0);
               trackLoginStep(HabboLoginTrackingStep.const_23);
               break;
            case HabboCommunicationEvent.const_17:
               setErrorContextFlag(3,0);
               trackLoginStep(HabboLoginTrackingStep.const_17);
               if(var_232 != null)
               {
                  var_232.init();
               }
         }
         if(_communication)
         {
            Component(context).events.removeEventListener(param1.type,onConnectionEvent);
         }
      }
      
      private function onRoomWidgetReady(param1:IID, param2:IUnknown) : void
      {
         _widgets = param2 as IRoomWidgetFactory;
         Component(_widgets).events.addEventListener(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE,onWidgetTrackingEvent);
         Component(_widgets).events.addEventListener(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT,onWidgetTrackingEvent);
         Component(_widgets).events.addEventListener(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE,onWidgetTrackingEvent);
         Component(_widgets).events.addEventListener(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_EFFECTS,onWidgetTrackingEvent);
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            _connection = param1;
            if(var_233 != null)
            {
               var_233.connection = param1;
            }
            if(var_232 != null)
            {
               var_232.communication = _communication;
               var_232.connection = param1;
            }
         }
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_96 = IHabboCatalog(param2) as IHabboCatalog;
         var_96.events.addEventListener(CatalogPageOpenedEvent.CATALOG_PAGE_OPENED,onCatalogPageOpened);
         var_96.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN,onCatalogTrackingEvent);
         var_96.events.addEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE,onCatalogTrackingEvent);
      }
      
      private function onFriendlistTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED:
               setErrorContextFlag(0,6);
               break;
            case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS:
               setErrorContextFlag(1,6);
               break;
            case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH:
               setErrorContextFlag(2,6);
               break;
            case HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST:
               setErrorContextFlag(3,6);
               break;
            case HabboFriendListTrackingEvent.const_322:
               setErrorContextFlag(4,6);
         }
      }
      
      private function onConfigurationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_180 = IHabboConfigurationManager(param2);
         if(var_180)
         {
            Component(var_180).events.addEventListener(HabboConfigurationEvent.const_22,onConfigurationLoaded);
            if(var_232 != null)
            {
               var_232.configuration = var_180;
            }
            if(var_233 != null)
            {
               var_233.configuration = var_180;
            }
         }
      }
      
      private function onRoomSettingsTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED:
               setErrorContextFlag(0,7);
               break;
            case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT:
               setErrorContextFlag(1,7);
               break;
            case HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED:
               setErrorContextFlag(2,7);
         }
      }
      
      private function onCatalogTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN:
               setErrorContextFlag(1,9);
               break;
            case HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE:
               setErrorContextFlag(0,9);
         }
      }
      
      private function onWidgetTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE:
               setErrorContextFlag(0,8);
               break;
            case HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT:
               setErrorContextFlag(1,8);
               break;
            case HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE:
               setErrorContextFlag(2,8);
               break;
            case HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_EFFECTS:
               setErrorContextFlag(3,8);
         }
      }
      
      private function onAdManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_454 = param2 as IAdManager;
         var_454.events.addEventListener(AdEvent.const_369,onRoomAdLoad);
      }
      
      private function onInvetoryTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED:
               setErrorContextFlag(0,5);
               break;
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI:
               setErrorContextFlag(1,5);
               break;
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS:
               setErrorContextFlag(2,5);
               break;
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES:
               setErrorContextFlag(3,5);
               break;
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS:
               setErrorContextFlag(4,5);
               break;
            case HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING:
               setErrorContextFlag(5,5);
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(!var_2024)
         {
            trackLoginStep(HabboLoginTrackingStep.const_19);
            var_2024 = true;
         }
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         if(_loc2_.guestRoom)
         {
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_884,String(_loc2_.guestRoomId));
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_674,String(true));
            track("navigator","private",[_loc2_.guestRoomId]);
         }
         else if(_loc2_.publicSpace != null)
         {
            track("navigator","public",[_loc2_.publicSpace.unitPropertySet]);
         }
      }
      
      private function onRoomAdLoad(param1:AdEvent) : void
      {
         track("room_ad","show",[getAliasFromAdTechUrl(param1.clickUrl)]);
      }
      
      private function setErrorContextFlag(param1:uint, param2:uint) : void
      {
         var_1232[param2] = param1;
      }
      
      private function onRoomLeave(param1:CloseConnectionMessageEvent) : void
      {
         ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_674,String(false));
      }
      
      private function onWindowEvent(param1:Event) : void
      {
         if(param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP)
         {
            setErrorContextFlag(0,3);
         }
         else if(param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER)
         {
            setErrorContextFlag(1,3);
         }
         else if(param1.type == HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT)
         {
            setErrorContextFlag(2,3);
         }
      }
      
      private function onCommunicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _communication = IHabboCommunicationManager(param2);
         if(_communication != null)
         {
            _communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthOK));
            _communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _communication.addHabboConnectionMessageEvent(new CatalogIndexMessageEvent(onOpenCatalogue));
            _communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementNotification));
            _connection = _communication.getHabboMainConnection(onConnectionReady);
            if(_connection != null)
            {
               onConnectionReady(_connection);
            }
         }
         Component(context).events.addEventListener(HabboCommunicationEvent.INIT,onConnectionEvent);
         Component(context).events.addEventListener(HabboCommunicationEvent.const_570,onConnectionEvent);
         Component(context).events.addEventListener(HabboCommunicationEvent.const_21,onConnectionEvent);
         Component(context).events.addEventListener(HabboCommunicationEvent.const_23,onConnectionEvent);
         Component(context).events.addEventListener(HabboCommunicationEvent.const_9,onConnectionEvent);
         Component(context).events.addEventListener(HabboCommunicationEvent.const_17,onConnectionEvent);
         Component(context).events.addEventListener(HabboHotelViewEvent.const_556,onHotelViewEvent);
         Component(context).events.addEventListener(HabboHotelViewEvent.const_59,onHotelViewEvent);
         Component(context).events.addEventListener(HabboHotelViewEvent.const_390,onHotelViewEvent);
      }
      
      private function onOpenCatalogue(param1:IMessageEvent) : void
      {
         track("catalogue","open");
      }
      
      private function onLagWarningEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case AvatarWalkWarpingWarningEvent.const_352:
               var_1231.registerWarning(LagWarningLogger.const_966);
         }
      }
      
      private function onCatalogPageOpened(param1:CatalogPageOpenedEvent) : void
      {
         track("catalogue","page",[param1.pageLocalization]);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_communication)
            {
               _communication.release(new IIDHabboCommunicationManager());
               _communication = null;
            }
            if(var_180)
            {
               var_180.release(new IIDHabboConfigurationManager());
               var_180 = null;
            }
            if(_localization)
            {
               _localization.release(new IIDHabboLocalizationManager());
               _localization = null;
            }
            if(var_838)
            {
               var_838.release(new IIDHabboWindowManager());
               var_838 = null;
            }
            if(var_454)
            {
               var_454.release(new IIDHabboAdManager());
               var_454 = null;
            }
            if(_navigator)
            {
               if(true)
               {
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH,onNavigatorTrackingEvent);
                  _navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED,onRoomSettingsTrackingEvent);
                  _navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT,onRoomSettingsTrackingEvent);
                  _navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED,onRoomSettingsTrackingEvent);
                  _navigator.events.removeEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS,onRoomSettingsTrackingEvent);
               }
               _navigator.release(new IIDHabboNavigator());
               _navigator = null;
            }
            if(var_96)
            {
               if(true)
               {
                  var_96.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_CLOSE,onCatalogTrackingEvent);
                  var_96.events.removeEventListener(HabboCatalogTrackingEvent.HABBO_CATALOG_TRACKING_EVENT_OPEN,onCatalogTrackingEvent);
               }
               var_96.release(new IIDHabboCatalog());
               var_96 = null;
            }
            if(var_26)
            {
               if(true)
               {
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED,onInvetoryTrackingEvent);
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI,onInvetoryTrackingEvent);
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS,onInvetoryTrackingEvent);
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES,onInvetoryTrackingEvent);
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS,onInvetoryTrackingEvent);
                  Component(var_26).events.removeEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING,onInvetoryTrackingEvent);
               }
               var_26.release(new IIDHabboInventory());
               var_26 = null;
            }
            if(var_179)
            {
               if(true)
               {
                  Component(var_179).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED,onFriendlistTrackingEvent);
                  Component(var_179).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS,onFriendlistTrackingEvent);
                  Component(var_179).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH,onFriendlistTrackingEvent);
                  Component(var_179).events.removeEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST,onFriendlistTrackingEvent);
                  Component(var_179).events.removeEventListener(HabboFriendListTrackingEvent.const_322,onFriendlistTrackingEvent);
               }
               var_179.release(new IIDHabboFriendList());
               var_179 = null;
            }
            if(var_403)
            {
               if(true)
               {
                  var_403.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED,onHelpTrackingEvent);
                  var_403.events.removeEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT,onHelpTrackingEvent);
               }
               var_403.release(new IIDHabboHelp());
               var_403 = null;
            }
            if(_roomEngine)
            {
               if(true)
               {
                  Component(_roomEngine).events.removeEventListener(AvatarWalkWarpingWarningEvent.const_352,onLagWarningEvent);
               }
            }
            removeUpdateReceiver(this);
            if(var_233 != null)
            {
               var_233.dispose();
               var_233 = null;
            }
            if(var_232 != null)
            {
               var_232.dispose();
               var_232 = null;
            }
            _connection = null;
            super.dispose();
         }
      }
      
      private function onConfigurationLoaded(param1:Event) : void
      {
         setErrorContextFlag(1,0);
         trackLoginStep(HabboLoginTrackingStep.const_22);
         if(var_180)
         {
            Component(var_180).events.removeEventListener(HabboConfigurationEvent.const_22,onConfigurationLoaded);
         }
      }
      
      private function onLocalizationLoaded(param1:Event) : void
      {
         setErrorContextFlag(1,1);
         trackLoginStep(HabboLoginTrackingStep.const_14);
         if(_localization)
         {
            Component(_localization).events.removeEventListener(LocalizationEvent.const_14,onLocalizationLoaded);
         }
      }
      
      private function onHelpReady(param1:IID, param2:IUnknown) : void
      {
         var_403 = param2 as IHabboHelp;
         var_403.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED,onHelpTrackingEvent);
         var_403.events.addEventListener(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT,onHelpTrackingEvent);
      }
      
      public function logError(param1:String) : void
      {
         Logger.log("logError(" + param1 + ")");
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.logError",param1);
         }
         else
         {
            Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      private function onCoreRunning(param1:Event) : void
      {
         trackLoginStep(HabboLoginTrackingStep.const_18);
         if(_coreComponent != null)
         {
            _coreComponent.events.removeEventListener(HabboLoginTrackingStep.const_18,onCoreRunning);
         }
      }
      
      private function onHelpTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED:
               setErrorContextFlag(0,10);
               break;
            case HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT:
               setErrorContextFlag(1,10);
         }
      }
      
      private function onNavigatorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _navigator = IHabboNavigator(param2) as IHabboNavigator;
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH,onNavigatorTrackingEvent);
         _navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED,onRoomSettingsTrackingEvent);
         _navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT,onRoomSettingsTrackingEvent);
         _navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED,onRoomSettingsTrackingEvent);
         _navigator.events.addEventListener(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS,onRoomSettingsTrackingEvent);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_838 = IHabboWindowManager(param2);
         if(var_838)
         {
            Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_INPUT,onWindowEvent);
            Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_RENDER,onWindowEvent);
            Component(context).events.addEventListener(HabboWindowTrackingEvent.HABBO_WINDOW_TRACKING_EVENT_SLEEP,onWindowEvent);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = getTimer();
         if(var_1007 > -1 && _loc2_ < var_1007)
         {
            ++var_1484;
            ErrorReportStorage.addDebugData("Invalid time counter","Invalid times: " + var_1484);
         }
         if(var_1007 > -1 && _loc2_ - var_1007 > 15000)
         {
            ++var_1483;
            ErrorReportStorage.addDebugData("Time leap counter","Time leaps: " + var_1483);
         }
         var_1007 = _loc2_;
         if(var_233 != null)
         {
            var_233.update(param1);
         }
         if(var_232 != null)
         {
            var_232.update(param1);
         }
         if(var_1231 != null)
         {
            var_1231.update(param1);
         }
      }
      
      public function trackLoginStep(param1:String, param2:String = null) : void
      {
         if(var_180 != null && Boolean(var_180.getKey("processlog.enabled") == false))
         {
            return;
         }
         Logger.log("* Track Login Step: " + param1);
         if(false)
         {
            if(param2 != null)
            {
               ExternalInterface.call("FlashExternalInterface.logLoginStep",param1,param2);
            }
            else
            {
               ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
            }
         }
         else
         {
            Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      private function onNavigatorTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED:
               setErrorContextFlag(0,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS:
               setErrorContextFlag(1,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS:
               setErrorContextFlag(2,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_ME:
               setErrorContextFlag(3,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL:
               setErrorContextFlag(4,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH:
               setErrorContextFlag(5,4);
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_LATEST_EVENTS:
               track("navigator","latest_events");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES:
               track("navigator","my_favorites");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS:
               track("navigator","my_friends_rooms");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY:
               track("navigator","my_history");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS:
               track("navigator","my_rooms");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS:
               track("navigator","official_rooms");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS:
               track("navigator","popular_rooms");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE:
               track("navigator","rooms_where_my_friends_are");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE:
               track("navigator","highest_score");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH:
               track("navigator","tag_search");
               break;
            case HabboNavigatorTrackingEvent.HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH:
               track("navigator","text_search");
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomEngine = param2 as IRoomEngine;
         if(_roomEngine == null)
         {
            return;
         }
         Component(_roomEngine).events.addEventListener(AvatarWalkWarpingWarningEvent.const_352,onLagWarningEvent);
         Component(_roomEngine).events.addEventListener(RoomObjectRoomAdEvent.const_268,onRoomAdClick);
      }
      
      private function getAliasFromAdTechUrl(param1:String) : String
      {
         var _loc2_:Array = param1.match(/;alias=([^;]+)/);
         if(_loc2_ != null && _loc2_.length > 1)
         {
            return _loc2_[1];
         }
         return "unknown";
      }
      
      private function onAchievementNotification(param1:HabboAchievementNotificationMessageEvent) : void
      {
         track("achievement","achievement",[param1.badgeID]);
      }
      
      public function track(param1:String, param2:String, param3:Array = null) : void
      {
         Logger.log("track(" + param1 + ", " + param2 + ", " + param3 + ")");
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.track",param1,param2,param3 == null ? [] : param3);
         }
         else
         {
            Logger.log("com.sulake.habbo.tracking: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      private function onAuthOK(param1:IMessageEvent) : void
      {
         track("authentication","authok");
      }
      
      private function onInventoryReady(param1:IID, param2:IUnknown) : void
      {
         var_26 = param2 as IHabboInventory;
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_CLOSED,onInvetoryTrackingEvent);
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI,onInvetoryTrackingEvent);
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS,onInvetoryTrackingEvent);
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_BADGES,onInvetoryTrackingEvent);
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS,onInvetoryTrackingEvent);
         Component(var_26).events.addEventListener(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING,onInvetoryTrackingEvent);
      }
      
      private function onFriendlistReady(param1:IID, param2:IUnknown) : void
      {
         var_179 = param2 as IHabboFriendList;
         Component(var_179).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED,onFriendlistTrackingEvent);
         Component(var_179).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_FRIENDS,onFriendlistTrackingEvent);
         Component(var_179).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_SEARCH,onFriendlistTrackingEvent);
         Component(var_179).events.addEventListener(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_REQUEST,onFriendlistTrackingEvent);
         Component(var_179).events.addEventListener(HabboFriendListTrackingEvent.const_322,onFriendlistTrackingEvent);
      }
      
      private function onError(param1:ErrorEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         if(param1.critical && !var_2023)
         {
            var_2023 = true;
            ErrorReportStorage.setParameter(HabboErrorVariableEnum.const_1213,new Date().getTime().toString());
            if(var_180)
            {
               if(var_180.keyExists("client.fatal.error.url"))
               {
                  _loc2_ = var_180.getKey("client.fatal.error.url");
                  _loc3_ = new URLRequest(_loc2_);
                  _loc4_ = new URLVariables();
                  _loc5_ = ErrorReportStorage.getParameterNames();
                  _loc6_ = _loc5_.length;
                  _loc7_ = 0;
                  while(_loc7_ < _loc6_)
                  {
                     _loc4_[_loc5_[_loc7_]] = ErrorReportStorage.getParameter(_loc5_[_loc7_]);
                     _loc7_++;
                  }
                  _loc8_ = "";
                  for each(_loc9_ in var_1232)
                  {
                     _loc8_ += String(_loc9_);
                  }
                  _loc4_["null"] = _loc8_;
                  if(var_233 != null)
                  {
                     _loc4_["null"] = var_233.flashVersion;
                     _loc4_["null"] = var_233.averageUpdateInterval;
                  }
                  ErrorReportStorage.addDebugData("Flash memory usage","Memory usage: " + Math.round(0 / (1024 * 1024)) + " MB");
                  _loc4_["null"] = ErrorReportStorage.getDebugData();
                  _loc3_.data = _loc4_;
                  _loc3_.method = URLRequestMethod.POST;
                  navigateToURL(_loc3_,"_self");
               }
            }
         }
         logError(_coreComponent.getLastErrorMessage());
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _localization = IHabboLocalizationManager(param2);
         if(_localization)
         {
            Component(_localization).events.addEventListener(LocalizationEvent.const_14,onLocalizationLoaded);
         }
      }
      
      private function onHotelViewEvent(param1:Event) : void
      {
         if(param1.type == HabboHotelViewEvent.const_556)
         {
            trackLoginStep(HabboLoginTrackingStep.const_15);
         }
         else if(param1.type == HabboHotelViewEvent.const_390)
         {
            trackLoginStep(HabboLoginTrackingStep.const_20);
         }
         else if(param1.type == HabboHotelViewEvent.const_59)
         {
            trackLoginStep(HabboLoginTrackingStep.const_25);
         }
      }
   }
}
