package com.sulake.habbo.widget.chatinput
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class RoomChatInputView
   {
      
      private static const const_1411:int = 5;
      
      private static const const_488:int = 16;
      
      private static const const_1102:int = 20;
      
      private static const const_336:int = 10;
      
      private static const const_1101:int = 40;
       
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_1034:String;
      
      private var _window:IWindowContainer;
      
      private var var_2123:String;
      
      private var var_502:Boolean = false;
      
      private var var_399:Number = 600;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2125:String;
      
      private var var_2303:int = 0;
      
      private var var_1271:Boolean = false;
      
      private var var_147:String = "";
      
      private var var_698:Timer;
      
      private var var_855:Timer;
      
      private var _widget:RoomChatInputWidget;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_2124:Number = 0;
      
      public function RoomChatInputView(param1:RoomChatInputWidget, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super();
         _widget = param1;
         _windowManager = param2;
         _assetLibrary = param3;
         _localization = param4;
         var_1034 = _localization.getKey("widgets.chatinput.mode.whisper",":tell");
         var_2125 = _localization.getKey("widgets.chatinput.mode.shout",":shout");
         var_2123 = _localization.getKey("widgets.chatinput.mode.speak",":speak");
         var_698 = new Timer(1000,1);
         var_698.addEventListener(TimerEvent.TIMER_COMPLETE,onTypingTimerComplete);
         var_855 = new Timer(5000,1);
         var_855.addEventListener(TimerEvent.TIMER_COMPLETE,onIdleTimerComplete);
         createWindow();
         refreshView();
      }
      
      public function hideView() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      private function onInputChanged(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_855.reset();
         var _loc3_:* = _loc2_.text.length == 0;
         if(_loc3_)
         {
            var_502 = false;
            var_698.start();
         }
         else
         {
            if(_loc2_.text.length > NaN)
            {
               _loc2_.text = "";
            }
            var_147 = _loc2_.text;
            if(!var_502)
            {
               var_502 = true;
               var_698.reset();
               var_698.start();
            }
            var_855.start();
         }
      }
      
      private function onIdleTimerComplete(param1:TimerEvent) : void
      {
         var_502 = false;
         sendTypingMessage();
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            refreshView();
            return;
         }
         var _loc2_:XmlAsset = _assetLibrary.getAssetByName("chatinput_window") as XmlAsset;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("chatinput_widget_window","",HabboWindowType.const_55,HabboWindowStyle.const_40,0 | 0,new Rectangle(300,400,400,30),null) as IWindowContainer;
         _window.buildFromXML(_loc2_.content as XML);
         _window.tags.push("room_widget_chatinput");
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("left") as IBitmapWrapperWindow;
         var _loc4_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         var _loc5_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         var _loc6_:IBitmapWrapperWindow = _window.findChildByName("right") as IBitmapWrapperWindow;
         addEventListenerToChild(_loc3_);
         addEventListenerToChild(_loc4_);
         addEventListenerToChild(_loc5_);
         addEventListenerToChild(_loc6_);
         _loc4_.addEventListener(WindowKeyboardEvent.const_147,windowKeyEventProcessor);
         _loc4_.addEventListener(WindowEvent.const_44,onInputFieldResized);
         _loc4_.addEventListener(WindowEvent.const_135,onInputChanged);
         _window.addEventListener(WindowEvent.const_378,onWindowMoved);
         var_1271 = true;
         var_147 = "";
      }
      
      private function onTypingTimerComplete(param1:TimerEvent) : void
      {
         sendTypingMessage();
      }
      
      private function windowMouseEventProcessor(param1:Event = null, param2:IWindow = null) : void
      {
         setInputFieldFocus();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _widget = null;
         _windowManager = null;
         _assetLibrary = null;
         var_698 = null;
         var_855 = null;
      }
      
      private function setInputFieldFocus() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(var_1271)
         {
            _loc1_.text = "";
            _loc1_.textColor = 0;
            var_1271 = false;
            var_147 = "";
         }
         _loc1_.focus();
      }
      
      private function refreshView() : void
      {
         var _loc15_:* = null;
         var _loc16_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc1_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_left") as BitmapDataAsset;
         var _loc2_:BitmapData = (_loc1_.content as BitmapData).clone();
         var _loc3_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_middle") as BitmapDataAsset;
         var _loc4_:BitmapData = (_loc3_.content as BitmapData).clone();
         var _loc5_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_right") as BitmapDataAsset;
         var _loc6_:BitmapData = (_loc5_.content as BitmapData).clone();
         var _loc7_:IBitmapWrapperWindow = _window.findChildByName("left") as IBitmapWrapperWindow;
         var _loc8_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         var _loc9_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         var _loc10_:IBitmapWrapperWindow = _window.findChildByName("right") as IBitmapWrapperWindow;
         var _loc11_:Number = _loc2_.height;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var_2124 = _loc2_.width + const_488 + _loc6_.width + const_1102;
         if(_loc7_ != null)
         {
            _loc12_ = Number(_loc7_.width);
            _loc7_.bitmap = _loc2_;
         }
         if(_loc8_ != null)
         {
            _loc13_ = Number(Math.max(const_1101,_loc8_.width) + const_488);
            _loc8_.x = _loc12_;
            _loc8_.background = false;
            _loc8_.invalidate();
         }
         if(_loc9_ != null)
         {
            _loc9_.width = _loc13_;
            _loc12_ += _loc13_;
            _loc15_ = new Matrix();
            _loc15_.scale(_loc9_.width / _loc4_.width,1);
            _loc16_ = new BitmapData(_loc9_.width,_loc9_.height,true);
            _loc16_.draw(_loc4_,_loc15_);
            _loc9_.bitmap = new BitmapData(_loc9_.width,_loc4_.height,false);
            _loc9_.bitmap.copyPixels(_loc16_,_loc16_.rect,new Point(0,0));
         }
         if(_loc10_ != null)
         {
            _loc10_.bitmap = _loc6_;
            _loc10_.x = _loc12_;
            _loc12_ += _loc10_.width;
         }
         _window.width = _loc12_;
         _window.height = _loc11_;
         var _loc14_:IWindow = _window.getChildByName("bubblecont");
         if(_loc14_ != null)
         {
            _loc14_.width = _loc12_;
            _loc14_.height = _loc11_;
         }
      }
      
      private function onInputFieldResized(param1:WindowEvent) : void
      {
         checkInputFieldLimits();
         refreshView();
      }
      
      private function setInputFieldUnFocus() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.unfocus();
      }
      
      private function checkInputFieldLimits() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.textWidth >= var_399)
         {
            if(_loc1_.autoSize != TextFieldAutoSize.NONE)
            {
               _loc1_.autoSize = TextFieldAutoSize.NONE;
            }
         }
         else if(_loc1_.autoSize != TextFieldAutoSize.LEFT)
         {
            _loc1_.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      public function hideFloodBlocking() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.enable();
         _loc1_.selectable = true;
         _loc1_.text = "";
         var_147 = "";
         setInputFieldFocus();
         checkInputFieldLimits();
      }
      
      private function anotherFieldHasFocus() : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            if(_loc1_.focused)
            {
               return false;
            }
         }
         var _loc2_:DisplayObject = _window.context.getDesktopWindow().getDisplayObject();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.stage;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.focus;
               if(_loc4_ == null)
               {
                  return false;
               }
               if(_loc4_ is TextField)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function checkSpecialKeywordForInput() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.text == "")
         {
            return;
         }
         var _loc2_:String = _loc1_.text;
         var _loc3_:String = "null";
         if(_loc2_ == var_1034)
         {
            if(_loc3_.length > 0)
            {
               _loc1_.text += " undefined";
               _loc1_.setSelection(_loc1_.text.length,_loc1_.text.length);
               var_147 = _loc1_.text;
            }
         }
      }
      
      private function sendChatFromInputField(param1:int) : void
      {
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.text == "")
         {
            return;
         }
         var _loc3_:String = _loc2_.text;
         if(false && _loc3_ == ":crashme")
         {
            _widget.triggerManualCrash();
            _loc2_.text = "";
            var_147 = "";
            return;
         }
         var _loc4_:Array = _loc3_.split(" ");
         var _loc5_:String = "";
         var _loc6_:* = "";
         switch(_loc4_[0])
         {
            case var_1034:
               param1 = 0;
               _loc5_ = _loc4_[1];
               _loc6_ = var_1034 + " " + _loc5_ + " ";
               _loc4_.shift();
               _loc4_.shift();
               break;
            case var_2125:
               param1 = 0;
               _loc4_.shift();
               break;
            case var_2123:
               param1 = 0;
               _loc4_.shift();
         }
         _loc3_ = _loc4_.join(" ");
         if(_widget != null)
         {
            _widget.sendChat(_loc3_,param1,_loc5_);
            var_502 = false;
            sendTypingMessage();
         }
         _loc2_.text = _loc6_;
         var_147 = _loc6_;
         refreshView();
      }
      
      private function windowKeyEventProcessor(param1:Event = null, param2:IWindow = null) : void
      {
         var _loc4_:* = 0;
         var _loc5_:Boolean = false;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(_window == null || _widget == null || false)
         {
            return;
         }
         if(anotherFieldHasFocus())
         {
            return;
         }
         var _loc3_:int = var_2303;
         setInputFieldFocus();
         if(param1 is WindowKeyboardEvent)
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc4_ = uint(_loc6_.charCode);
            _loc5_ = _loc6_.shiftKey;
         }
         if(param1 is KeyboardEvent)
         {
            _loc7_ = param1 as KeyboardEvent;
            _loc4_ = uint(_loc7_.charCode);
            _loc5_ = _loc7_.shiftKey;
         }
         if(_loc7_ == null && _loc6_ == null)
         {
            return;
         }
         if(_loc5_)
         {
            _loc3_ = 0;
         }
         if(_loc4_ == Keyboard.SPACE)
         {
            checkSpecialKeywordForInput();
         }
         if(_loc4_ == Keyboard.ENTER)
         {
            sendChatFromInputField(_loc3_);
         }
         if(_loc4_ == Keyboard.BACKSPACE)
         {
            _loc8_ = _window.findChildByName("chat_input") as ITextFieldWindow;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.text;
               _loc10_ = _loc9_.split(" ");
               if(_loc10_[0] == var_1034 && _loc10_.length == 3 && _loc10_[2] == "")
               {
                  _loc8_.text = "";
                  var_147 = "";
               }
            }
         }
         checkInputFieldLimits();
      }
      
      public function setMaxWidth(param1:Number) : void
      {
         var_399 = param1 - var_2124;
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Number = _loc2_.width;
         if(int(_loc2_.textWidth) > _loc2_.width)
         {
            _loc3_ = Math.min(int(_loc2_.textWidth),var_399);
         }
         else
         {
            _loc3_ = Math.min(_loc3_,var_399);
         }
         if(_loc3_ != _loc2_.width)
         {
            _loc2_.width = _loc3_;
         }
         checkInputFieldLimits();
         refreshView();
      }
      
      private function onWindowMoved(param1:WindowEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         setMaxWidth(_window.context.getDesktopWindow().width - 0);
      }
      
      private function addEventListenerToChild(param1:IWindow) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(HabboWindowParam.const_39,true);
            param1.addEventListener(WindowMouseEvent.const_51,windowMouseEventProcessor);
         }
      }
      
      public function showFloodBlocking(param1:int) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.disable();
         _loc2_.selectable = false;
         _localization.registerParameter("chat.input.alert.flood","time",param1.toString());
         var _loc3_:ILocalization = _localization.getLocalization("chat.input.alert.flood");
         var _loc4_:String = "";
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.value;
         }
         _loc2_.text = _loc4_;
         setInputFieldUnFocus();
         refreshView();
      }
      
      private function sendTypingMessage() : void
      {
         if(_widget == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(var_502);
         _widget.messageListener.processWidgetMessage(_loc1_);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function displaySpecialChatMessage(param1:String, param2:String = "") : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.enable();
         _loc3_.selectable = true;
         _loc3_.text = "";
         setInputFieldFocus();
         _loc3_.text += param1 + " ";
         if(param2.length > 0)
         {
            _loc3_.text += param2 + " ";
         }
         _loc3_.setSelection(_loc3_.text.length,_loc3_.text.length);
         var_147 = _loc3_.text;
         checkInputFieldLimits();
      }
   }
}
