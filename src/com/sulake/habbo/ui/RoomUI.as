package com.sulake.habbo.ui
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.advertisement.IAdManager;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IHabboAvatarEditor;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.events.RoomSessionPollEvent;
   import com.sulake.habbo.session.events.RoomSessionPresentEvent;
   import com.sulake.habbo.session.events.RoomSessionQueueEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionVoteEvent;
   import com.sulake.habbo.sound.IHabboSoundManager;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.widget.IRoomWidgetFactory;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboAdManager;
   import com.sulake.iid.IIDHabboAvatarEditor;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboModeration;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomWidget;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.Event;
   import iid.IIDHabboWindowManager;
   
   public class RoomUI extends Component implements IRoomUI, ICoreUpdateReceiver
   {
       
      
      private var var_781:IHabboSoundManager;
      
      private var var_1773:IHabboAvatarEditor = null;
      
      private var var_454:IAdManager;
      
      private var var_780:IRoomWidgetFactory;
      
      private var var_34:IRoomSessionManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1154:IAvatarRenderManager;
      
      private var var_258:Map;
      
      private var var_208:IHabboToolbar;
      
      private var var_1398:IHabboModeration;
      
      private var var_589:ISessionDataManager;
      
      private var _navigator:IHabboNavigator;
      
      private var var_96:IHabboCatalog;
      
      private var var_26:IHabboInventory;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_1397:int = -1;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _friendList:IHabboFriendList;
      
      private var _connection:IConnection;
      
      private var var_1774:IHabboHelp;
      
      public function RoomUI(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
         queueInterface(new IIDHabboRoomWidget(),onRoomWidgetFactoryReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDHabboFriendList(),onFriendListReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderManagerReady);
         queueInterface(new IIDHabboInventory(),onInventoryReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboNavigator(),onNavigatorReady);
         queueInterface(new IIDHabboAvatarEditor(),onAvatarEditorReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboAdManager(),onAdManagerReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationManagerReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboModeration(),onHabboModerationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationManagerReady);
         queueInterface(new IIDHabboSoundManager(),onSoundManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationReady);
         var_258 = new Map();
         registerUpdateReceiver(this,0);
      }
      
      public function createDesktop(param1:IRoomSession) : IRoomDesktop
      {
         if(param1 == null)
         {
            return null;
         }
         if(_roomEngine == null)
         {
            return null;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId,param1.roomCategory);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = new RoomDesktop(param1,assets,_connection);
         _loc3_.roomEngine = _roomEngine;
         _loc3_.windowManager = _windowManager;
         _loc3_.roomWidgetFactory = var_780;
         _loc3_.sessionDataManager = var_589;
         _loc3_.roomSessionManager = var_34;
         _loc3_.friendList = _friendList;
         _loc3_.avatarRenderManager = var_1154;
         _loc3_.inventory = var_26;
         _loc3_.toolbar = var_208;
         _loc3_.navigator = _navigator;
         _loc3_.avatarEditor = var_1773;
         _loc3_.catalog = var_96;
         _loc3_.adManager = var_454;
         _loc3_.localization = _localization;
         _loc3_.habboHelp = var_1774;
         _loc3_.moderation = var_1398;
         _loc3_.config = _config;
         _loc3_.soundManager = var_781;
         var _loc4_:XmlAsset = _assets.getAssetByName("room_desktop_layout_xml") as XmlAsset;
         if(_loc4_ != null)
         {
            _loc3_.layout = _loc4_.content as XML;
         }
         _loc3_.createWidget(RoomWidgetEnum.const_358);
         _loc3_.createWidget(RoomWidgetEnum.const_702);
         _loc3_.init();
         var_258.add(_loc2_,_loc3_);
         return _loc3_;
      }
      
      public function processWidgetMessage(param1:int, param2:int, param3:RoomWidgetMessage) : void
      {
         if(param3 == null)
         {
            return;
         }
         if(_roomEngine == null)
         {
            return;
         }
         var _loc4_:String = getRoomIdentifier(param1,param2);
         var _loc5_:RoomDesktop = getDesktop(_loc4_) as RoomDesktop;
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.processWidgetMessage(param3);
      }
      
      private function onSoundManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_781 = param2 as IHabboSoundManager;
      }
      
      public function getDesktop(param1:String) : IRoomDesktop
      {
         return var_258.getValue(param1) as RoomDesktop;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_96 = param2 as IHabboCatalog;
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         var _loc2_:* = null;
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomSessionEvent.const_282:
               _loc2_ = createDesktop(param1.session);
               break;
            case RoomSessionEvent.const_88:
               break;
            case RoomSessionEvent.const_96:
               if(param1.session != null)
               {
                  disposeDesktop(getRoomIdentifier(param1.session.roomId,param1.session.roomCategory));
                  var_208.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_154,HabboToolbarIconEnum.ZOOM));
                  var_208.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_154,HabboToolbarIconEnum.MEMENU));
                  var_208.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_154,HabboToolbarIconEnum.INVENTORY));
               }
         }
      }
      
      private function onAdManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_454 = param2 as IAdManager;
         if(var_454 != null && false)
         {
            var_454.events.addEventListener(AdEvent.const_472,adEventHandler);
            var_454.events.addEventListener(AdEvent.const_424,adEventHandler);
            var_454.events.addEventListener(AdEvent.const_369,adEventHandler);
         }
      }
      
      private function adEventHandler(param1:AdEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId,param1.roomCategory);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.processEvent(param1);
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
         }
      }
      
      private function onRoomWidgetFactoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_780 = param2 as IRoomWidgetFactory;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_windowManager != null)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_roomEngine != null)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(var_34 != null)
         {
            var_34.release(new IIDHabboRoomSessionManager());
            var_34 = null;
         }
         if(var_780 != null)
         {
            var_780.release(new IIDHabboRoomWidget());
            var_780 = null;
         }
         if(var_26 != null)
         {
            var_26.release(new IIDHabboInventory());
            var_26 = null;
         }
         if(var_208 != null)
         {
            var_208.release(new IIDHabboToolbar());
            var_208 = null;
         }
         if(_config != null)
         {
            _config.release(new IIDHabboConfigurationManager());
            _config = null;
         }
         if(var_781 != null)
         {
            var_781.release(new IIDHabboSoundManager());
            var_781 = null;
         }
         if(var_258)
         {
            while(false)
            {
               _loc1_ = var_258.getKey(0) as String;
               _loc2_ = var_258.remove(_loc1_) as RoomDesktop;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            var_258.dispose();
            var_258 = null;
         }
         removeUpdateReceiver(this);
         super.dispose();
      }
      
      public function disposeDesktop(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:RoomDesktop = var_258.remove(param1) as RoomDesktop;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getWidgetState(RoomWidgetEnum.const_234);
            if(_loc3_ != RoomDesktop.const_588)
            {
               var_1397 = _loc3_;
            }
            _loc2_.dispose();
         }
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1774 = param2 as IHabboHelp;
      }
      
      private function onCommunicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:IHabboCommunicationManager = param2 as IHabboCommunicationManager;
         if(_loc3_ != null)
         {
            _connection = _loc3_.getHabboMainConnection(onConnectionReady);
            if(_connection != null)
            {
               onConnectionReady(_connection);
            }
         }
      }
      
      private function onHabboModerationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1398 = param2 as IHabboModeration;
         Logger.log("XXXX GOT HABBO MODERATION: " + var_1398);
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_589 = param2 as ISessionDataManager;
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_roomEngine == null)
         {
            return;
         }
         if(param1.session != null)
         {
            _loc2_ = getRoomIdentifier(param1.session.roomId,param1.session.roomCategory);
            _loc3_ = getDesktop(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.processEvent(param1);
            }
         }
      }
      
      private function onLocalizationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _localization = param2 as IHabboLocalizationManager;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
         initializeRoomEngineEvents();
         if(var_34 != null && _roomEngine != null && false)
         {
            var_34.roomEngineReady = true;
         }
      }
      
      private function onFriendListReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _friendList = param2 as IHabboFriendList;
      }
      
      private function onNavigatorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as IHabboNavigator;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_258.length)
         {
            _loc3_ = var_258.getWithIndex(_loc2_) as RoomDesktop;
            if(_loc3_ != null)
            {
               _loc3_.update();
            }
            _loc2_++;
         }
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId,param1.roomCategory);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ == null)
         {
            if(var_34 == null)
            {
               return;
            }
            _loc4_ = var_34.getSession(param1.roomId,param1.roomCategory);
            if(_loc4_ != null)
            {
               _loc3_ = createDesktop(_loc4_) as RoomDesktop;
            }
         }
         if(_loc3_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomEngineEvent.const_510:
               _loc3_.createRoomView(getActiveCanvasId(param1.roomId,param1.roomCategory));
               if(!_roomEngine.isPublicRoomWorldType(_roomEngine.getWorldType(param1.roomId,param1.roomCategory)))
               {
                  _loc6_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_159,HabboToolbarIconEnum.ZOOM);
                  _loc6_.iconState = "2";
                  var_208.events.dispatchEvent(_loc6_);
               }
               _loc3_.createWidget(RoomWidgetEnum.const_285);
               _loc3_.createWidget(RoomWidgetEnum.const_379);
               if(!_loc3_.session.isSpectatorMode)
               {
                  _loc3_.createWidget(RoomWidgetEnum.const_437);
                  _loc3_.createWidget(RoomWidgetEnum.CHAT_INPUT_WIDGET);
               }
               _loc3_.createWidget(RoomWidgetEnum.const_587);
               _loc3_.createWidget(RoomWidgetEnum.const_422);
               _loc3_.createWidget(RoomWidgetEnum.const_413);
               _loc3_.createWidget(RoomWidgetEnum.const_451);
               _loc3_.createWidget(RoomWidgetEnum.const_366);
               _loc3_.createWidget(RoomWidgetEnum.const_398);
               _loc3_.createWidget(RoomWidgetEnum.const_101);
               _loc3_.createWidget(RoomWidgetEnum.const_382);
               _loc3_.createWidget(RoomWidgetEnum.const_120);
               _loc3_.createWidget(RoomWidgetEnum.const_234);
               _loc3_.createWidget(RoomWidgetEnum.const_401);
               if(var_1397 != RoomDesktop.const_588)
               {
                  _loc3_.initializeWidget(RoomWidgetEnum.const_234,var_1397);
               }
               if(var_454 != null)
               {
                  var_454.showRoomAd();
               }
               if(_roomEngine != null)
               {
                  _roomEngine.setActiveRoom(param1.roomId,param1.roomCategory);
               }
               break;
            case RoomEngineEvent.const_608:
               disposeDesktop(_loc2_);
               break;
            case RoomEngineRoomColorEvent.const_529:
               _loc5_ = param1 as RoomEngineRoomColorEvent;
               if(_loc5_ == null)
               {
                  break;
               }
               if(_loc5_.bgOnly)
               {
                  _loc3_.setRoomViewColor(16777215,255);
               }
               else
               {
                  _loc3_.setRoomViewColor(_loc5_.color,_loc5_.brightness);
               }
               break;
            case RoomEngineDimmerStateEvent.DIMMER_STATE:
               _loc3_.processEvent(param1);
         }
      }
      
      private function roomSessionDialogEventHandler(param1:RoomSessionEvent) : void
      {
         var errorMessage:String = null;
         var event:RoomSessionEvent = param1;
         var errorTitle:String = "${error.title}";
         switch(event.type)
         {
            case RoomSessionErrorMessageEvent.const_203:
               errorMessage = "${room.error.cant_trade_stuff}";
               break;
            case RoomSessionErrorMessageEvent.const_213:
               errorMessage = "${room.error.cant_set_item}";
               break;
            case RoomSessionErrorMessageEvent.const_643:
               errorMessage = "${room.error.cant_set_not_owner}";
               break;
            case RoomSessionErrorMessageEvent.const_191:
               errorMessage = "${room.error.max_furniture}";
               break;
            case RoomSessionErrorMessageEvent.const_157:
               errorMessage = "${room.error.max_pets}";
               break;
            case RoomSessionErrorMessageEvent.const_185:
               errorMessage = "${room.error.max_queuetiles}";
               break;
            case RoomSessionErrorMessageEvent.const_205:
               errorMessage = "${room.error.max_soundfurni}";
               break;
            case RoomSessionErrorMessageEvent.const_198:
               errorMessage = "${room.error.max_stickies}";
               break;
            case RoomSessionErrorMessageEvent.const_192:
               errorMessage = "${room.error.kicked}";
               errorTitle = "${generic.alert.title}";
               break;
            case RoomSessionErrorMessageEvent.const_221:
               errorMessage = "${room.error.guide.not.available}";
               break;
            case RoomSessionErrorMessageEvent.const_186:
               errorMessage = "${room.error.guide.already.exists}";
               break;
            case RoomSessionErrorMessageEvent.const_525:
               errorMessage = "${room.error.pets.forbidden_in_hotel}";
               break;
            case RoomSessionErrorMessageEvent.const_656:
               errorMessage = "${room.error.pets.forbidden_in_flat}";
               break;
            case RoomSessionErrorMessageEvent.const_625:
               errorMessage = "${room.error.pets.no_free_tiles}";
               break;
            case RoomSessionErrorMessageEvent.const_655:
               errorMessage = "${room.error.pets.selected_tile_not_free}";
               break;
            default:
               return;
         }
         _windowManager.alert(errorTitle,errorMessage,0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _windowManager = param2 as IHabboWindowManager;
      }
      
      public function getActiveCanvasId(param1:int, param2:int) : int
      {
         return 1;
      }
      
      private function initializeRoomEngineEvents() : void
      {
         if(_roomEngine != null && false)
         {
            _roomEngine.events.addEventListener(RoomEngineEvent.ROOM_ENGINE_INITIALIZED,roomEngineEventHandler);
            _roomEngine.events.addEventListener(RoomEngineEvent.const_510,roomEventHandler);
            _roomEngine.events.addEventListener(RoomEngineEvent.const_608,roomEventHandler);
            _roomEngine.events.addEventListener(RoomEngineDimmerStateEvent.DIMMER_STATE,roomEventHandler);
            _roomEngine.events.addEventListener(RoomEngineRoomColorEvent.const_529,roomEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_596,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_371,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_253,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_720,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_188,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_503,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_125,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_114,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_PRESENT,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_108,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_117,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_115,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_109,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_477,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_435,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_344,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_345,roomObjectEventHandler);
            _roomEngine.events.addEventListener(RoomEngineObjectEvent.const_90,roomObjectEventHandler);
         }
      }
      
      private function onAvatarRenderManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1154 = param2 as IAvatarRenderManager;
      }
      
      private function onInventoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_26 = param2 as IHabboInventory;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_208 = param2 as IHabboToolbar;
      }
      
      private function getRoomIdentifier(param1:int, param2:int) : String
      {
         return "hard_coded_room_id";
      }
      
      private function onConfigurationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _config = param2 as IHabboConfigurationManager;
      }
      
      private function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId,param1.roomCategory);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomObjectEventHandler(param1);
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_34 = param2 as IRoomSessionManager;
         registerSessionEvents();
         if(var_34 != null && _roomEngine != null && false)
         {
            var_34.roomEngineReady = true;
         }
      }
      
      private function registerSessionEvents() : void
      {
         if(var_34)
         {
            var_34.events.addEventListener(RoomSessionEvent.const_282,roomSessionStateEventHandler);
            var_34.events.addEventListener(RoomSessionEvent.const_88,roomSessionStateEventHandler);
            var_34.events.addEventListener(RoomSessionEvent.const_96,roomSessionStateEventHandler);
            var_34.events.addEventListener(RoomSessionChatEvent.const_151,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionUserBadgesEvent.const_111,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionDoorbellEvent.const_101,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionDoorbellEvent.const_116,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionDoorbellEvent.const_107,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionPresentEvent.const_228,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_203,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_213,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_643,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_819,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_928,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_191,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_185,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_205,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_198,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_192,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_186,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_221,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_525,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_656,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_157,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_625,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionErrorMessageEvent.const_655,roomSessionDialogEventHandler);
            var_34.events.addEventListener(RoomSessionQueueEvent.const_467,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionVoteEvent.const_106,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionVoteEvent.const_127,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionPollEvent.const_123,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionPollEvent.const_59,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionPollEvent.const_112,roomSessionEventHandler);
            var_34.events.addEventListener(RoomSessionDimmerPresetsEvent.const_474,roomSessionEventHandler);
         }
      }
      
      private function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == RoomEngineEvent.ROOM_ENGINE_INITIALIZED)
         {
            if(var_34 != null)
            {
               var_34.roomEngineReady = true;
            }
         }
      }
      
      private function onAvatarEditorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1773 = param2 as IHabboAvatarEditor;
      }
   }
}
