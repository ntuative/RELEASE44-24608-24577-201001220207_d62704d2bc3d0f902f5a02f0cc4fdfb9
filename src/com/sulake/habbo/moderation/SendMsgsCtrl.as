package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class SendMsgsCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var var_1121:String;
      
      private var _disposed:Boolean;
      
      private var var_1353:String;
      
      private var var_1122:int;
      
      private var var_60:ModerationManager;
      
      private var var_748:IDropMenuWindow;
      
      private var var_375:ITextFieldWindow;
      
      private var var_63:IFrameWindow;
      
      private var var_311:Boolean = true;
      
      public function SendMsgsCtrl(param1:ModerationManager, param2:int, param3:String, param4:String)
      {
         super();
         var_60 = param1;
         var_1122 = param2;
         var_1353 = param3;
         var_1121 = param4;
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
      
      public function getFrame() : IFrameWindow
      {
         return var_63;
      }
      
      public function getId() : String
      {
         return var_1353;
      }
      
      private function onSendMessageButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Sending message...");
         if(var_311 || false)
         {
            var_60.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         var_60.connection.send(new ModMessageMessageComposer(var_1122,var_375.text,var_1121));
         this.dispose();
      }
      
      public function show() : void
      {
         var_63 = IFrameWindow(var_60.getXmlWindow("send_msgs"));
         var_63.caption = "Msg To: " + var_1353;
         var_63.findChildByName("send_message_but").procedure = onSendMessageButton;
         var_375 = ITextFieldWindow(var_63.findChildByName("message_input"));
         var_375.procedure = onInputClick;
         var_748 = IDropMenuWindow(var_63.findChildByName("msgTemplatesSelect"));
         prepareMsgSelect(var_748);
         var_748.procedure = onSelectTemplate;
         var _loc1_:IWindow = var_63.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_63.visible = true;
      }
      
      private function prepareMsgSelect(param1:IDropMenuWindow) : void
      {
         Logger.log("MSG TEMPLATES: " + var_60.initMsg.messageTemplates.length);
         param1.populate(var_60.initMsg.messageTemplates);
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
         var_748 = null;
         var_375 = null;
         var_60 = null;
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_52)
         {
            return;
         }
         var _loc3_:String = var_60.initMsg.messageTemplates["null"];
         if(_loc3_ != null)
         {
            var_311 = false;
            var_375.text = _loc3_;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      private function onAlertClose(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1305;
      }
   }
}
