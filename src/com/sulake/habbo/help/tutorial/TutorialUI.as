package com.sulake.habbo.help.tutorial
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class TutorialUI
   {
      
      public static const const_252:String = "TUI_NAME_VIEW";
      
      public static const const_79:String = "TUI_MAIN_VIEW";
      
      public static const const_302:String = "TUI_CLOTHES_VIEW";
      
      public static const const_439:String = "TUI_GUIDEBOT_VIEW";
       
      
      private var var_935:Boolean = false;
      
      private var var_933:Boolean = false;
      
      private var _window:IWindowContainer;
      
      private var var_1503:int = 0;
      
      private var var_60:HabboHelp;
      
      private var var_934:Boolean = false;
      
      private var var_1127:Boolean = false;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1504:int = 0;
      
      private var var_42:ITutorialUIView;
      
      public function TutorialUI(param1:HabboHelp)
      {
         super();
         var_60 = param1;
         var_60.events.addEventListener(HabboHelpTutorialEvent.const_591,onTaskDoneEvent);
         var_60.events.addEventListener(HabboHelpTutorialEvent.const_518,onTaskDoneEvent);
         var_60.events.addEventListener(HabboHelpTutorialEvent.const_706,onTaskDoneEvent);
      }
      
      public function prepareForTutorial() : void
      {
         if(var_60 == null || true)
         {
            return;
         }
         var_60.hideUI();
         var_60.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.const_95));
      }
      
      public function get help() : HabboHelp
      {
         return var_60;
      }
      
      public function get hasCalledGuideBot() : Boolean
      {
         return var_935;
      }
      
      public function update(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var_934 = param1;
         var_933 = param2;
         var_935 = param3;
         if(var_42 == null || var_42.id == const_79)
         {
            prepareForTutorial();
            showView(const_79);
         }
      }
      
      public function get assets() : IAssetLibrary
      {
         return var_60.assets;
      }
      
      public function setRoomSessionStatus(param1:Boolean) : void
      {
         if(param1 == false)
         {
            disposeWindow();
         }
      }
      
      public function onUserNameChanged(param1:String) : void
      {
         var name:String = param1;
         var_933 = true;
         if(var_42 != null && (var_42.id == const_252 || var_42.id == const_79))
         {
            showView(const_79);
         }
         var_60.localization.registerParameter("help.tutorial.name.changed","name",name);
         var_60.windowManager.alert("${generic.notice}","${help.tutorial.name.changed}",0,function(param1:IAlertDialog, param2:Event):void
         {
            param1.dispose();
         });
      }
      
      public function showView(param1:String) : void
      {
         var _loc2_:* = null;
         if(hasTasksDone)
         {
            dispose();
            return;
         }
         var _loc3_:Boolean = false;
         if(_window == null)
         {
            _window = buildXmlWindow("tutorial_frame") as IWindowContainer;
            if(_window == null)
            {
               return;
            }
            _window.procedure = windowProcedure;
            _loc2_ = _window.findChildByName("content_list") as IItemListWindow;
            if(_loc2_ == null)
            {
               return;
            }
            var_1504 = 0 - _loc2_.width;
            var_1503 = _window.height;
            _loc3_ = true;
         }
         _loc2_ = _window.findChildByName("content_list") as IItemListWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.destroyListItems();
         _loc2_.height = 0;
         if(var_42 != null)
         {
            var_42.dispose();
         }
         switch(param1)
         {
            case const_79:
               var_42 = new TutorialMainView(_loc2_,this);
               break;
            case const_252:
               var_42 = new TutorialNameChangeView(_loc2_,this);
               break;
            case const_302:
               var_42 = new TutorialClothesChangeView(_loc2_,this);
               break;
            case const_439:
               var_42 = new TutorialCallGuideBotView(_loc2_,this);
         }
         _window.height = _loc2_.height + var_1503;
         _window.width = _loc2_.width + var_1504;
         if(_loc3_)
         {
            if(_window == null)
            {
               return;
            }
            _window.x = _window.context.getDesktopWindow().width / 2 - 0;
            _window.y = 0;
         }
      }
      
      public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               if(param2.name == "header_button_close")
               {
                  disposeWindow();
               }
         }
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_60.localization;
      }
      
      public function get hasChangedLooks() : Boolean
      {
         return var_934;
      }
      
      public function dispose() : void
      {
         disposeWindow();
         var_60 = null;
      }
      
      public function buildXmlWindow(param1:String, param2:uint = 1) : IWindow
      {
         if(var_60 == null || true)
         {
            return null;
         }
         var _loc3_:XmlAsset = XmlAsset(var_60.assets.getAssetByName(param1 + "_xml"));
         if(_loc3_ == null || true)
         {
            return null;
         }
         var _loc4_:ICoreWindowManager = ICoreWindowManager(var_60.windowManager);
         return _loc4_.buildFromXML(XML(_loc3_.content),param2);
      }
      
      public function changeName(param1:String) : void
      {
         disposeWindow();
         var_60.sendMessage(new ChangeUserNameMessageComposer(param1));
      }
      
      public function onTaskDoneEvent(param1:HabboHelpTutorialEvent) : void
      {
         switch(param1.type)
         {
            case HabboHelpTutorialEvent.const_591:
               var_935 = true;
               if(var_42 != null && var_42.id == const_439)
               {
                  showView(const_79);
               }
               break;
            case HabboHelpTutorialEvent.const_518:
               if(var_42 != null && var_42.id == const_302)
               {
                  var_1127 = true;
                  disposeWindow();
               }
               break;
            case HabboHelpTutorialEvent.const_706:
               if(var_1127)
               {
                  var_1127 = false;
                  showView(const_79);
               }
         }
      }
      
      public function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
         if(_loc2_.resultCode != ChangeUserNameResultMessageEvent.var_885)
         {
            showView(const_252);
            (var_42 as TutorialNameChangeView).setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      public function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:CheckUserNameResultMessageParser = param1.getParser();
         showView(const_252);
         var _loc3_:TutorialNameChangeView = var_42 as TutorialNameChangeView;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_885)
         {
            _loc3_.checkedName = _loc2_.name;
         }
         else
         {
            _loc3_.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      public function get hasChangedName() : Boolean
      {
         return var_933;
      }
      
      private function disposeWindow(param1:WindowEvent = null) : void
      {
         if(var_42 != null)
         {
            var_42.dispose();
            var_42 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function onUserChanged() : void
      {
         var_934 = true;
         if(var_42 != null && (var_42.id == const_302 || var_42.id == const_79))
         {
            showView(const_79);
         }
      }
      
      public function checkName(param1:String) : void
      {
         disposeWindow();
         var_60.sendMessage(new CheckUserNameMessageComposer(param1));
      }
      
      public function get hasTasksDone() : Boolean
      {
         return var_934 && var_933 && var_935;
      }
   }
}
