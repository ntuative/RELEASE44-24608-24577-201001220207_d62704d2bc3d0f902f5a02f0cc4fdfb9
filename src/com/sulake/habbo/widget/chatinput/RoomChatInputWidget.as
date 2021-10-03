package com.sulake.habbo.widget.chatinput
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.exceptions.CrashMeError;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetChatInputDisplayEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetChatInputWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomChatInputWidget extends RoomWidgetBase implements ICoreUpdateReceiver
   {
      
      private static const const_1119:int = 2;
      
      private static const const_1413:int = 150;
      
      private static const const_1120:int = 3000;
      
      private static const const_1121:int = 30000;
       
      
      private var _disposed:Boolean = false;
      
      private var var_1311:int;
      
      private var var_1310:Boolean = false;
      
      private var var_1309:String = "";
      
      private var var_421:int = -1;
      
      private var var_881:Timer = null;
      
      private var _visualization:RoomChatInputView;
      
      private var var_1980:Boolean = false;
      
      private var var_882:Boolean = false;
      
      private var var_716:int = 0;
      
      private var var_44:Component = null;
      
      public function RoomChatInputWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:Component)
      {
         var_1311 = getTimer();
         super(param1,param2,param3);
         var_44 = param4;
         var_44.registerUpdateReceiver(this,9);
      }
      
      public function sendChat(param1:String, param2:int, param3:String = "") : void
      {
         if(var_882)
         {
            return;
         }
         checkForFlooding();
         var _loc4_:RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.const_531,param1,param2,param3);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc4_);
         }
      }
      
      private function onReleaseTimerTick(param1:TimerEvent) : void
      {
         if(_visualization != null)
         {
            var_716 = var_716 - 1;
            _visualization.showFloodBlocking(var_716);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_315,onRoomObjectSelected);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_222,onRoomObjectDeselected);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_267,onRoomViewUpdate);
         param1.addEventListener(RoomWidgetChatInputContentUpdateEvent.const_521,onChatInputUpdate);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_212,onUserInfo);
         param1.addEventListener(RoomWidgetChatInputDisplayEvent.const_586,onSettings);
         super.registerUpdateEvents(param1);
      }
      
      public function update(param1:uint) : void
      {
         if(var_1310)
         {
            var_1310 = false;
            throw new CrashMeError();
         }
      }
      
      public function get allowPaste() : Boolean
      {
         return var_1980;
      }
      
      public function get floodBlocked() : Boolean
      {
         return var_882;
      }
      
      private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent) : void
      {
         if(_visualization == null)
         {
            _visualization = new RoomChatInputView(this,windowManager,assets,localizations);
         }
         refreshWindowPosition();
      }
      
      private function onReleaseTimerComplete(param1:TimerEvent) : void
      {
         Logger.log("Releasing flood blocking");
         var_882 = false;
         var_421 = -1;
         if(_visualization != null)
         {
            _visualization.hideFloodBlocking();
         }
         var_881 = null;
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var_1309 = param1.name;
      }
      
      private function onSettings(param1:RoomWidgetChatInputDisplayEvent) : void
      {
         var_1980 = param1.allowPaste;
      }
      
      private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.messageType)
         {
            case RoomWidgetChatInputContentUpdateEvent.const_852:
               _loc2_ = localizations.getKey("widgets.chatinput.mode.whisper",":tell");
               _visualization.displaySpecialChatMessage(_loc2_,param1.userName);
               break;
            case RoomWidgetChatInputContentUpdateEvent.const_1210:
         }
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_315,onRoomObjectSelected);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_222,onRoomObjectDeselected);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_267,onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.const_521,onChatInputUpdate);
         param1.removeEventListener(RoomWidgetChatInputDisplayEvent.const_586,onSettings);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_212,onUserInfo);
      }
      
      private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var_1309 = "";
      }
      
      override public function dispose() : void
      {
         if(_visualization != null)
         {
            _visualization.dispose();
            _visualization = null;
         }
         var_44.removeUpdateReceiver(this);
         _disposed = true;
         super.dispose();
      }
      
      private function checkForFlooding() : Boolean
      {
         if(var_882)
         {
            return true;
         }
         var _loc1_:int = getTimer();
         if(var_421 == -1)
         {
            var_421 = 0;
            var_1311 = _loc1_;
         }
         else
         {
            ++var_421;
         }
         if(var_421 > const_1119)
         {
            if(_loc1_ < var_1311 + const_1120)
            {
               var_882 = true;
               var_716 = const_1121 / 1000;
               Logger.log("Enabling flood blocking");
               var_881 = new Timer(1000,var_716);
               var_881.addEventListener(TimerEvent.TIMER,onReleaseTimerTick);
               var_881.addEventListener(TimerEvent.TIMER_COMPLETE,onReleaseTimerComplete);
               var_881.start();
               if(_visualization != null)
               {
                  _visualization.showFloodBlocking(var_716);
               }
               return true;
            }
            var_421 = -1;
         }
         return false;
      }
      
      public function triggerManualCrash() : void
      {
         var_1310 = true;
      }
      
      private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_297,param1.id,param1.category);
      }
      
      public function get selectedUserName() : String
      {
         return var_1309;
      }
      
      private function refreshWindowPosition() : void
      {
         if(_visualization == null)
         {
            return;
         }
         var _loc1_:RoomWidgetChatInputWidgetMessage = new RoomWidgetChatInputWidgetMessage(RoomWidgetChatInputWidgetMessage.const_665,_visualization.window);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
