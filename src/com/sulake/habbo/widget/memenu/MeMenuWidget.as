package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarActionUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetCreditBalanceUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetDanceUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetWaveUpdateEvent;
   import com.sulake.habbo.widget.memenu.enum.HabboMeMenuTrackingEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuWidget extends RoomWidgetBase
   {
      
      public static const const_534:String = "me_menu_settings_view";
      
      private static const const_749:int = 10;
      
      public static const const_592:String = "me_menu_effects_view";
      
      public static const const_124:String = "me_menu_top_view";
      
      public static const const_1368:String = "me_menu_rooms_view";
      
      public static const const_915:String = "me_menu_dance_moves_view";
      
      public static const const_247:String = "me_menu_my_clothes_view";
       
      
      private var var_1828:Boolean = false;
      
      private var _isAnimating:Boolean = false;
      
      private var _eventDispatcher:IEventDispatcher;
      
      private var var_1413:int = 0;
      
      private var var_1826:int = 0;
      
      private var var_1825:Boolean = false;
      
      private var var_260:Boolean = false;
      
      private var var_1823:int = 0;
      
      private var var_1827:Number = 0;
      
      private var _mainContainer:IWindowContainer;
      
      private var var_536:Boolean = false;
      
      private var var_100:ClubPromoView;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_1148:int = 0;
      
      private var var_1824:Boolean = false;
      
      private var var_962:Point;
      
      private var var_42:IMeMenuView;
      
      public function MeMenuWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IEventDispatcher, param5:IHabboConfigurationManager)
      {
         super(param1,param2,param3);
         _config = param5;
         var_962 = new Point(0,0);
         _eventDispatcher = param4;
         if(param5 != null && false)
         {
            var_1824 = param5.getKey("client.news.embed.enabled","UserCountRenderer") == "true";
         }
         changeView(const_124);
         hide();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetWaveUpdateEvent.const_679,onWaveEvent);
         param1.addEventListener(RoomWidgetDanceUpdateEvent.const_607,onDanceEvent);
         param1.addEventListener(RoomWidgetUpdateEffectsUpdateEvent.const_517,onUpdateEffects);
         param1.addEventListener(RoomWidgetToolbarClickedUpdateEvent.const_724,onToolbarClicked);
         param1.addEventListener(RoomWidgetFrameUpdateEvent.const_281,onUpdate);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_634,onAvatarEditorClosed);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_421,onShowAvatarEditorClubPromo);
         param1.addEventListener(RoomWidgetAvatarEditorUpdateEvent.const_976,onHideAvatarEditorClubPromo);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_222,onAvatarDeselected);
         param1.addEventListener(RoomWidgetHabboClubUpdateEvent.const_209,onHabboClubEvent);
         param1.addEventListener(RoomWidgetAvatarActionUpdateEvent.const_569,onAvatarActionEvent);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_195,onUserInfo);
         param1.addEventListener(RoomWidgetSettingsUpdateEvent.const_300,onSettingsUpdate);
         param1.addEventListener(RoomWidgetTutorialEvent.const_95,onTutorialEvent);
         param1.addEventListener(RoomWidgetTutorialEvent.const_389,onTutorialEvent);
         param1.addEventListener(RoomWidgetCreditBalanceUpdateEvent.const_165,onCreditBalance);
         super.registerUpdateEvents(param1);
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         if(!_isAnimating)
         {
            return;
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         return _mainContainer;
      }
      
      public function get hasEffectOn() : Boolean
      {
         return var_536;
      }
      
      private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent) : void
      {
         if(!var_260)
         {
            return;
         }
         if(var_42.window.name == const_534)
         {
            (var_42 as MeMenuSettingsView).updateSettings(param1);
         }
      }
      
      public function get isHabboClubActive() : Boolean
      {
         return var_1148 > 0;
      }
      
      private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Wave Event received");
      }
      
      private function onCreditBalance(param1:RoomWidgetCreditBalanceUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1413 = param1.balance;
         localizations.registerParameter("widget.memenu.credits","credits",var_1413.toString());
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var _loc2_:* = null;
         if(!(var_260 && var_42.window.name == const_247))
         {
            _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.const_644);
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(_loc2_);
            }
         }
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetWaveUpdateEvent.const_679,onWaveEvent);
         param1.removeEventListener(RoomWidgetDanceUpdateEvent.const_607,onDanceEvent);
         param1.removeEventListener(RoomWidgetUpdateEffectsUpdateEvent.const_517,onUpdateEffects);
         param1.removeEventListener(RoomWidgetToolbarClickedUpdateEvent.const_724,onToolbarClicked);
         param1.removeEventListener(RoomWidgetFrameUpdateEvent.const_281,onUpdate);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_222,onAvatarDeselected);
         param1.removeEventListener(RoomWidgetHabboClubUpdateEvent.const_209,onHabboClubEvent);
         param1.removeEventListener(RoomWidgetAvatarActionUpdateEvent.const_569,onAvatarActionEvent);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_634,onAvatarEditorClosed);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_421,onShowAvatarEditorClubPromo);
         param1.removeEventListener(RoomWidgetAvatarEditorUpdateEvent.const_976,onHideAvatarEditorClubPromo);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_195,onUserInfo);
         param1.removeEventListener(RoomWidgetSettingsUpdateEvent.const_300,onSettingsUpdate);
         param1.removeEventListener(RoomWidgetTutorialEvent.const_389,onTutorialEvent);
         param1.removeEventListener(RoomWidgetTutorialEvent.const_95,onTutorialEvent);
         param1.removeEventListener(RoomWidgetCreditBalanceUpdateEvent.const_165,onCreditBalance);
      }
      
      override public function dispose() : void
      {
         hide();
         _eventDispatcher = null;
         if(var_42 != null)
         {
            var_42.dispose();
            var_42 = null;
         }
         super.dispose();
      }
      
      public function get allowHabboClubDances() : Boolean
      {
         return var_1828;
      }
      
      public function changeToOutfit(param1:int) : void
      {
         var_1827 = new Date().valueOf();
         this.messageListener.processWidgetMessage(new RoomWidgetSelectOutfitMessage(param1));
      }
      
      private function onHideAvatarEditorClubPromo(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_100 != null)
         {
            var_100.dispose();
            var_100 = null;
         }
         updateSize();
      }
      
      public function get isDancing() : Boolean
      {
         return var_1825;
      }
      
      public function get creditBalance() : int
      {
         return var_1413;
      }
      
      private function onTutorialEvent(param1:RoomWidgetTutorialEvent) : void
      {
         switch(param1.type)
         {
            case RoomWidgetTutorialEvent.const_389:
               Logger.log("* MeMenuWidget: onHighlightClothesIcon " + var_260 + " view: " + var_42.window.name);
               if(var_260 != true || var_42.window.name != const_124)
               {
                  return;
               }
               (var_42 as MeMenuMainView).setIconAssets("clothes_icon",const_124,"clothes_highlighter_blue");
               break;
            case RoomWidgetTutorialEvent.const_95:
               hide();
         }
      }
      
      public function canChangeOutfit() : Boolean
      {
         var _loc1_:Number = new Date().valueOf();
         return _loc1_ - var_1827 > 5000;
      }
      
      public function get habboClubPeriods() : int
      {
         return var_1826;
      }
      
      private function onAvatarActionEvent(param1:RoomWidgetAvatarActionUpdateEvent) : void
      {
         switch(param1.actionType)
         {
            case RoomWidgetAvatarActionUpdateEvent.EFFECT_ACTIVE:
               var_536 = true;
               break;
            case RoomWidgetAvatarActionUpdateEvent.EFFECT_INACTIVE:
               var_536 = false;
               break;
            default:
               trace("MeMenuWidget: unknown avatar action event: " + param1.actionType);
         }
      }
      
      private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent) : void
      {
         var _loc2_:* = var_1148 > 0;
         var_1148 = param1.daysLeft;
         var_1826 = param1.periodsLeft;
         var_1823 = param1.pastPeriods;
         var_1828 = param1.allowClubDances;
         if(_loc2_ != param1.daysLeft > 0)
         {
            if(var_42 != null)
            {
               changeView(var_42.window.name);
            }
         }
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         var_1825 = param1;
      }
      
      private function onAvatarDeselected(param1:Event) : void
      {
         if(var_42 != null && var_42.window.name != const_247)
         {
            hide();
         }
      }
      
      private function onShowAvatarEditorClubPromo(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         var _loc2_:* = null;
         if(var_42 != null && var_42.window.name == const_247)
         {
            if(param1.promoMode == RoomWidgetAvatarEditorUpdateEvent.const_838)
            {
               var_100 = new ClubPromoView(this,param1.promoImageUrl,ClubPromoView.const_1222);
            }
            else
            {
               var_100 = new ClubPromoView(this,param1.promoImageUrl,ClubPromoView.const_402);
            }
            _loc2_ = _mainContainer.getChildByName(var_42.window.name);
            if(_loc2_ != null)
            {
               var_100.window.x = _loc2_.width + const_749;
               _mainContainer.addChild(var_100.window);
               _mainContainer.width = var_100.window.x + var_100.window.width;
            }
         }
      }
      
      private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent) : void
      {
         var _loc2_:* = null;
         var_536 = false;
         for each(_loc2_ in param1.effects)
         {
            if(_loc2_.isInUse)
            {
               var_536 = true;
            }
         }
         if(var_42 != null && var_42.window.name == const_592)
         {
            (var_42 as MeMenuEffectsView).updateEffects(param1.effects);
         }
      }
      
      public function get habboClubPastPeriods() : int
      {
         return var_1823;
      }
      
      public function get habboClubDays() : int
      {
         return var_1148;
      }
      
      public function get mainContainer() : IWindowContainer
      {
         if(_mainContainer == null)
         {
            _mainContainer = windowManager.createWindow("me_menu_main_container","",HabboWindowType.const_1318,HabboWindowStyle.const_920,HabboWindowParam.const_40,new Rectangle(0,0,170,260)) as IWindowContainer;
            _mainContainer.tags.push("room_widget_me_menu");
         }
         return _mainContainer;
      }
      
      private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent) : void
      {
         switch(param1.iconType)
         {
            case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU:
               var_260 = !var_260;
               break;
            case RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO:
               var_260 = false;
               break;
            default:
               return;
         }
         if(var_260)
         {
            show();
         }
         else
         {
            hide();
         }
      }
      
      private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Dance Event received, style: " + param1.style);
      }
      
      public function hide(param1:RoomWidgetRoomObjectUpdateEvent = null) : void
      {
         var _loc2_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.const_627);
         _loc2_.window = _mainContainer.parent as IWindowContainer;
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
         if(var_42 != null)
         {
            _mainContainer.removeChild(var_42.window);
            var_42.dispose();
            var_42 = null;
         }
         var_260 = false;
         _eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_CLOSE));
      }
      
      private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_42 != null && var_42.window.name == const_247)
         {
            if(var_100 != null)
            {
               var_100.dispose();
               var_100 = null;
            }
            changeView(const_124);
         }
      }
      
      public function get isNewsEnabled() : Boolean
      {
         return var_1824;
      }
      
      public function changeView(param1:String) : void
      {
         var _loc2_:* = null;
         if(var_100 != null)
         {
            var_100.dispose();
            var_100 = null;
         }
         switch(param1)
         {
            case const_124:
               _loc2_ = new MeMenuMainView();
               _eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DEFAULT));
               break;
            case const_592:
               _loc2_ = new MeMenuEffectsView();
               _eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_EFFECTS));
               break;
            case const_915:
               _loc2_ = new MeMenuDanceView();
               _eventDispatcher.dispatchEvent(new Event(HabboMeMenuTrackingEvent.HABBO_MEMENU_TRACKING_EVENT_DANCE));
               break;
            case const_247:
               _loc2_ = new MeMenuClothesView();
               break;
            case const_1368:
               _loc2_ = new MeMenuRoomsView();
               break;
            case const_534:
               _loc2_ = new MeMenuSettingsView();
               break;
            default:
               Logger.log("Me Menu Change view: unknown view: " + param1);
         }
         if(_loc2_ != null)
         {
            if(var_42 != null)
            {
               _mainContainer.removeChild(var_42.window);
               var_42.dispose();
               var_42 = null;
            }
            var_42 = _loc2_;
            var_42.init(this,param1);
         }
         updateSize();
      }
      
      public function updateSize() : void
      {
         if(var_42 != null)
         {
            var_962.x = var_42.window.width + 10;
            var_962.y = var_42.window.height;
            var_42.window.x = 5;
            var_42.window.y = 0;
            _mainContainer.width = var_962.x;
            _mainContainer.height = var_962.y;
            if(var_100 != null)
            {
               _mainContainer.width = var_100.window.x + var_100.window.width + const_749;
            }
         }
      }
      
      public function get config() : IHabboConfigurationManager
      {
         return _config;
      }
      
      private function show() : void
      {
         changeView(const_124);
         var _loc1_:RoomWidgetToolbarMessage = new RoomWidgetToolbarMessage(RoomWidgetToolbarMessage.const_723);
         _loc1_.window = _mainContainer.parent as IWindowContainer;
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
         var_260 = true;
      }
   }
}
