package
{
   import com.sulake.core.Core;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.ICore;
   import com.sulake.core.runtime.ICoreConfigStatusListener;
   import com.sulake.habbo.tracking.HabboLoginTrackingStep;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   
   public class HabboMain extends Sprite implements IHabboMain
   {
       
      
      private var var_1555:ICoreConfigStatusListener;
      
      private var var_52:ICore;
      
      public function HabboMain(param1:ICoreConfigStatusListener)
      {
         super();
         var_1555 = param1;
         addEventListener(Event.ADDED_TO_STAGE,onStageInit);
         Logger.log("Core version: undefined");
      }
      
      protected function onStageInit(param1:Event = null) : void
      {
         initCore("config_habbo.xml",0);
      }
      
      private function initCore(param1:String, param2:uint) : void
      {
         trackLoginStep(HabboLoginTrackingStep.const_11);
         var_52 = Core.instantiate(this,param2);
         initBakedInComponents();
         var_52.events.addEventListener(Component.COMPONENT_EVENT_ERROR,onCoreError);
         var_52.loadExternalConfigDocument(new URLRequest(param1),var_1555);
      }
      
      private function trackLoginStep(param1:String) : void
      {
         if(loaderInfo == null)
         {
            return;
         }
         if(loaderInfo.parameters["processlog.enabled"] != "1")
         {
            return;
         }
         Logger.log("* HabboMain Login Step: " + param1);
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
         }
         else
         {
            Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      public function onCoreError(param1:Event) : void
      {
         trackLoginStep(HabboLoginTrackingStep.const_10);
      }
      
      private function initBakedInComponents() : void
      {
         var_52.prepareComponent(CoreCommunicationFrameworkLib);
         var_52.prepareComponent(HabboRoomObjectLogicLib);
         var_52.prepareComponent(HabboRoomObjectVisualizationLib);
         var_52.prepareComponent(RoomManagerLib);
         var_52.prepareComponent(RoomSpriteRendererLib);
         var_52.prepareComponent(HabboRoomSessionManagerLib);
         var_52.prepareComponent(HabboAvatarRenderLib);
         var_52.prepareComponent(HabboRoomWidgetLib);
         var_52.prepareComponent(HabboSessionDataManagerLib);
         var_52.prepareComponent(HabboTrackingLib);
         var_52.prepareComponent(HabboConfigurationCom);
         var_52.prepareComponent(HabboLocalizationCom);
         var_52.prepareComponent(HabboWindowManagerCom);
         var_52.prepareComponent(HabboCommunicationCom);
         var_52.prepareComponent(HabboCommunicationDemoCom);
         var_52.prepareComponent(HabboNavigatorCom);
         var_52.prepareComponent(HabboFriendListCom);
         var_52.prepareComponent(HabboMessengerCom);
         var_52.prepareComponent(HabboInventoryCom);
         var_52.prepareComponent(HabboToolbarCom);
         var_52.prepareComponent(HabboCatalogCom);
         var_52.prepareComponent(HabboRoomEngineCom);
         var_52.prepareComponent(HabboRoomUICom);
         var_52.prepareComponent(HabboAvatarEditorCom);
         var_52.prepareComponent(HabboNotificationsCom);
         var_52.prepareComponent(HabboHelpCom);
         var_52.prepareComponent(HabboAdManagerCom);
         var_52.prepareComponent(HabboModerationCom);
         Logger.log("Sound manager embed...");
         Logger.log("Trying to embed Flash 9 version");
         var_52.prepareComponent(HabboSoundManagerCom);
      }
      
      public function initializeCore() : void
      {
         try
         {
            var_52.initialize();
         }
         catch(error:Error)
         {
            Core.crash("Failed to initialize the core: " + error.message,CoreComponent.const_1334,error);
         }
      }
   }
}
