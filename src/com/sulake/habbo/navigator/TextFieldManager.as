package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   
   public class TextFieldManager
   {
       
      
      private var var_2282:Boolean;
      
      private var var_1526:int;
      
      private var var_2281:String = "";
      
      private var var_82:ITextFieldWindow;
      
      private var var_2283:uint;
      
      private var _orgTextBackgroundColor:uint;
      
      private var _navigator:HabboNavigator;
      
      private var var_1188:String = "";
      
      private var var_163:IWindowContainer;
      
      private var var_311:Boolean;
      
      private var var_1277:Function;
      
      public function TextFieldManager(param1:HabboNavigator, param2:ITextFieldWindow, param3:int = 1000, param4:Function = null, param5:String = null)
      {
         super();
         _navigator = param1;
         var_82 = param2;
         var_1526 = param3;
         var_1277 = param4;
         if(param5 != null)
         {
            var_311 = true;
            var_1188 = param5;
            var_82.text = param5;
         }
         Util.setProcDirectly(var_82,onInputClick);
         var_82.addEventListener(WindowKeyboardEvent.const_147,checkEnterPress);
         var_82.addEventListener(WindowEvent.const_135,checkMaxLen);
         this.var_2282 = var_82.textBackground;
         this._orgTextBackgroundColor = var_82.textBackgroundColor;
         this.var_2283 = var_82.textColor;
      }
      
      private function checkEnterPress(param1:Event) : void
      {
         var _loc2_:IWindow = IWindow(param1.target);
         if(!(param1 is WindowKeyboardEvent))
         {
            return;
         }
         var _loc3_:WindowKeyboardEvent = WindowKeyboardEvent(param1);
         if(_loc3_.charCode == Keyboard.ENTER)
         {
            if(var_1277 != null)
            {
               var_1277();
            }
         }
      }
      
      public function goBackToInitialState() : void
      {
         clearErrors();
         if(var_1188 != null)
         {
            var_82.text = var_1188;
            var_311 = true;
         }
         else
         {
            var_82.text = "";
            var_311 = false;
         }
      }
      
      public function get input() : ITextFieldWindow
      {
         return var_82;
      }
      
      public function restoreBackground() : void
      {
         var_82.textBackground = this.var_2282;
         var_82.textBackgroundColor = this._orgTextBackgroundColor;
         var_82.textColor = this.var_2283;
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
         var_82.text = var_2281;
         var_311 = false;
         this.restoreBackground();
      }
      
      public function clearErrors() : void
      {
         this.restoreBackground();
         if(this.var_163 != null)
         {
            var_163.visible = false;
         }
      }
      
      public function displayError(param1:String) : void
      {
         var_82.textBackground = true;
         var_82.textBackgroundColor = 4294021019;
         var_82.textColor = 4278190080;
         if(this.var_163 == null)
         {
            this.var_163 = IWindowContainer(_navigator.getXmlWindow("nav_error_popup"));
            _navigator.refreshButton(this.var_163,"popup_arrow_down",true,null,0);
            IWindowContainer(var_82.parent).addChild(this.var_163);
         }
         var _loc2_:ITextWindow = ITextWindow(this.var_163.findChildByName("error_text"));
         _loc2_.text = param1;
         _loc2_.width = _loc2_.textWidth + 5;
         var_163.findChildByName("border").width = _loc2_.width + 15;
         var_163.width = _loc2_.width + 15;
         var _loc3_:Point = new Point();
         var_82.getLocalPosition(_loc3_);
         this.var_163.x = _loc3_.x;
         this.var_163.y = _loc3_.y - this.var_163.height + 3;
         var _loc4_:IWindow = var_163.findChildByName("popup_arrow_down");
         _loc4_.x = this.var_163.width / 2 - _loc4_.width / 2;
         var_163.x += (0 - 0) / 2;
         this.var_163.visible = true;
      }
      
      public function getText() : String
      {
         if(var_311)
         {
            return var_2281;
         }
         return var_82.text;
      }
      
      private function isInputValid() : Boolean
      {
         return !var_311 && Util.trim(getText()).length > 2;
      }
      
      public function setText(param1:String) : void
      {
         var_311 = false;
         var_82.text = param1;
      }
      
      public function checkMandatory(param1:String) : Boolean
      {
         if(!isInputValid())
         {
            displayError(param1);
            return false;
         }
         restoreBackground();
         return true;
      }
      
      private function checkMaxLen(param1:Event) : void
      {
         var _loc2_:String = "null";
         if(_loc2_.length > var_1526)
         {
            var_82.text = _loc2_.substring(0,var_1526);
         }
      }
   }
}
