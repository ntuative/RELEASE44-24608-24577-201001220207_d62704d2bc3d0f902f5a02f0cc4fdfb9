package com.sulake.habbo.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.help.cfh.data.CallForHelpData;
   import com.sulake.habbo.help.cfh.data.UserRegistry;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.HelpUI;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.help.tutorial.TutorialUI;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class HabboHelp extends Component implements IHabboHelp
   {
       
      
      private var var_2064:UserRegistry;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_143:TutorialUI;
      
      private var var_1494:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_68:HelpUI;
      
      private var var_1495:IHabboConfigurationManager;
      
      private var var_208:IHabboToolbar;
      
      private var var_552:IHabboCommunicationManager;
      
      private var var_845:FaqIndex;
      
      private var var_1854:String = "";
      
      private var var_1405:IncomingMessages;
      
      private var var_1249:CallForHelpData;
      
      public function HabboHelp(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_1249 = new CallForHelpData();
         var_2064 = new UserRegistry();
         super(param1,param2,param3);
         _assetLibrary = param3;
         var_845 = new FaqIndex();
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return var_208;
      }
      
      public function tellUI(param1:String, param2:* = null) : void
      {
         if(var_68 != null)
         {
            var_68.tellUI(param1,param2);
         }
      }
      
      private function toggleHelpUI() : void
      {
         if(var_68 == null)
         {
            if(!createHelpUI())
            {
               return;
            }
         }
         var_68.toggleUI();
      }
      
      private function removeTutorialUI() : void
      {
         if(var_143 != null)
         {
            var_143.dispose();
            var_143 = null;
         }
      }
      
      public function get ownUserName() : String
      {
         return var_1854;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function reportUser(param1:int, param2:String) : void
      {
         var_1249.reportedUserId = param1;
         var_1249.reportedUserName = param2;
         var_68.showUI(HabboHelpViewEnum.const_296);
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_1494;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case RoomSessionEvent.const_88:
               if(var_68 != null)
               {
                  var_68.setRoomSessionStatus(true);
               }
               if(var_143 != null)
               {
                  var_143.setRoomSessionStatus(true);
               }
               break;
            case RoomSessionEvent.const_96:
               if(var_68 != null)
               {
                  var_68.setRoomSessionStatus(false);
               }
               if(var_143 != null)
               {
                  var_143.setRoomSessionStatus(false);
               }
               userRegistry.unregisterRoom();
         }
      }
      
      public function enableCallForGuideBotUI() : void
      {
         if(var_68 != null)
         {
            var_68.updateCallForGuideBotUI(true);
         }
      }
      
      public function get userRegistry() : UserRegistry
      {
         return var_2064;
      }
      
      public function showCallForHelpResult(param1:String) : void
      {
         if(var_68 != null)
         {
            var_68.showCallForHelpResult(param1);
         }
      }
      
      override public function dispose() : void
      {
         if(var_68 != null)
         {
            var_68.dispose();
            var_68 = null;
         }
         if(var_143 != null)
         {
            var_143.dispose();
            var_143 = null;
         }
         var_1405 = null;
         if(var_845 != null)
         {
            var_845.dispose();
            var_845 = null;
         }
         if(_windowManager)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         super.dispose();
      }
      
      private function setHabboToolbarIcon() : void
      {
         if(var_208 != null)
         {
            var_208.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_110,HabboToolbarIconEnum.HELP));
         }
      }
      
      private function createTutorialUI() : Boolean
      {
         if(var_143 == null && _assetLibrary != null && _windowManager != null)
         {
            var_143 = new TutorialUI(this);
         }
         return var_143 != null;
      }
      
      private function createHelpUI() : Boolean
      {
         if(var_68 == null && _assetLibrary != null && _windowManager != null)
         {
            var_68 = new HelpUI(this,_assetLibrary,_windowManager,var_1494,var_208);
         }
         return var_68 != null;
      }
      
      public function set ownUserName(param1:String) : void
      {
         var_1854 = param1;
      }
      
      public function get callForHelpData() : CallForHelpData
      {
         return var_1249;
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManager(param2);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationManagerReady);
      }
      
      private function onLocalizationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_1494 = IHabboLocalizationManager(param2);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationManagerReady);
      }
      
      public function updateTutorial(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1 && param2 && param3)
         {
            removeTutorialUI();
            return;
         }
         if(var_143 == null)
         {
            if(!createTutorialUI())
            {
               return;
            }
         }
         var_143.update(param1,param2,param3);
      }
      
      private function onCommunicationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_552 = IHabboCommunicationManager(param2);
         var_1405 = new IncomingMessages(this,var_552);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
      }
      
      public function showUI(param1:String = null) : void
      {
         if(var_68 != null)
         {
            var_68.showUI(param1);
         }
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         if(var_552 != null && param1 != null)
         {
            var_552.getHabboMainConnection(null).send(param1);
         }
      }
      
      public function getFaq() : FaqIndex
      {
         return var_845;
      }
      
      public function disableCallForGuideBotUI() : void
      {
         if(var_68 != null)
         {
            var_68.updateCallForGuideBotUI(false);
         }
      }
      
      public function hideUI() : void
      {
         if(var_68 != null)
         {
            var_68.hideUI();
         }
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_208 = IHabboToolbar(param2);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationManagerReady);
      }
      
      private function onConfigurationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_1495 = IHabboConfigurationManager(param2);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
      }
      
      public function get tutorialUI() : TutorialUI
      {
         return var_143;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_85)
         {
            setHabboToolbarIcon();
            return;
         }
         if(param1.type == HabboToolbarEvent.const_60)
         {
            if(param1.iconId == HabboToolbarIconEnum.HELP)
            {
               toggleHelpUI();
               return;
            }
         }
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:IRoomSessionManager = IRoomSessionManager(param2);
         _loc3_.events.addEventListener(RoomSessionEvent.const_88,onRoomSessionEvent);
         _loc3_.events.addEventListener(RoomSessionEvent.const_96,onRoomSessionEvent);
         var_208.events.addEventListener(HabboToolbarEvent.const_85,onHabboToolbarEvent);
         var_208.events.addEventListener(HabboToolbarEvent.const_60,onHabboToolbarEvent);
         createHelpUI();
         setHabboToolbarIcon();
      }
      
      public function showCallForHelpReply(param1:String) : void
      {
         if(var_68 != null)
         {
            var_68.showCallForHelpReply(param1);
         }
      }
      
      public function getConfigurationKey(param1:String, param2:String = null, param3:Dictionary = null) : String
      {
         if(var_1495 == null)
         {
            return param1;
         }
         return var_1495.getKey(param1,param2,param3);
      }
   }
}
