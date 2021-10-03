package com.sulake.habbo.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.events.AvatarEditorClosedEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
   import com.sulake.habbo.session.events.SessionCreditBalanceEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetCreditBalanceUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetEffectsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetSettingsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetNavigateToRoomMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRedeemClubPromoMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectEffectMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSetToolbarIconMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetStopEffectMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetStoreSettingsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetWaveMessage;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class MeMenuWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      private var var_96:IHabboCatalog;
      
      private var var_26:IHabboInventory;
      
      private var var_208:IHabboToolbar;
      
      public function MeMenuWidgetHandler()
      {
         super();
         Logger.log("[MeMenuWidgetHandler]");
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_437;
      }
      
      private function setMeMenuToolbarIcon(param1:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         if(false)
         {
            _loc4_ = _container.sessionDataManager.figure;
            _loc5_ = _container.avatarRenderManager.createAvatarImage(_loc4_,AvatarScaleType.const_50);
            if(_loc5_ != null)
            {
               _loc5_.setDirection(AvatarSetType.const_47,3);
               _loc2_ = _loc5_.getCroppedImage(AvatarSetType.const_47);
            }
         }
         var _loc3_:Component = _container.roomWidgetFactory as Component;
         if(_loc3_ != null)
         {
            if(_loc2_ == null)
            {
               _loc7_ = _loc3_.assets.getAssetByName("memenu_toolbar_icon") as BitmapDataAsset;
               _loc6_ = _loc7_.content as BitmapData;
            }
            else
            {
               _loc6_ = _loc2_;
            }
            Logger.log("MeMenuWidgetHandler: set toolbar icon: " + var_208 + " " + _loc6_);
            if(var_208 != null && _loc6_ != null)
            {
               _loc8_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_1002,HabboToolbarIconEnum.MEMENU);
               _loc8_.bitmapData = _loc6_;
               var_208.events.dispatchEvent(_loc8_);
            }
         }
      }
      
      private function onCreditBalance(param1:SessionCreditBalanceEvent) : void
      {
         if(param1 == null || _container == null || true)
         {
            return;
         }
         _container.events.dispatchEvent(new RoomWidgetCreditBalanceUpdateEvent(param1.credits));
      }
      
      private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.userId == _container.sessionDataManager.userId;
         if(_loc2_)
         {
            setMeMenuToolbarIcon(false);
         }
         if(_container != null && false)
         {
         }
      }
      
      public function update() : void
      {
         if(_container)
         {
            _container.events.dispatchEvent(new RoomWidgetFrameUpdateEvent());
         }
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(false)
            {
               _container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.const_705,onFigureUpdate);
            }
            if(false)
            {
               _container.avatarEditor.events.removeEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED,onAvatarEditorClosed);
            }
            if(false)
            {
               _container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.const_450,onHelpTutorialEvent);
               _container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.const_95,onHelpTutorialEvent);
            }
            _container = null;
         }
         _container = param1;
         if(_container != null && false)
         {
            _container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.const_705,onFigureUpdate);
            _container.sessionDataManager.events.addEventListener(SessionCreditBalanceEvent.const_165,onCreditBalance);
         }
         var_26 = _container.inventory;
         if(var_26 != null)
         {
            (var_26 as Component).events.addEventListener(HabboInventoryEffectsEvent.const_846,onAvatarEffectsChanged);
            (var_26 as Component).events.addEventListener(HabboInventoryHabboClubEvent.const_629,onHabboClubSubscriptionChanged);
         }
         var_208 = _container.toolbar;
         if(var_208)
         {
            var_208.events.addEventListener(HabboToolbarEvent.const_85,onHabboToolbarEvent);
            var_208.events.addEventListener(HabboToolbarEvent.const_60,onHabboToolbarEvent);
            setMeMenuToolbarIcon(false);
         }
         if(false)
         {
            _container.avatarEditor.events.addEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED,onAvatarEditorClosed);
         }
         if(false)
         {
            _container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.const_450,onHelpTutorialEvent);
            _container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.const_95,onHelpTutorialEvent);
         }
         var_96 = _container.catalog;
      }
      
      private function onHelpTutorialEvent(param1:HabboHelpTutorialEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         switch(param1.type)
         {
            case HabboHelpTutorialEvent.const_95:
               _container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.const_95));
               break;
            case HabboHelpTutorialEvent.const_450:
               _container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.const_389));
         }
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      private function onAvatarEffectsChanged(param1:Event = null) : void
      {
         var _loc2_:* = null;
         if(_container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
         if(var_26 != null)
         {
            _loc2_ = var_26.getAvatarEffects();
            _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
         }
      }
      
      private function onHabboClubSubscriptionChanged(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         if(var_26 != null)
         {
            _loc2_ = false;
            if(_container != null && false)
            {
               _loc2_ = _container.sessionDataManager.hasUserRight("fuse_use_club_dance");
            }
            _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(var_26.clubDays,var_26.clubPeriods,var_26.clubPastPeriods,_loc2_));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetWaveMessage.const_698);
         _loc1_.push(RoomWidgetDanceMessage.const_663);
         _loc1_.push(RoomWidgetGetEffectsMessage.const_686);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_637);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_669);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_527);
         _loc1_.push(RoomWidgetOpenInventoryMessage.const_701);
         _loc1_.push(RoomWidgetOpenCatalogMessage.const_573);
         _loc1_.push(RoomWidgetStopEffectMessage.const_551);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_1262);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_936);
         _loc1_.push(RoomWidgetToolbarMessage.const_723);
         _loc1_.push(RoomWidgetToolbarMessage.const_627);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_695);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_1292);
         _loc1_.push(RoomWidgetSelectOutfitMessage.const_786);
         _loc1_.push(RoomWidgetShowOwnRoomsMessage.const_621);
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_644);
         _loc1_.push(RoomWidgetRedeemClubPromoMessage.const_689);
         _loc1_.push(RoomWidgetGetSettingsMessage.const_537);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_1226);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_673);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_642);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_719);
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
         var_26 = null;
         var_208 = null;
         var_96 = null;
      }
      
      private function onAvatarEditorClosed(param1:Event = null) : void
      {
         if(_container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Editor Closed Event...");
         _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_634));
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:Boolean = false;
         var _loc24_:* = null;
         var _loc25_:* = false;
         var _loc26_:* = false;
         Logger.log("[MeMenuWidgetHandler] Processing in MeMenuWidgetHandler: " + param1.type);
         switch(param1.type)
         {
            case RoomWidgetRequestWidgetMessage.const_644:
               if(_container != null && false)
               {
                  _loc8_ = new HabboToolbarEvent(HabboToolbarEvent.const_60);
                  _loc8_.iconId = HabboToolbarIconEnum.MEMENU;
                  _container.toolbar.events.dispatchEvent(_loc8_);
               }
               break;
            case RoomWidgetWaveMessage.const_698:
               if(_container != null && false)
               {
                  _loc9_ = param1 as RoomWidgetWaveMessage;
                  _container.roomSession.sendWaveMessage();
               }
               break;
            case RoomWidgetDanceMessage.const_663:
               if(_container != null && false)
               {
                  _loc10_ = param1 as RoomWidgetDanceMessage;
                  _container.roomSession.sendDanceMessage(_loc10_.style);
               }
               break;
            case RoomWidgetGetEffectsMessage.const_686:
               if(var_26 != null)
               {
                  _loc11_ = var_26.getAvatarEffects();
                  _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc11_));
               }
               break;
            case RoomWidgetSelectEffectMessage.const_637:
               if(var_26 != null)
               {
                  _loc12_ = param1 as RoomWidgetSelectEffectMessage;
                  var_26.setEffectSelected(_loc12_.effectType);
               }
               break;
            case RoomWidgetSelectEffectMessage.const_669:
               if(var_26 != null)
               {
                  _loc13_ = param1 as RoomWidgetSelectEffectMessage;
                  var_26.setEffectDeselected(_loc13_.effectType);
               }
               break;
            case RoomWidgetOpenCatalogMessage.const_573:
               _loc2_ = param1 as RoomWidgetOpenCatalogMessage;
               if(var_96 != null && _loc2_.pageKey == RoomWidgetOpenCatalogMessage.const_606)
               {
                  var_96.openCatalogPage(CatalogPageName.const_318,true);
               }
               break;
            case RoomWidgetOpenInventoryMessage.const_701:
               _loc3_ = param1 as RoomWidgetOpenInventoryMessage;
               if(var_26 != null)
               {
                  Logger.log("MeMenuWidgetHandler open inventory: " + _loc3_.inventoryType);
                  switch(_loc3_.inventoryType)
                  {
                     case RoomWidgetOpenInventoryMessage.const_886:
                        var_96.openCatalogPage(CatalogPageName.const_1367,true);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_903:
                        var_26.toggleInventoryPage(InventoryCategory.const_258);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_1350:
                        var_26.toggleInventoryPage(InventoryCategory.const_72);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_1182:
                        break;
                     default:
                        Logger.log("MeMenuWidgetHandler: unknown inventory type: " + _loc3_.inventoryType);
                  }
               }
               break;
            case RoomWidgetSelectEffectMessage.const_527:
            case RoomWidgetStopEffectMessage.const_551:
               Logger.log("STOP ALL EFFECTS");
               if(var_26 != null)
               {
                  var_26.deselectAllEffects();
               }
               break;
            case RoomWidgetSetToolbarIconMessage.const_800:
               _loc4_ = param1 as RoomWidgetSetToolbarIconMessage;
               switch(_loc4_.widgetType)
               {
                  case RoomWidgetSetToolbarIconMessage.const_1345:
                     break;
                  default:
                     Logger.log("MeMenuWidgetHandler: unknown icon widget type: " + _loc4_.widgetType);
               }
               break;
            case RoomWidgetNavigateToRoomMessage.const_936:
               Logger.log("MeMenuWidgetHandler: GO HOME");
               if(_container != null)
               {
                  _container.navigator.goToHomeRoom();
               }
               break;
            case RoomWidgetShowOwnRoomsMessage.const_621:
               if(_container != null)
               {
                  _container.navigator.showOwnRooms();
               }
               break;
            case RoomWidgetToolbarMessage.const_723:
               _loc5_ = param1 as RoomWidgetToolbarMessage;
               if(var_208)
               {
                  var_208.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_46,HabboToolbarIconEnum.MEMENU,_loc5_.window));
                  if(var_26 != null)
                  {
                     _loc14_ = false;
                     if(_container != null && false)
                     {
                        _loc14_ = _container.sessionDataManager.hasUserRight("fuse_use_club_dance");
                     }
                     _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(var_26.clubDays,var_26.clubPeriods,var_26.clubPastPeriods,_loc14_));
                  }
                  if(var_96 != null && var_96.getPurse() != null)
                  {
                     _container.events.dispatchEvent(new RoomWidgetCreditBalanceUpdateEvent(var_96.getPurse().credits));
                  }
               }
               if(false)
               {
                  _loc15_ = _container.sessionDataManager != null ? int(_container.sessionDataManager.userId) : -1;
                  _loc16_ = _container.roomSession.userDataManager.getUserData(_loc15_);
                  _loc17_ = 0;
                  _loc18_ = 0;
                  _container.roomEngine.selectAvatar(_loc17_,_loc18_,_loc16_.id,true);
               }
               break;
            case RoomWidgetToolbarMessage.const_627:
               _loc6_ = param1 as RoomWidgetToolbarMessage;
               if(var_208)
               {
                  var_208.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_416,HabboToolbarIconEnum.MEMENU,_loc6_.window));
               }
               break;
            case RoomWidgetAvatarEditorMessage.const_695:
               Logger.log("MeMenuWidgetHandler: Open avatar editor...");
               if(_container)
               {
                  _loc19_ = param1 as RoomWidgetAvatarEditorMessage;
                  _loc20_ = _loc19_.context;
                  _container.avatarEditor.method_11(_loc20_);
                  _loc21_ = _container.sessionDataManager.figure;
                  _loc22_ = _container.sessionDataManager.gender;
                  _loc23_ = false;
                  _container.avatarEditor.loadAvatarInEditor(_loc21_,_loc22_,_loc23_);
                  if(false && !_loc23_)
                  {
                     _loc24_ = _container.config.getKey("avatar.editor.club.promo.image");
                     _loc25_ = int(_container.config.getKey("avatar.editor.club.promo")) > 0;
                     if(_loc25_ && false)
                     {
                        _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_421,_loc24_,RoomWidgetAvatarEditorUpdateEvent.const_838));
                     }
                     _loc26_ = int(_container.config.getKey("avatar.editor.trial.promo")) > 0;
                     if(_loc26_ && true)
                     {
                        _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_421,_loc24_,RoomWidgetAvatarEditorUpdateEvent.const_1335));
                     }
                  }
                  if(false && _container.habboHelp.events)
                  {
                     _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.const_518));
                  }
               }
               break;
            case RoomWidgetRedeemClubPromoMessage.const_689:
               _loc7_ = param1 as RoomWidgetRedeemClubPromoMessage;
               if(_loc7_ != null)
               {
                  _container.catalog.redeemClubPromo(_loc7_.code,_loc7_.isTrial);
               }
               break;
            case RoomWidgetGetSettingsMessage.const_537:
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_300,_container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_673:
               _container.soundManager.volume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_300,_container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_642:
               _container.soundManager.previewVolume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_300,_container.soundManager.volume));
               break;
            case RoomWidgetAvatarEditorMessage.const_719:
               if(false && _container.habboHelp.events)
               {
                  _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.const_706));
               }
               break;
            default:
               Logger.log("Unhandled message in MeMenuWidgetHandler: " + param1.type);
         }
         return null;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_85)
         {
            setMeMenuToolbarIcon(false);
         }
         if(_container == null)
         {
            return;
         }
         if(param1.type == HabboToolbarEvent.const_60)
         {
            switch(param1.iconId)
            {
               case HabboToolbarIconEnum.MEMENU:
                  _container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
                  break;
               case HabboToolbarIconEnum.ROOMINFO:
                  _container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO));
            }
         }
      }
   }
}
