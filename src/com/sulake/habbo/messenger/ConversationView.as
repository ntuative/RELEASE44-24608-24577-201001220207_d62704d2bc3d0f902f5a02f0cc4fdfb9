package com.sulake.habbo.messenger
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.messenger.domain.Conversation;
   import com.sulake.habbo.messenger.domain.Message;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class ConversationView
   {
      
      private static const const_1065:int = 10;
      
      private static const const_1066:int = 20;
      
      private static const const_755:int = 100;
       
      
      private var var_1903:IScrollbarWindow;
      
      private var var_130:HabboMessenger;
      
      private var var_1436:IContainerButtonWindow;
      
      private var var_464:Conversation;
      
      private var var_61:IItemListWindow;
      
      public function ConversationView(param1:HabboMessenger, param2:IWindowContainer)
      {
         super();
         var_130 = param1;
         var_1436 = initButton("follow_friend",onFollowButtonClick,param2);
         var_61 = IItemListWindow(param2.findChildByName("msg_list"));
         var_1903 = IScrollbarWindow(param2.findChildByName("scroller"));
         var_130.refreshButton(param2,"close",true,onCloseButtonClick,0);
         initButton("minimail",onMinimailButtonClick,param2);
      }
      
      public function refreshHeader() : void
      {
         if(false)
         {
            var_1436.enable();
         }
         else
         {
            var_1436.disable();
         }
      }
      
      private function findAddIndex() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_ < var_61.numListItems)
         {
            _loc2_ = var_61.getListItemAt(_loc1_);
            if(!_loc2_.visible)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ + 1;
      }
      
      private function getChatTextColor(param1:int) : uint
      {
         if(param1 == Message.const_548)
         {
            return 4285887861;
         }
         if(param1 == Message.const_613)
         {
            return 4285887861;
         }
         return 4278190080;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:Message) : Boolean
      {
         var _loc4_:ITextWindow = var_61.getListItemAt(param2) as ITextWindow;
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = ITextWindow(var_130.getXmlWindow("msg_entry"));
            _loc4_.width = var_61.width;
            var_61.addListItem(_loc4_);
         }
         if(!param1)
         {
            _loc4_.height = 0;
            _loc4_.visible = false;
            return false;
         }
         _loc4_.visible = true;
         var _loc5_:String = param3.type == Message.const_528 || param3.type == Message.const_538 ? param3.time + ": " : "";
         _loc4_.text = _loc5_ + param3.messageText;
         _loc4_.color = getChatBgColor(param3.type);
         _loc4_.textColor = getChatTextColor(param3.type);
         refreshTextDims(_loc4_);
         return false;
      }
      
      private function refreshList() : void
      {
         var _loc3_:Boolean = false;
         if(var_61 == null)
         {
            return;
         }
         var_61.autoArrangeItems = false;
         var _loc1_:int = 0;
         var _loc2_:int = Math.max(0,var_464.messages.length - const_755);
         _loc1_ = 0;
         while(_loc1_ + _loc2_ < var_464.messages.length)
         {
            refreshEntry(true,_loc1_,var_464.messages[_loc1_ + _loc2_]);
            _loc1_++;
         }
         while(true)
         {
            _loc3_ = refreshEntry(false,_loc1_,null);
            if(_loc3_)
            {
               break;
            }
            _loc1_++;
         }
         var_61.autoArrangeItems = true;
      }
      
      public function refresh() : void
      {
         var _loc1_:Conversation = var_130.conversations.findSelectedConversation();
         if(_loc1_ == null)
         {
            return;
         }
         if(var_464 == null || _loc1_.id != var_464.id)
         {
            var_464 = _loc1_;
            refreshList();
            afterResize();
         }
         refreshHeader();
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc1_:IWindowContainer = IWindowContainer(var_61.parent);
         var _loc2_:IWindow = _loc1_.getChildByName("scroller") as IWindow;
         var _loc3_:* = var_61.scrollableRegion.height > var_61.height;
         if(_loc2_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc2_.visible = false;
            var_61.width = NaN;
            return true;
         }
         if(_loc3_)
         {
            _loc2_.visible = true;
            var_61.width = -22;
            return true;
         }
         return false;
      }
      
      private function refreshListDims() : void
      {
         var _loc2_:* = null;
         var_61.autoArrangeItems = false;
         var _loc1_:int = 0;
         while(_loc1_ < var_61.numListItems)
         {
            _loc2_ = ITextWindow(var_61.getListItemAt(_loc1_));
            refreshTextDims(_loc2_);
            if(!_loc2_.visible)
            {
               break;
            }
            _loc1_++;
         }
         var_61.autoArrangeItems = true;
      }
      
      public function addMessage(param1:Message) : void
      {
         var _loc2_:int = findAddIndex();
         if(_loc2_ >= const_755 + const_1066)
         {
            refreshList();
            afterResize();
         }
         else
         {
            var_61.autoArrangeItems = false;
            this.refreshEntry(true,_loc2_,param1);
            var_61.autoArrangeItems = true;
         }
         var_1903.scrollV = 1;
         refreshScrollBarVisibility();
      }
      
      private function onCloseButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close clicked");
         var_130.conversations.closeConversation();
         var_130.messengerView.refresh(true);
      }
      
      private function onFollowButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Follow clicked");
         var_130.send(new FollowFriendMessageComposer(var_464.id));
      }
      
      public function afterResize() : void
      {
         refreshListDims();
         var _loc1_:Boolean = refreshScrollBarVisibility();
         if(_loc1_)
         {
            refreshListDims();
         }
      }
      
      private function initButton(param1:String, param2:Function, param3:IWindowContainer) : IContainerButtonWindow
      {
         var _loc4_:IContainerButtonWindow = IContainerButtonWindow(param3.findChildByName("button_" + param1));
         _loc4_.procedure = param2;
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc4_.findChildByName("icon"));
         _loc5_.bitmap = var_130.getButtonImage(param1);
         _loc5_.width = _loc5_.bitmap.width;
         _loc5_.height = _loc5_.bitmap.height;
         return _loc4_;
      }
      
      private function getChatBgColor(param1:int) : uint
      {
         if(param1 == Message.const_528)
         {
            return 4294967295;
         }
         if(param1 == Message.const_538)
         {
            return 4292801535;
         }
         if(param1 == Message.const_978)
         {
            return 4294927974;
         }
         if(param1 == Message.const_548)
         {
            return 4293454056;
         }
         if(param1 == Message.const_613)
         {
            return 4293454056;
         }
         if(param1 == Message.const_930)
         {
            return 4288269465;
         }
         return 4291611852;
      }
      
      private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Minimail clicked");
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["recipientid"] = "undefined";
         _loc3_["random"] = "" + Math.round(Math.random() * 100000000);
         if(var_130.isEmbeddedMinimailEnabled())
         {
            if(false)
            {
               ExternalInterface.call("FlashExternalInterface.openHabblet","minimail","#mail/compose/" + _loc3_["recipientid"] + "/" + _loc3_["random"] + "/");
            }
         }
         else
         {
            var_130.openHabboWebPage("link.format.mail.compose",_loc3_,param1);
         }
      }
      
      private function refreshTextDims(param1:ITextWindow) : void
      {
         param1.width = var_61.width;
         param1.height = param1.textHeight + const_1065;
         param1.invalidate();
      }
   }
}
