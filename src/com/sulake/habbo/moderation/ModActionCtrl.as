package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
   import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
   import com.sulake.habbo.communication.messages.incoming.moderation.OffenceData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class ModActionCtrl implements IDisposable, TrackedWindow
   {
      
      private static var var_133:Array;
       
      
      private var _disposed:Boolean;
      
      private var var_769:IButtonWindow;
      
      private var var_1122:int;
      
      private var var_60:ModerationManager;
      
      private var var_624:OffenceCategoryData;
      
      private var var_375:ITextFieldWindow;
      
      private var var_768:IButtonWindow;
      
      private var var_1121:String;
      
      private var var_311:Boolean = true;
      
      private var var_1353:String;
      
      private var var_767:IDropMenuWindow;
      
      private var var_63:IFrameWindow;
      
      private var var_625:OffenceData;
      
      public function ModActionCtrl(param1:ModerationManager, param2:int, param3:String, param4:String)
      {
         super();
         var_60 = param1;
         var_1122 = param2;
         var_1353 = param3;
         var_1121 = param4;
         if(var_133 == null)
         {
            var_133 = new Array();
            var_133.push(new BanDefinition("2 hours",2));
            var_133.push(new BanDefinition("4 hours",4));
            var_133.push(new BanDefinition("12 hours",12));
            var_133.push(new BanDefinition("24 hours",24));
            var_133.push(new BanDefinition("2 days",48));
            var_133.push(new BanDefinition("3 days",72));
            var_133.push(new BanDefinition("1 week",168));
            var_133.push(new BanDefinition("2 weeks",336));
            var_133.push(new BanDefinition("3 weeks",504));
            var_133.push(new BanDefinition("1 month",720));
            var_133.push(new BanDefinition("2 months",1440));
            var_133.push(new BanDefinition("1 year",8760));
            var_133.push(new BanDefinition("2 years",17520));
            var_133.push(new BanDefinition("Permanent",100000));
         }
         var_769 = IButtonWindow(var_60.getXmlWindow("modact_offence"));
         var_768 = IButtonWindow(var_60.getXmlWindow("modact_offencectg"));
      }
      
      public static function hideChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      private function onBanButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Ban...");
         if(!isMsgGiven())
         {
            return;
         }
         if(this.var_767.selection < 0)
         {
            var_60.windowManager.alert("Alert","You must select ban lenght",0,onAlertClose);
            return;
         }
         var_60.connection.send(new ModBanMessageComposer(var_1122,var_375.text,getBanLength(),var_1121));
         this.dispose();
      }
      
      public function getId() : String
      {
         return var_1353;
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_269)
         {
            return;
         }
         if(!var_311)
         {
            return;
         }
         var_375.text = "";
         var_311 = false;
      }
      
      private function getBanLength() : int
      {
         var _loc1_:int = this.var_767.selection;
         var _loc2_:BanDefinition = var_133[_loc1_];
         return _loc2_.banLengthHours;
      }
      
      private function prepareBanSelect(param1:IDropMenuWindow) : void
      {
         var _loc3_:* = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in var_133)
         {
            _loc2_.push(_loc3_.name);
         }
         param1.populate(_loc2_);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function refreshButtons(param1:String, param2:int, param3:Array, param4:IWindow, param5:Function) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc6_:IWindowContainer = IWindowContainer(var_63.findChildByName(param1));
         hideChildren(_loc6_);
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         for each(_loc11_ in param3)
         {
            _loc12_ = "" + _loc7_;
            _loc13_ = IButtonWindow(_loc6_.findChildByName(_loc12_));
            if(_loc13_ == null)
            {
               _loc13_ = IButtonWindow(param4.clone());
               _loc13_.procedure = param5;
               _loc13_.x = _loc9_ * (param4.width + 5);
               _loc13_.y = _loc8_ * (param4.height + 5);
               _loc13_.name = _loc12_;
               _loc6_.addChild(_loc13_);
            }
            _loc13_.caption = _loc11_.name;
            _loc13_.visible = true;
            _loc7_++;
            _loc9_++;
            if(_loc9_ >= param2)
            {
               _loc9_ = 0;
               _loc8_++;
            }
         }
         _loc6_.height = RoomToolCtrl.getLowestPoint(_loc6_);
         _loc6_.visible = true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_63 != null)
         {
            var_63.destroy();
            var_63 = null;
         }
         if(var_769 != null)
         {
            var_769.destroy();
            var_769 = null;
         }
         if(var_768 != null)
         {
            var_768.destroy();
            var_768 = null;
         }
         var_767 = null;
         var_375 = null;
         var_60 = null;
      }
      
      private function onSendCautionButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Sending caution...");
         if(!isMsgGiven())
         {
            return;
         }
         var_60.connection.send(new ModAlertMessageComposer(var_1122,var_375.text,var_1121));
         this.dispose();
      }
      
      private function onAlertClose(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1282;
      }
      
      private function onChangeCategorizationButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         if(var_625 != null)
         {
            var_625 = null;
         }
         else
         {
            var_624 = null;
         }
         this.refreshCategorization();
      }
      
      private function onOffenceCtgButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = int(param2.name);
         var_624 = var_60.initMsg.offenceCategories[_loc3_];
         this.refreshCategorization();
      }
      
      public function getFrame() : IFrameWindow
      {
         return var_63;
      }
      
      private function isMsgGiven() : Boolean
      {
         if(var_311 || false)
         {
            var_60.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return false;
         }
         return true;
      }
      
      private function onKickButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Kick...");
         if(!isMsgGiven())
         {
            return;
         }
         var_60.connection.send(new ModKickMessageComposer(var_1122,var_375.text,var_1121));
         this.dispose();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      public function refreshCategorization() : void
      {
         var _loc1_:IWindowContainer = IWindowContainer(var_63.findChildByName("categorization_cont"));
         hideChildren(_loc1_);
         _loc1_.findChildByName("categorization_caption_txt").visible = true;
         _loc1_.findChildByName("change_categorization_but").visible = var_624 != null;
         if(this.var_625 != null)
         {
            var_63.findChildByName("offence_txt").caption = this.var_625.name;
            var_63.findChildByName("offence_category").visible = true;
         }
         else if(this.var_624 != null)
         {
            this.refreshButtons("offences_cont",2,var_624.offences,var_769,onOffenceButton);
         }
         else
         {
            this.refreshButtons("offence_categories_cont",3,var_60.initMsg.offenceCategories,var_768,onOffenceCtgButton);
            _loc1_.height = RoomToolCtrl.getLowestPoint(_loc1_);
         }
      }
      
      private function onOffenceButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = int(param2.name);
         var_625 = var_624.offences[_loc3_];
         var_375.text = var_625.msg;
         var_311 = false;
         this.refreshCategorization();
      }
      
      public function show() : void
      {
         var_63 = IFrameWindow(var_60.getXmlWindow("modact_summary"));
         var_63.caption = "Mod action on: " + var_1353;
         var_63.findChildByName("send_caution_but").procedure = onSendCautionButton;
         var_63.findChildByName("kick_but").procedure = onKickButton;
         var_63.findChildByName("ban_but").procedure = onBanButton;
         var_63.findChildByName("change_categorization_but").procedure = onChangeCategorizationButton;
         var_60.disableButton(var_60.initMsg.alertPermission,var_63,"send_caution_but");
         var_60.disableButton(var_60.initMsg.kickPermission,var_63,"kick_but");
         var_60.disableButton(var_60.initMsg.banPermission,var_63,"ban_but");
         var_375 = ITextFieldWindow(var_63.findChildByName("message_input"));
         var_375.procedure = onInputClick;
         var_767 = IDropMenuWindow(var_63.findChildByName("banLengthSelect"));
         prepareBanSelect(var_767);
         var _loc1_:IWindow = var_63.findChildByTag("close");
         _loc1_.procedure = onClose;
         refreshCategorization();
         var_63.visible = true;
      }
   }
}
