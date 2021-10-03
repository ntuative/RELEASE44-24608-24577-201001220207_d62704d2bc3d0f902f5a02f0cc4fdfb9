package com.sulake.core.window
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.enum.MouseListenerType;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.WindowRedrawFlag;
   import com.sulake.core.window.utils.ChildEntityArray;
   import com.sulake.core.window.utils.IChildEntity;
   import com.sulake.core.window.utils.IWindowMouseListenerService;
   import com.sulake.core.window.utils.WindowRectLimits;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class WindowController extends WindowModel implements IWindow, IChildEntity, IGraphicContextHost
   {
      
      private static var var_1488:Point = new Point();
      
      protected static const EXCLUDE_CHILD_TAG:String = "_EXCLUDE";
      
      protected static const INTERNAL_CHILD_TAG:String = "_INTERNAL";
      
      private static var var_1240:uint = 0;
       
      
      private var var_1015:Boolean = false;
      
      protected var _events:IEventDispatcher;
      
      private var var_306:Rectangle;
      
      protected var var_600:Function;
      
      protected var _children:ChildEntityArray;
      
      protected var var_1328:Boolean = false;
      
      private var var_2034:uint;
      
      protected var var_23:WindowController;
      
      protected var var_721:uint = 10;
      
      protected var var_30:IGraphicContext;
      
      protected var _drawable:Boolean = true;
      
      public function WindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc13_:* = 0;
         var_2034 = var_1240++;
         var _loc12_:XML = param5.getWindowFactory().getLayoutByType(param2,param3);
         if(param6 == null)
         {
            param6 = new Rectangle(0,0,_loc12_ == null ? 10 : Number(int(_loc12_.attribute("width"))),_loc12_ == null ? 10 : Number(int(_loc12_.attribute("height"))));
         }
         super(param11,param1,param2,param3,param4,param5,param6,param10);
         if(!var_30)
         {
            var_30 = getGraphicContext(!testParamFlag(WindowParam.const_32));
         }
         _events = new EventDispatcher(this);
         _children = new ChildEntityArray();
         var_306 = new Rectangle();
         if(_loc12_ != null)
         {
            var_364 = new Rectangle(0,0,int(_loc12_.attribute("width")),int(_loc12_.attribute("height")));
            var_64 = var_364.clone();
            var_22 = var_364.clone();
            param5.getWindowParser().parseAndConstruct(_loc12_,this,null);
            _loc13_ = uint(var_31);
            var_31 &= -1;
            setRectangle(param6.x,param6.y,param6.width,param6.height);
            var_31 = _loc13_;
            var_64.x = param6.x;
            var_64.y = param6.y;
            var_64.width = param6.width;
            var_64.height = param6.height;
         }
         if(param9)
         {
            this.properties = param9;
         }
         var_600 = param8;
         if(param7 != null)
         {
            var_23 = param7 as WindowController;
            WindowController(param7).addChild(this);
            if(var_30)
            {
               var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
            }
         }
      }
      
      private static function calculateMouseRegion(param1:WindowController, param2:Rectangle) : void
      {
         var _loc8_:int = 0;
         var _loc3_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc3_);
         var _loc5_:uint = param1.numChildren;
         var _loc6_:int = _loc3_.x;
         var _loc7_:int = _loc3_.y;
         param2.left = _loc6_ < param2.left ? Number(_loc6_) : Number(param2.left);
         param2.top = _loc7_ < param2.top ? Number(_loc7_) : Number(param2.top);
         param2.right = _loc3_.right > param2.right ? Number(_loc3_.right) : Number(param2.right);
         param2.bottom = _loc3_.bottom > param2.bottom ? Number(_loc3_.bottom) : Number(param2.bottom);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            WindowController.calculateMouseRegion(WindowController(param1.getChildAt(_loc8_)),param2);
            _loc8_++;
         }
      }
      
      public static function resizeToAccommodateChildren(param1:WindowController, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc12_:* = null;
         var _loc13_:Boolean = false;
         var _loc4_:int = !!param2 ? 0 : 0;
         var _loc5_:int = !!param2 ? 0 : 0;
         var _loc6_:int = !!param2 ? 0 : 0;
         var _loc7_:int = !!param2 ? 0 : 0;
         var _loc9_:Boolean = false;
         var _loc10_:uint = param1.numChildren;
         var _loc11_:Boolean = param1.getParamFlag(WindowParam.const_62);
         if(param2)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               _loc8_ = param1.getChildAt(_loc3_).rectangle;
               if(_loc8_.x < _loc4_)
               {
                  _loc4_ = _loc8_.x;
                  _loc9_ = true;
               }
               if(_loc8_.right > _loc6_)
               {
                  _loc6_ = _loc8_.right;
                  _loc9_ = true;
               }
               if(_loc8_.y < _loc5_)
               {
                  _loc5_ = _loc8_.y;
                  _loc9_ = true;
               }
               if(_loc8_.bottom > _loc7_)
               {
                  _loc7_ = _loc8_.bottom;
                  _loc9_ = true;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               _loc8_ = param1.getChildAt(_loc3_).rectangle;
               if(_loc8_.x < _loc4_)
               {
                  _loc4_ = _loc8_.x;
                  _loc9_ = true;
               }
               if(_loc8_.right > _loc6_)
               {
                  _loc6_ = _loc8_.right;
                  _loc9_ = true;
               }
               if(_loc8_.y < _loc5_)
               {
                  _loc5_ = _loc8_.y;
                  _loc9_ = true;
               }
               if(_loc8_.bottom > _loc7_)
               {
                  _loc7_ = _loc8_.bottom;
                  _loc9_ = true;
               }
               _loc3_++;
            }
         }
         if(_loc9_)
         {
            if(_loc11_)
            {
               param1.setParamFlag(WindowParam.const_62,false);
            }
            if(param2)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_)
               {
                  _loc12_ = param1.getChildAt(_loc3_);
                  _loc13_ = param1.testParamFlag(WindowParam.const_78);
                  if(_loc13_)
                  {
                     param1.setParamFlag(WindowParam.const_78,false);
                  }
                  param1.offset(-_loc4_,-_loc5_);
                  if(_loc13_)
                  {
                     param1.setParamFlag(WindowParam.const_78,true);
                  }
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_)
               {
                  param1.getChildAt(_loc3_).offset(-_loc4_,-_loc5_);
                  _loc3_++;
               }
            }
            param1.setRectangle(param1.x + _loc4_,param1.y + _loc5_,!!param2 ? int(_loc6_ - _loc4_) : int(_loc6_),!!param2 ? int(_loc7_ - _loc5_) : int(_loc7_));
            if(_loc11_)
            {
               param1.setParamFlag(WindowParam.const_62,true);
            }
         }
      }
      
      public static function expandToAccommodateChild(param1:WindowController, param2:IWindow) : void
      {
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.width;
         var _loc6_:int = param1.height;
         var _loc7_:Rectangle = param2.rectangle.clone();
         var _loc8_:Boolean = false;
         if(_loc7_.x < 0)
         {
            _loc3_ = _loc7_.x;
            _loc5_ -= _loc3_;
            _loc7_.x = 0;
            _loc8_ = true;
         }
         if(_loc7_.right > _loc5_)
         {
            _loc5_ = _loc7_.x + _loc7_.width;
            _loc8_ = true;
         }
         if(_loc7_.y < 0)
         {
            _loc4_ = _loc7_.y;
            _loc6_ -= _loc4_;
            _loc7_.y = 0;
            _loc8_ = true;
         }
         if(_loc7_.bottom > _loc6_)
         {
            _loc6_ = _loc7_.y + _loc7_.height;
            _loc8_ = true;
         }
         if(_loc8_)
         {
            _loc9_ = param1.getParamFlag(WindowParam.const_62);
            param1.setParamFlag(WindowParam.const_62,false);
            param1.setRectangle(param1.x + _loc3_,param1.y + _loc4_,_loc5_,_loc6_);
            if(_loc4_ != 0 || _loc3_ != 0)
            {
               _loc11_ = uint(param1.numChildren);
               _loc10_ = 0;
               while(_loc10_ < _loc11_)
               {
                  IWindow(param1.getChildAt(_loc10_)).offset(-_loc3_,-_loc4_);
                  _loc10_++;
               }
            }
            if(_loc9_)
            {
               param1.setParamFlag(WindowParam.const_62,true);
            }
         }
      }
      
      public function getChildByTag(param1:String) : IWindow
      {
         return _children.getChildByTag(param1) as IWindow;
      }
      
      public function getStyleFlag(param1:uint) : Boolean
      {
         return (var_89 & param1) != 0;
      }
      
      protected function updateScaleRelativeToParent() : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = null;
         if(var_23 == null)
         {
            return;
         }
         var _loc1_:* = !testParamFlag(WindowParam.const_105,WindowParam.const_131);
         var _loc2_:* = !testParamFlag(WindowParam.const_113,WindowParam.const_148);
         if(_loc1_ || _loc2_)
         {
            _loc3_ = var_22.clone();
            if(_loc1_)
            {
               _loc4_ = 0 - 0;
               _loc5_ = uint(var_31 & 0);
               if(_loc5_ == WindowParam.const_257)
               {
                  _loc3_.width += _loc4_;
               }
               else if(_loc5_ == WindowParam.const_311)
               {
                  _loc3_.x += _loc4_;
               }
               else if(_loc5_ == WindowParam.const_155)
               {
                  if(var_23.width < _loc3_.width && getParamFlag(WindowParam.const_32))
                  {
                     _loc3_.x = 0;
                  }
                  else
                  {
                     _loc3_.x = 0 - _loc3_.width / 2;
                  }
               }
            }
            if(_loc2_)
            {
               _loc4_ = 0 - 0;
               _loc5_ = uint(var_31 & 0);
               if(_loc5_ == WindowParam.const_232)
               {
                  _loc3_.height += _loc4_;
               }
               else if(_loc5_ == WindowParam.const_276)
               {
                  _loc3_.y += _loc4_;
               }
               else if(_loc5_ == WindowParam.const_156)
               {
                  if(var_23.height < _loc3_.height && getParamFlag(WindowParam.const_32))
                  {
                     _loc3_.y = 0;
                  }
                  else
                  {
                     _loc3_.y = 0 - _loc3_.height / 2;
                  }
               }
            }
            _loc6_ = uint(var_31);
            var_31 &= -1;
            setRectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
            var_31 = _loc6_;
         }
         else if(testParamFlag(WindowParam.const_78))
         {
            _loc3_ = var_22.clone();
            if(var_23 != null)
            {
               _loc7_ = var_23.rectangle;
               _loc3_.x = _loc3_.x < 0 ? 0 : Number(_loc3_.x);
               _loc3_.y = _loc3_.y < 0 ? 0 : Number(_loc3_.y);
               _loc3_.x -= _loc3_.x + _loc3_.width > _loc7_.width ? _loc3_.x + _loc3_.width - _loc7_.width : 0;
               _loc3_.y -= _loc3_.y + _loc3_.height > _loc7_.height ? _loc3_.y + _loc3_.height - _loc7_.height : 0;
               _loc3_.width -= _loc3_.x + _loc3_.width > _loc7_.width ? _loc3_.x + _loc3_.width - _loc7_.width : 0;
               _loc3_.height -= _loc3_.y + _loc3_.height > _loc7_.height ? _loc3_.y + _loc3_.height - _loc7_.height : 0;
               if(_loc3_.x != var_22.x || _loc3_.y != var_22.y || _loc3_.width != var_22.width || _loc3_.height != var_22.height)
               {
                  _loc6_ = uint(var_31);
                  var_31 &= -1;
                  setRectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
                  var_31 = _loc6_;
               }
            }
         }
      }
      
      public function get desktop() : IDesktopWindow
      {
         return var_29.getDesktopWindow();
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            if(true)
            {
               if(!isChildWindow())
               {
                  if(getStateFlag(WindowState.const_87))
                  {
                     deactivate();
                  }
               }
            }
            while(false)
            {
               IDisposable(_children.removeChildAt(0)).dispose();
            }
            if(parent)
            {
               parent = null;
            }
            dispatchEvent(new WindowDisposeEvent(this));
            if(_events is IDisposable)
            {
               IDisposable(_events).dispose();
               _events = null;
            }
            if(var_30 != null)
            {
               var_30.dispose();
               var_30 = null;
            }
            super.dispose();
         }
      }
      
      protected function forwardKeyboardEvent(param1:KeyboardEvent) : WindowEvent
      {
         var _loc2_:String = "null";
         switch(param1.type)
         {
            case KeyboardEvent.KEY_DOWN:
               _loc2_ = "null";
               break;
            case KeyboardEvent.KEY_UP:
               _loc2_ = "null";
         }
         var _loc4_:WindowEvent = new WindowKeyboardEvent(_loc2_,param1,this,null,false,true);
         procedure(_loc4_,this);
         if(!_loc4_.isWindowOperationPrevented())
         {
            dispatchEvent(_loc4_);
         }
         return _loc4_;
      }
      
      public function set tags(param1:Array) : void
      {
         if(param1 != null)
         {
            var_602 = param1;
         }
      }
      
      public function getChildAt(param1:int) : IWindow
      {
         return _children.getChildAt(param1) as IWindow;
      }
      
      public function set id(param1:uint) : void
      {
         _id = param1;
      }
      
      public function getChildByID(param1:uint) : IWindow
      {
         return _children.getChildByID(param1) as IWindow;
      }
      
      public function findChildByName(param1:String) : IWindow
      {
         var _loc3_:int = 0;
         var _loc2_:WindowController = WindowController(_children.getChildByName(param1));
         if(_loc2_ == null)
         {
            _loc3_ = 0;
            while(_loc3_ < _children.numChildren)
            {
               _loc2_ = WindowController(_children.getChildAt(_loc3_)).findChildByName(param1) as WindowController;
               if(_loc2_ != null)
               {
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_ as IWindow;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         var value:Boolean = false;
         var event:Event = param1;
         try
         {
            if(!_disposed)
            {
               value = _events.dispatchEvent(event);
            }
         }
         catch(e:Error)
         {
            trace(e);
         }
         return value;
      }
      
      public function setGlobalRectangle(param1:Rectangle) : void
      {
         var _loc2_:Point = new Point();
         if(var_23 != null)
         {
            var_23.getGlobalPosition(_loc2_);
            _loc2_.x += var_22.x;
            _loc2_.y += var_22.y;
         }
         else
         {
            _loc2_.x = var_22.x;
            _loc2_.y = var_22.y;
         }
         setRectangle(x + (param1.x - _loc2_.x),y + (param1.y - _loc2_.y),param1.width,param1.height);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(!_disposed)
         {
            _events.addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      public function set height(param1:int) : void
      {
         if(param1 != var_22.height)
         {
            setRectangle(var_22.x,var_22.y,var_22.width,param1);
         }
      }
      
      public function set position(param1:Point) : void
      {
         setRectangle(param1.x,param1.y,var_22.width,var_22.height);
      }
      
      public function get debug() : Boolean
      {
         return var_1328;
      }
      
      public function set background(param1:Boolean) : void
      {
         var_5 = param1;
         var_601 = !!var_5 ? uint(var_601 | var_1331) : uint(var_601 & 16777215);
         _drawable = _drawable || param1;
         var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
      }
      
      public function destroy() : Boolean
      {
         if(var_46 == WindowState.const_349)
         {
            return true;
         }
         var_46 = WindowState.const_349;
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_993,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         _loc1_.type = WindowNotifyEvent.const_970;
         update(this,_loc1_);
         dispose();
         return true;
      }
      
      public function center() : void
      {
         if(var_23 != null)
         {
            x = 0 - 0;
            y = 0 - 0;
         }
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function setupGraphicsContext() : IGraphicContext
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var_30 = getGraphicContext(true);
         if(var_23)
         {
            var_23.setupGraphicsContext();
         }
         if(numChildren > 0)
         {
            if(var_30.numChildContexts != numChildren)
            {
               _loc1_ = uint(numChildren);
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  var_30.addChildContextAt(WindowController(getChildAt(_loc2_)).getGraphicContext(true),_loc2_);
                  _loc2_++;
               }
            }
         }
         var_1015 = true;
         return var_30;
      }
      
      private function notifyChildren(param1:WindowNotifyEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            WindowController(getChildAt(_loc2_)).update(this,param1);
            _loc2_++;
         }
      }
      
      public function hitTestLocalRectangle(param1:Rectangle) : Boolean
      {
         return var_22.intersects(param1);
      }
      
      public function toString() : String
      {
         return "[Window " + getQualifiedClassName(this) + " " + var_2034 + "]";
      }
      
      protected function notifyEventListeners(param1:WindowEvent) : void
      {
         procedure(param1,this);
         if(!param1.isWindowOperationPrevented())
         {
            if(hasEventListener(param1.type))
            {
               dispatchEvent(param1);
            }
         }
      }
      
      public function set type(param1:uint) : void
      {
         if(param1 != _type)
         {
            _type = param1;
            var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
         }
      }
      
      protected function forwardWindowNotifyEvent(param1:WindowNotifyEvent) : WindowEvent
      {
         var _loc5_:* = null;
         if(_disposed)
         {
            return _loc5_;
         }
         var _loc2_:String = "null";
         var _loc3_:IWindow = !!param1.related ? param1.related : param1.window;
         var _loc4_:Boolean = false;
         switch(param1.type)
         {
            case WindowNotifyEvent.const_670:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_211:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_887:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_386:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_918:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_319:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_901:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_943:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_1225:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_1293:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_993:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_970:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_444:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_306:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_618:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_602:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_896:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_555:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_872:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_509:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_992:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_995:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_938:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_815:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_835:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_895:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_980:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_945:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_942:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_921:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_820:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_908:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_958:
               _loc2_ = "null";
               _loc4_ = true;
               break;
            case WindowNotifyEvent.const_960:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_376:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_453:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_374:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_507:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_208:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_907:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_227:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_387:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_289:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_860:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_693:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_395:
               _loc2_ = "null";
               break;
            case WindowNotifyEvent.const_254:
               _loc2_ = "null";
         }
         if(_loc2_ == WindowEvent.const_173)
         {
            throw new Error("Unknown window notify event: " + param1.type + "!");
         }
         _loc5_ = new WindowEvent(_loc2_,this,_loc3_,false,_loc4_);
         procedure(_loc5_,this);
         if(!_disposed)
         {
            if(!(_loc4_ && _loc5_.isWindowOperationPrevented()))
            {
               if(hasEventListener(_loc2_))
               {
                  dispatchEvent(_loc5_);
               }
            }
            if(param1.cancelable)
            {
               if(_loc5_.isWindowOperationPrevented())
               {
                  param1.preventWindowOperation();
               }
            }
         }
         return _loc5_;
      }
      
      public function setStyleFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = var_89;
         var _loc4_:*;
         var_89 = !!param2 ? (_loc4_ = var_89 | param1, var_89 |= param1, uint(_loc4_)) : (_loc4_ = var_89 & ~param1, var_89 &= ~param1, uint(_loc4_));
         if(var_89 != _loc3_)
         {
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_376,this,null));
         }
      }
      
      public function open() : Boolean
      {
         if(getStateFlag(WindowState.const_81))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_992,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         visible = true;
         _loc1_.type = WindowNotifyEvent.const_995;
         update(this,_loc1_);
         return true;
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         _children.swapChildrenAt(param1,param2);
         var_30.swapChildContextsAt(param1,param2);
      }
      
      public function getChildByName(param1:String) : IWindow
      {
         return _children.getChildByName(param1) as IWindow;
      }
      
      public function deactivate() : Boolean
      {
         if(!getStateFlag(WindowState.const_87))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_901,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_87,false);
         _loc1_.type = WindowNotifyEvent.const_943;
         update(this,_loc1_);
         return true;
      }
      
      public function restore() : Boolean
      {
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_942,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_61,false);
         _loc1_.type = WindowNotifyEvent.const_921;
         update(this,_loc1_);
         return true;
      }
      
      public function offset(param1:Number, param2:Number) : void
      {
         setRectangle(var_22.x + param1,var_22.y + param2,var_22.width,var_22.height);
      }
      
      public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_30)
         {
            var_30 = new GraphicContext("GC {" + _name + "}",GraphicContext.GC_TYPE_BITMAP,var_22);
            var_30.visible = var_353;
         }
         return var_30;
      }
      
      public function minimize() : Boolean
      {
         if(var_46 & 0)
         {
            return false;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_835,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_61,true);
         _loc1_.type = WindowNotifyEvent.const_895;
         update(this,_loc1_);
         return true;
      }
      
      public function findChildByTag(param1:String) : IWindow
      {
         var _loc4_:int = 0;
         if(var_602.indexOf(param1) > -1)
         {
            return this;
         }
         var _loc2_:WindowController = WindowController(_children.getChildByTag(param1));
         var _loc3_:int = 0;
         if(_loc2_ == null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = WindowController(_children.getChildAt(_loc4_)).findChildByTag(param1) as WindowController;
               if(_loc2_ != null)
               {
                  break;
               }
               _loc4_++;
            }
         }
         return _loc2_ as IWindow;
      }
      
      public function set blend(param1:Number) : void
      {
         var_410 = param1 > 1 ? 1 : (param1 < 0 ? 0 : Number(param1));
         var_29.invalidate(this,var_22,WindowRedrawFlag.const_826);
      }
      
      public function set debug(param1:Boolean) : void
      {
         var_1328 = param1;
      }
      
      public function addChildAt(param1:IWindow, param2:int) : IWindow
      {
         var _loc3_:WindowController = WindowController(param1);
         if(_loc3_.parent != null)
         {
            WindowController(_loc3_.parent).removeChild(_loc3_);
         }
         _children.addChildAt(_loc3_,param2);
         _loc3_.parent = this;
         if(var_1015 || _loc3_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc3_.getGraphicContext(true).parent != var_30)
            {
               var_30.addChildContextAt(_loc3_.getGraphicContext(true),param2);
            }
         }
         update(this,new WindowNotifyEvent(WindowNotifyEvent.const_289,this,param1));
         return param1;
      }
      
      public function get parent() : IWindow
      {
         return var_23;
      }
      
      public function swapChildren(param1:IWindow, param2:IWindow) : void
      {
         _children.swapChildren(WindowController(param1),WindowController(param2));
         if(WindowController(param1).hasGraphicsContext() || WindowController(param2).hasGraphicsContext())
         {
            var_30.swapChildContexts(WindowController(param1).getGraphicContext(true),WindowController(param2).getGraphicContext(true));
         }
      }
      
      public function hasGraphicsContext() : Boolean
      {
         return !testParamFlag(WindowParam.const_32) || var_30 != null;
      }
      
      protected function isChildWindow() : Boolean
      {
         return var_23 != context.getDesktopWindow();
      }
      
      public function getRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null, param4:Rectangle = null) : void
      {
         if(param1 != null)
         {
            param1.x = var_22.x;
            param1.y = var_22.y;
            param1.width = var_22.width;
            param1.height = var_22.height;
         }
         if(param2 != null)
         {
            param2.x = var_64.x;
            param2.y = var_64.y;
            param2.width = var_64.width;
            param2.height = var_64.height;
         }
         if(param3 != null && var_151 != null)
         {
            param3.x = var_151.x;
            param3.y = var_151.y;
            param3.width = var_151.width;
            param3.height = var_151.height;
         }
         if(param4 != null && var_152 != null)
         {
            param4.x = var_152.x;
            param4.y = var_152.y;
            param4.width = var_152.width;
            param4.height = var_152.height;
         }
      }
      
      protected function requiresOwnGraphicContext() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(testParamFlag(WindowParam.const_32))
         {
            _loc2_ = numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = getChildAt(_loc3_) as WindowController;
               if(_loc1_.requiresOwnGraphicContext())
               {
                  return true;
               }
               _loc3_++;
            }
            return false;
         }
         return true;
      }
      
      public function getMouseRegion(param1:Rectangle) : void
      {
         var _loc2_:* = null;
         getGlobalRectangle(param1);
         if(param1.width < 0)
         {
            param1.width = 0;
         }
         if(param1.height < 0)
         {
            param1.height = 0;
         }
         if(testParamFlag(WindowParam.const_32))
         {
            _loc2_ = new Rectangle();
            IWindow(var_23).getMouseRegion(_loc2_);
            if(param1.left < _loc2_.left)
            {
               param1.left = _loc2_.left;
            }
            if(param1.top < _loc2_.top)
            {
               param1.top = _loc2_.top;
            }
            if(param1.right > _loc2_.right)
            {
               param1.right = _loc2_.right;
            }
            if(param1.bottom > _loc2_.bottom)
            {
               param1.bottom = _loc2_.bottom;
            }
         }
      }
      
      public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return testLocalPointHitAgainstAlpha(param1,param2,var_721);
      }
      
      public function set color(param1:uint) : void
      {
         var_1331 = param1 & 4278190080;
         var_601 = !!var_5 ? uint(param1) : uint(param1 & 16777215);
         var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
      }
      
      public function update(param1:WindowController, param2:Event) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         if(!testParamFlag(WindowParam.const_549))
         {
            if(param2 is MouseEvent)
            {
               _loc3_ = forwardMouseEvent(param2 as MouseEvent);
            }
            else if(param2 is KeyboardEvent)
            {
               _loc3_ = forwardKeyboardEvent(param2 as KeyboardEvent);
            }
            else if(param2 is WindowNotifyEvent)
            {
               _loc3_ = forwardWindowNotifyEvent(param2 as WindowNotifyEvent);
            }
            else if(param2 is Event)
            {
               _loc3_ = forwardNormalEvent(param2);
            }
            if(_disposed)
            {
               return true;
            }
            if(_loc3_.cancelable)
            {
               if(_loc3_.isWindowOperationPrevented())
               {
                  return true;
               }
            }
            if(param2.cancelable)
            {
               if(!param2.isDefaultPrevented())
               {
                  return true;
               }
            }
         }
         if(param2 is MouseEvent)
         {
            switch(param2.type)
            {
               case MouseEvent.MOUSE_DOWN:
                  if(activate())
                  {
                     if(param2.cancelable)
                     {
                        param2.preventDefault();
                     }
                  }
                  setStateFlag(WindowState.const_92,true);
                  _loc4_ = var_29.getWindowServices().getMouseListenerService();
                  _loc4_.begin(this);
                  _loc4_.eventTypes.push(MouseEvent.MOUSE_UP);
                  _loc4_.areaLimit = MouseListenerType.const_808;
                  if(testParamFlag(WindowParam.const_286))
                  {
                     _loc5_ = {};
                     while(_loc5_ != null)
                     {
                        if(_loc5_.testParamFlag(WindowParam.const_194))
                        {
                           var_29.getWindowServices().getMouseDraggingService().begin(_loc5_);
                           break;
                        }
                        _loc5_ = _loc5_.parent;
                     }
                  }
                  if((var_31 & 0) > 0)
                  {
                     _loc5_ = {};
                     while(_loc5_ != null)
                     {
                        if(_loc5_.testParamFlag(WindowParam.const_233))
                        {
                           var_29.getWindowServices().getMouseScalingService().begin(_loc5_,var_31 & 0);
                           break;
                        }
                        _loc5_ = _loc5_.parent;
                     }
                  }
                  break;
               case MouseEvent.MOUSE_UP:
                  if(testStateFlag(WindowState.const_92))
                  {
                     setStateFlag(WindowState.const_92,false);
                  }
                  var_29.getWindowServices().getMouseListenerService().end(this);
                  if(testParamFlag(WindowParam.const_194))
                  {
                     var_29.getWindowServices().getMouseDraggingService().end(this);
                  }
                  if(testParamFlag(WindowParam.const_233))
                  {
                     var_29.getWindowServices().getMouseScalingService().end(this);
                  }
                  break;
               case MouseEvent.MOUSE_OUT:
                  if(testStateFlag(WindowState.const_75))
                  {
                     setStateFlag(WindowState.const_75,false);
                  }
                  break;
               case MouseEvent.MOUSE_OVER:
                  if(!testStateFlag(WindowState.const_75))
                  {
                     setStateFlag(WindowState.const_75,true);
                  }
                  break;
               case MouseEvent.MOUSE_WHEEL:
                  return false;
            }
         }
         if(param2 is WindowNotifyEvent)
         {
            switch(param2.type)
            {
               case WindowNotifyEvent.const_211:
                  var_29.invalidate(this,var_22.union(var_64),WindowRedrawFlag.RESIZE);
                  if(param1 == this)
                  {
                     notifyChildren(new WindowNotifyEvent(WindowNotifyEvent.const_395,this,null));
                     if(testParamFlag(WindowParam.const_155,WindowParam.const_131))
                     {
                        updateScaleRelativeToParent();
                     }
                     else if(testParamFlag(WindowParam.const_156,WindowParam.const_148))
                     {
                        updateScaleRelativeToParent();
                     }
                     if(var_23 != null)
                     {
                        _loc8_ = uint(var_31);
                        var_31 &= ~(0 | 0);
                        if(testParamFlag(WindowParam.const_392))
                        {
                           var_23.width += 0 - 0;
                        }
                        if(testParamFlag(WindowParam.WINDOW_PARAM_REFLECT_VERTICAL_RESIZE_TO_PARENT))
                        {
                           var_23.height += 0 - 0;
                        }
                        var_31 = _loc8_;
                        var_23.update(this,new WindowNotifyEvent(WindowNotifyEvent.const_254,var_23,this));
                     }
                  }
                  break;
               case WindowNotifyEvent.const_386:
                  var_29.invalidate(this,var_22.union(var_64),WindowRedrawFlag.const_408);
                  if(param1 == this)
                  {
                     notifyChildren(new WindowNotifyEvent(WindowNotifyEvent.const_907,this,null));
                     if(var_23 != null)
                     {
                        var_23.update(this,new WindowNotifyEvent(WindowNotifyEvent.const_227,var_23,this));
                     }
                  }
                  break;
               case WindowNotifyEvent.const_319:
                  if(param1 == this)
                  {
                     notifyChildren(new WindowNotifyEvent(WindowNotifyEvent.const_507,this,null));
                     if(var_23 != null)
                     {
                        var_23.update(this,new WindowNotifyEvent(WindowNotifyEvent.const_208,var_23,this));
                     }
                  }
                  break;
               case WindowNotifyEvent.const_453:
                  var_29.invalidate(this,var_22,WindowRedrawFlag.const_905);
                  break;
               case WindowNotifyEvent.const_376:
                  _loc6_ = new Array();
                  groupChildrenWithTag(WindowController.INTERNAL_CHILD_TAG,_loc6_);
                  _loc7_ = uint(_loc6_.length);
                  while(--_loc7_ > -1)
                  {
                     WindowController(_loc6_[_loc7_]).style = var_89;
                  }
                  var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
                  break;
               case WindowNotifyEvent.const_374:
                  if(!(var_31 & 0))
                  {
                     if(!var_30)
                     {
                        setupGraphicsContext();
                        var_29.invalidate(this,var_22,WindowRedrawFlag.const_408);
                     }
                  }
                  else if(var_31 & 0)
                  {
                     if(var_30)
                     {
                        var_29.invalidate(this,var_22,WindowRedrawFlag.const_408);
                     }
                  }
                  break;
               case WindowNotifyEvent.const_387:
                  if(testParamFlag(WindowParam.const_155,WindowParam.const_131))
                  {
                     updateScaleRelativeToParent();
                  }
                  else if(testParamFlag(WindowParam.const_156,WindowParam.const_148))
                  {
                     updateScaleRelativeToParent();
                  }
                  var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
                  break;
               case WindowNotifyEvent.const_208:
                  activate();
                  break;
               case WindowNotifyEvent.const_395:
                  var_23.getRegionProperties(null,var_306);
                  updateScaleRelativeToParent();
                  break;
               case WindowNotifyEvent.const_289:
                  if(testParamFlag(WindowParam.const_62))
                  {
                     expandToAccommodateChild(this,WindowNotifyEvent(param2).related);
                  }
                  break;
               case WindowNotifyEvent.const_227:
                  if(testParamFlag(WindowParam.const_62))
                  {
                     expandToAccommodateChild(this,WindowNotifyEvent(param2).related);
                  }
                  break;
               case WindowNotifyEvent.const_693:
                  break;
               case WindowNotifyEvent.const_254:
                  if(testParamFlag(WindowParam.const_62))
                  {
                     expandToAccommodateChild(this,WindowNotifyEvent(param2).related);
                  }
            }
         }
         return true;
      }
      
      public function getGlobalRectangle(param1:Rectangle) : void
      {
         var _loc2_:Rectangle = var_22;
         if(var_23 != null)
         {
            var_23.getGlobalRectangle(param1);
            param1.x += _loc2_.x;
            param1.y += _loc2_.y;
         }
         else
         {
            param1.x = _loc2_.x;
            param1.y = _loc2_.y;
         }
         param1.width = _loc2_.width;
         param1.height = _loc2_.height;
      }
      
      public function focus() : Boolean
      {
         if(getStateFlag(WindowState.const_70))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_820,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_70,true);
         _loc1_.type = WindowNotifyEvent.const_908;
         update(this,_loc1_);
         return true;
      }
      
      public function get procedure() : Function
      {
         return var_600 != null ? var_600 : (var_23 != null ? var_23.procedure : nullEventProc);
      }
      
      public function maximize() : Boolean
      {
         if(var_46 & 0)
         {
            return false;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_980,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_61,true);
         _loc1_.type = WindowNotifyEvent.const_945;
         update(this,_loc1_);
         return true;
      }
      
      public function set rectangle(param1:Rectangle) : void
      {
         setRectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function validateGlobalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         var _loc3_:Point = new Point();
         getGlobalPosition(_loc3_);
         _loc3_.x = param1.x - _loc3_.x;
         _loc3_.y = param1.y - _loc3_.y;
         return testLocalPointHitAgainstAlpha(_loc3_,param2,var_721);
      }
      
      public function getGlobalPosition(param1:Point) : void
      {
         if(var_23 != null)
         {
            var_23.getGlobalPosition(param1);
            param1.x += var_22.x;
            param1.y += var_22.y;
         }
         else
         {
            param1.x = var_22.x;
            param1.y = var_22.y;
         }
      }
      
      public function getParamFlag(param1:uint) : Boolean
      {
         return (var_31 & param1) != 0;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 != var_353)
         {
            var_353 = param1;
            if(var_30)
            {
               var_30.visible = param1;
            }
            var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
         }
      }
      
      public function getStateFlag(param1:uint) : Boolean
      {
         return (var_46 & param1) != 0;
      }
      
      public function resolveVerticalScale() : Number
      {
         return 0 / 0;
      }
      
      public function set x(param1:int) : void
      {
         if(param1 != var_22.x)
         {
            setRectangle(param1,var_22.y,var_22.width,var_22.height);
         }
      }
      
      public function set y(param1:int) : void
      {
         if(param1 != var_22.y)
         {
            setRectangle(var_22.x,param1,var_22.width,var_22.height);
         }
      }
      
      public function activate() : Boolean
      {
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_918,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_87,true);
         _loc1_.type = WindowNotifyEvent.const_319;
         update(this,_loc1_);
         return true;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return !!_disposed ? false : Boolean(_events.hasEventListener(param1));
      }
      
      public function setGlobalPosition(param1:Point) : void
      {
         var _loc2_:Point = new Point();
         if(var_23 != null)
         {
            var_23.getGlobalPosition(_loc2_);
            _loc2_.x += var_22.x;
            _loc2_.y += var_22.y;
         }
         else
         {
            _loc2_.x = var_22.x;
            _loc2_.y = var_22.y;
         }
         x += param1.x - _loc2_.x;
         y += param1.y - _loc2_.y;
      }
      
      public function isCapableOfUsingSharedGraphicContext() : Boolean
      {
         return true;
      }
      
      public function removeChild(param1:IWindow) : IWindow
      {
         var _loc2_:WindowController = WindowController(param1);
         if(_children.removeChild(_loc2_) != null)
         {
            _loc2_.parent = null;
            if(_loc2_.hasGraphicsContext())
            {
               var_30.removeChildContext(_loc2_.getGraphicContext(true));
            }
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_693,this,param1));
            return param1;
         }
         return null;
      }
      
      public function disable() : Boolean
      {
         if(getStateFlag(WindowState.const_67))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_872,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_67,true);
         _loc1_.type = WindowNotifyEvent.const_509;
         update(this,_loc1_);
         return true;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = var_29.getDesktopWindow().mouseX;
         param1.y = var_29.getDesktopWindow().mouseY;
      }
      
      public function addChild(param1:IWindow) : IWindow
      {
         var _loc2_:WindowController = WindowController(param1);
         if(_loc2_.parent != null)
         {
            WindowController(_loc2_.parent).removeChild(_loc2_);
         }
         _children.addChild(_loc2_);
         _loc2_.parent = this;
         if(var_1015 || _loc2_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc2_.getGraphicContext(true).parent != var_30)
            {
               var_30.addChildContext(_loc2_.getGraphicContext(true));
            }
         }
         update(this,new WindowNotifyEvent(WindowNotifyEvent.const_289,this,param1));
         return param1;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         return !testParamFlag(WindowParam.const_32) ? getGraphicContext(true).fetchDrawBuffer() : (var_23 != null ? var_23.fetchDrawBuffer() : null);
      }
      
      public function getChildIndex(param1:IWindow) : int
      {
         return _children.getChildIndex(WindowController(param1));
      }
      
      public function setChildIndex(param1:IWindow, param2:int) : void
      {
         var _loc3_:WindowController = WindowController(param1);
         _children.setChildIndex(_loc3_,param2);
         if(_loc3_.hasGraphicsContext())
         {
            var_30.setChildContextIndex(_loc3_.getGraphicContext(true),getChildIndex(_loc3_));
         }
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function findParentByName(param1:String) : IWindow
      {
         if(_name == param1)
         {
            return this;
         }
         if(var_23 != null)
         {
            if(var_23.name == param1)
            {
               return var_23;
            }
            return var_23.findParentByName(param1);
         }
         return null;
      }
      
      public function setRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc7_:* = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         param4 = Math.max(var_83.minHeight,param4);
         param4 = Math.min(var_83.maxHeight,param4);
         param3 = Math.max(var_83.minWidth,param3);
         param3 = Math.min(var_83.maxWidth,param3);
         var _loc5_:Boolean = param1 != var_22.x || param2 != var_22.y;
         var _loc6_:Boolean = param3 != var_22.width || param4 != var_22.height;
         if(_loc6_ && !_loc5_)
         {
            _loc7_ = uint(var_31 & 0);
            if(_loc7_ == WindowParam.const_426)
            {
               param1 -= (param3 - 0) / 2;
               _loc5_ = true;
            }
            else if(_loc7_ == WindowParam.const_478)
            {
               param1 -= param3 - 0;
               _loc5_ = true;
            }
            _loc7_ = uint(var_31 & 0);
            if(_loc7_ == WindowParam.const_381)
            {
               param2 -= (param4 - 0) / 2;
               _loc5_ = true;
            }
            else if(_loc7_ == WindowParam.const_466)
            {
               param2 -= param4 - 0;
               _loc5_ = true;
            }
         }
         if(testParamFlag(WindowParam.const_78))
         {
            if(var_23 != null)
            {
               _loc9_ = var_23.rectangle;
               param1 = param1 < 0 ? 0 : int(param1);
               param2 = param2 < 0 ? 0 : int(param2);
               if(_loc5_)
               {
                  param1 -= param1 + param3 > _loc9_.width ? param1 + param3 - _loc9_.width : 0;
                  param2 -= param2 + param4 > _loc9_.height ? param2 + param4 - _loc9_.height : 0;
                  _loc5_ = param1 != var_22.x || param2 != var_22.y;
               }
               else
               {
                  param3 -= param1 + param3 > _loc9_.width ? param1 + param3 - _loc9_.width : 0;
                  param4 -= param2 + param4 > _loc9_.height ? param2 + param4 - _loc9_.height : 0;
                  _loc6_ = param3 != var_22.width || param4 != var_22.height;
               }
            }
         }
         if(_loc5_ || _loc6_)
         {
            if(_loc5_)
            {
               _loc10_ = new WindowNotifyEvent(WindowNotifyEvent.const_887,this,null,true);
               update(this,_loc10_);
               if(_loc10_.isWindowOperationPrevented())
               {
                  _loc5_ = false;
               }
            }
            if(_loc6_)
            {
               _loc10_ = new WindowNotifyEvent(WindowNotifyEvent.const_670,this,null,true);
               update(this,_loc10_);
               if(_loc10_.isWindowOperationPrevented())
               {
                  _loc6_ = false;
               }
            }
            if(_loc5_)
            {
               var_64.x = var_22.x;
               var_64.y = var_22.y;
               var_64.width = var_22.width;
               var_64.height = var_22.height;
               var_22.x = param1;
               var_22.y = param2;
            }
            if(_loc6_)
            {
               var_64.width = var_22.width;
               var_64.height = var_22.height;
               var_22.width = param3;
               var_22.height = param4;
            }
            if(_loc5_)
            {
               update(this,new WindowNotifyEvent(WindowNotifyEvent.const_386,this,null));
            }
            if(_loc6_)
            {
               update(this,new WindowNotifyEvent(WindowNotifyEvent.const_211,this,null));
            }
         }
      }
      
      public function set state(param1:uint) : void
      {
         if(param1 != var_46)
         {
            var_46 = param1;
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_453,this,null));
         }
      }
      
      public function lock() : Boolean
      {
         if(getStateFlag(WindowState.const_61))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_1248,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_61,true);
         _loc1_.type = WindowNotifyEvent.const_1256;
         update(this,_loc1_);
         return true;
      }
      
      protected function testLocalPointHitAgainstAlpha(param1:Point, param2:BitmapData, param3:uint) : Boolean
      {
         var _loc5_:* = null;
         var _loc4_:Boolean = false;
         if(true || true)
         {
            return false;
         }
         if(_drawable && var_721 > 0)
         {
            if(!testParamFlag(WindowParam.const_32))
            {
               if(param1.x <= var_22.width && param1.y <= var_22.height)
               {
                  _loc5_ = getGraphicContext(true).fetchDrawBuffer() as BitmapData;
                  if(_loc5_ != null)
                  {
                     _loc4_ = _loc5_.hitTest(var_1488,param3,param1);
                  }
               }
            }
            else
            {
               _loc4_ = param2 != null ? Boolean(param2.hitTest(var_1488,param3,param1)) : false;
            }
         }
         else if(param1.x >= 0 && param1.x < var_22.width)
         {
            if(param1.y >= 0 && param1.y < var_22.height)
            {
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function get properties() : Array
      {
         return new Array();
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
         if(param1 == null)
         {
            param1 = var_22;
         }
         var_29.invalidate(this,param1,WindowRedrawFlag.const_71);
      }
      
      private function nullEventProc(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      public function convertPointFromLocalToGlobalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(var_23 == null)
         {
            param1.x = var_22.x;
            param1.y = var_22.y;
         }
         else
         {
            var_23.getGlobalPosition(param1);
            param1.x += var_22.x;
            param1.y += var_22.y;
         }
         param1.x += _loc2_;
         param1.y += _loc3_;
      }
      
      public function getDrawRegion(param1:Rectangle) : void
      {
         if(!testParamFlag(WindowParam.const_32))
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = var_22.width;
            param1.height = var_22.height;
         }
         else if(var_23 != null)
         {
            IWindow(var_23).getDrawRegion(param1);
            param1.x += var_22.x;
            param1.y += var_22.y;
            param1.width = var_22.width;
            param1.height = var_22.height;
         }
         else
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = 0;
            param1.height = 0;
         }
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         setRectangle(var_22.x,var_22.y,var_22.width + param1,var_22.height + param2);
      }
      
      public function getLocalRectangle(param1:Rectangle) : void
      {
         param1.x = var_22.x;
         param1.y = var_22.y;
         param1.width = var_22.width;
         param1.height = var_22.height;
      }
      
      public function setParamFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = var_31;
         var _loc4_:*;
         var_31 = !!param2 ? (_loc4_ = var_31 | param1, var_31 |= param1, uint(_loc4_)) : (_loc4_ = var_31 & ~param1, var_31 &= ~param1, uint(_loc4_));
         if(var_31 != _loc3_)
         {
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_374,this,null));
         }
      }
      
      public function expandToAccommodateChildren() : void
      {
         var _loc1_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:uint = numChildren;
         var _loc9_:Boolean = getParamFlag(WindowParam.const_62);
         _loc1_ = 0;
         while(_loc1_ < _loc8_)
         {
            _loc6_ = getChildAt(_loc1_).rectangle;
            if(_loc6_.x < _loc2_)
            {
               _loc4_ -= _loc6_.x - _loc2_;
               _loc2_ = _loc6_.x;
               _loc7_ = true;
            }
            if(_loc6_.right > _loc4_)
            {
               _loc4_ = _loc6_.x + _loc6_.width;
               _loc7_ = true;
            }
            if(_loc6_.y < _loc3_)
            {
               _loc5_ -= _loc6_.y - _loc3_;
               _loc3_ = _loc6_.y;
               _loc7_ = true;
            }
            if(_loc6_.bottom > _loc5_)
            {
               _loc5_ = _loc6_.y + _loc6_.height;
               _loc7_ = true;
            }
            _loc1_++;
         }
         if(_loc7_)
         {
            if(_loc9_)
            {
               setParamFlag(WindowParam.const_62,false);
            }
            setRectangle(var_22.x + _loc2_,var_22.y + _loc3_,_loc4_,_loc5_);
            _loc1_ = 0;
            while(_loc1_ < _loc8_)
            {
               IWindow(_children.getChildAt(_loc1_)).offset(-_loc2_,-_loc3_);
               _loc1_++;
            }
            if(_loc9_)
            {
               setParamFlag(WindowParam.const_62,true);
            }
         }
      }
      
      public function removeChildAt(param1:int) : IWindow
      {
         return removeChild(getChildAt(param1));
      }
      
      public function set parent(param1:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1 == this)
         {
            throw new Error("Attempted to assign self as parent!");
         }
         if(param1 != null && param1.context != var_29)
         {
            var_29 = WindowContext(param1.context);
            _loc3_ = 0;
            while(_loc3_ < numChildren)
            {
               WindowController(_children.getChildAt(_loc3_)).parent = this;
               _loc3_++;
            }
         }
         var _loc2_:IWindow = var_23;
         if(var_23 != param1)
         {
            if(var_23 != null)
            {
               var_23.removeChild(this);
            }
            var_23 = WindowController(param1);
            if(var_23 != null)
            {
               var_306 = var_23.rectangle.clone();
               var_64.x = var_22.x;
               var_64.y = var_22.y;
               var_64.width = var_22.width;
               var_64.height = var_22.height;
               update(this,new WindowNotifyEvent(WindowNotifyEvent.const_387,this,var_23));
            }
            else
            {
               var_306.x = 0;
               var_306.y = 0;
               var_306.width = 0;
               var_306.height = 0;
               update(this,new WindowNotifyEvent(WindowNotifyEvent.const_860,this,_loc2_));
            }
         }
      }
      
      public function clone() : IWindow
      {
         var _loc1_:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var _loc2_:WindowController = new _loc1_(_name,_type,var_89,var_31,var_29,var_22,null,var_600,properties,var_602.concat(),_id) as WindowController;
         _loc2_.var_721 = var_721;
         _loc2_._drawable = _drawable;
         _loc2_.var_1328 = var_1328;
         _loc2_.var_306 = var_306.clone();
         _loc2_.var_22 = var_22.clone();
         _loc2_.var_364 = var_364.clone();
         _loc2_.var_64 = var_64.clone();
         _loc2_.var_151 = !!var_151 ? var_151.clone() : null;
         _loc2_.var_152 = !!var_152 ? var_152.clone() : null;
         _loc2_.var_83 = !!var_83 ? var_83.clone(_loc2_) : null;
         _loc2_.var_29 = var_29;
         _loc2_.var_601 = var_601;
         _loc2_.var_1331 = var_1331;
         _loc2_.var_1067 = var_1067;
         _loc2_.var_353 = var_353;
         _loc2_.var_410 = var_410;
         _loc2_.var_31 = var_31;
         _loc2_.var_46 = var_46;
         _loc2_._name = _name;
         _loc2_._id = _id;
         _loc2_.caption = var_318;
         _loc2_.background = var_5;
         cloneChildWindows(_loc2_);
         return _loc2_;
      }
      
      public function set style(param1:uint) : void
      {
         if(param1 != var_89)
         {
            var_89 = param1;
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_376,this,null));
         }
      }
      
      public function setStateFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = var_46;
         var _loc4_:*;
         var_46 = !!param2 ? (_loc4_ = var_46 | param1, var_46 |= param1, uint(_loc4_)) : (_loc4_ = var_46 & ~param1, var_46 &= ~param1, uint(_loc4_));
         if(var_46 != _loc3_)
         {
            update(this,new WindowNotifyEvent(WindowNotifyEvent.const_453,this,null));
         }
      }
      
      public function unlock() : Boolean
      {
         if(!getStateFlag(WindowState.const_61))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_1341,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_61,false);
         _loc1_.type = WindowNotifyEvent.const_1241;
         update(this,_loc1_);
         return true;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(!_disposed)
         {
            _events.removeEventListener(param1,param2,param3);
         }
      }
      
      public function enable() : Boolean
      {
         if(!getStateFlag(WindowState.const_67))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_896,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_67,false);
         _loc1_.type = WindowNotifyEvent.const_555;
         update(this,_loc1_);
         return true;
      }
      
      public function set clipping(param1:Boolean) : void
      {
         var_1067 = param1;
         update(this,new WindowNotifyEvent(WindowNotifyEvent.const_374,this,null));
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array, param3:Boolean = false) : uint
      {
         var _loc5_:int = 0;
         var _loc4_:uint = _children.groupChildrenWithTag(param1,param2);
         if(param3)
         {
            _loc5_ = 0;
            while(_loc5_ < _children.numChildren)
            {
               _loc4_ += WindowController(_children.getChildAt(_loc5_)).groupChildrenWithTag(param1,param2,param3);
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return !!_disposed ? false : Boolean(_events.willTrigger(param1));
      }
      
      public function hitTestGlobalRectangle(param1:Rectangle) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.intersects(param1);
      }
      
      public function hitTestLocalPoint(param1:Point) : Boolean
      {
         return var_22.containsPoint(param1);
      }
      
      public function set width(param1:int) : void
      {
         if(param1 != var_22.width)
         {
            setRectangle(var_22.x,var_22.y,param1,var_22.height);
         }
      }
      
      protected function forwardMouseEvent(param1:MouseEvent) : WindowEvent
      {
         var _loc6_:Boolean = false;
         var _loc2_:String = "null";
         var _loc5_:Point = new Point(param1.stageX,param1.stageY);
         convertPointFromGlobalToLocalSpace(_loc5_);
         _loc6_ = _loc5_.x > -1 && _loc5_.y > -1 && _loc5_.x < var_22.width && _loc5_.y < var_22.height;
         switch(param1.type)
         {
            case MouseEvent.MOUSE_OVER:
               _loc2_ = "null";
               break;
            case MouseEvent.MOUSE_MOVE:
               _loc2_ = "null";
               break;
            case MouseEvent.MOUSE_OUT:
               _loc2_ = "null";
               break;
            case MouseEvent.ROLL_OUT:
               _loc2_ = "null";
               break;
            case MouseEvent.ROLL_OVER:
               _loc2_ = "null";
               break;
            case MouseEvent.CLICK:
               _loc2_ = "null";
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc2_ = "null";
               break;
            case MouseEvent.MOUSE_DOWN:
               _loc2_ = "null";
               break;
            case MouseEvent.MOUSE_UP:
               _loc2_ = !!_loc6_ ? "null" : WindowMouseEvent.const_597;
               break;
            case MouseEvent.MOUSE_WHEEL:
               _loc2_ = "null";
         }
         var _loc7_:WindowEvent = new WindowMouseEvent(_loc2_,this,null,_loc5_.x,_loc5_.y,param1.stageX,param1.stageY,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown,param1.delta,false,true);
         procedure(_loc7_,this);
         if(!_loc7_.isWindowOperationPrevented())
         {
            dispatchEvent(_loc7_);
         }
         return _loc7_;
      }
      
      public function releaseGraphicsContext() : void
      {
         var_1015 = false;
         if(!var_30)
         {
         }
      }
      
      public function getChildUnderPoint(param1:Point) : IWindow
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         if(var_353)
         {
            _loc2_ = new Rectangle();
            getMouseRegion(_loc2_);
            _loc3_ = _loc2_.containsPoint(param1);
            _loc5_ = uint(numChildren);
            if(_loc3_)
            {
               while(_loc5_ > 0)
               {
                  _loc4_ = WindowController(_children.getChildAt(_loc5_ - 1)).getChildUnderPoint(param1);
                  if(_loc4_ != null)
                  {
                     return _loc4_;
                  }
                  _loc5_--;
               }
            }
            if(validateGlobalPointIntersection(param1,null))
            {
               return this;
            }
         }
         return null;
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array, param3:Boolean = false) : uint
      {
         var _loc5_:int = 0;
         var _loc4_:uint = _children.groupChildrenWithID(param1,param2);
         if(param3)
         {
            _loc5_ = 0;
            while(_loc5_ < _children.numChildren)
            {
               _loc4_ += WindowController(_children.getChildAt(_loc5_)).groupChildrenWithID(param1,param2,param3);
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public function get numChildren() : int
      {
         return _children.numChildren;
      }
      
      public function set procedure(param1:Function) : void
      {
         var_600 = param1;
      }
      
      public function get host() : IWindow
      {
         return var_23 == desktop ? {} : var_23.host;
      }
      
      public function buildFromXML(param1:XML, param2:Map = null) : Boolean
      {
         return var_29.getWindowParser().parseAndConstruct(param1,this,param2) != null;
      }
      
      public function convertPointFromGlobalToLocalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(var_23 == null)
         {
            param1.x = var_22.x;
            param1.y = var_22.y;
         }
         else
         {
            var_23.getGlobalPosition(param1);
            param1.x += var_22.x;
            param1.y += var_22.y;
         }
         param1.x = _loc2_ - param1.x;
         param1.y = _loc3_ - param1.y;
      }
      
      protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < _children.numChildren)
         {
            _loc2_ = WindowController(_children.getChildAt(_loc3_));
            if(_loc2_.tags.indexOf(WindowController.EXCLUDE_CHILD_TAG) == -1)
            {
               param1.addChild(_loc2_.clone());
            }
            _loc3_++;
         }
      }
      
      public function hitTestGlobalPoint(param1:Point) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.containsPoint(param1);
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         getGlobalPosition(param1);
         param1.x = var_29.getDesktopWindow().mouseX - param1.x;
         param1.y = var_29.getDesktopWindow().mouseY - param1.y;
      }
      
      public function setRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null) : void
      {
         if(param3 != null)
         {
            if(param3.width < 0 || param3.height < 0)
            {
               throw new Error("Invalid rectangle; maximized size can\'t be less than zero!");
            }
            if(var_152 == null)
            {
               var_152 = new Rectangle();
            }
            var_152.x = param3.x;
            var_152.y = param3.y;
            var_152.width = param3.width;
            var_152.height = param3.height;
         }
         if(param2 != null)
         {
            if(param2.width < 0 || param2.height < 0)
            {
               throw new Error("Invalid rectangle; minimized size can\'t be less than zero!");
            }
            if(var_151 == null)
            {
               var_151 = new Rectangle();
            }
            var_151.x = param2.x;
            var_151.y = param2.y;
            var_151.width = param2.width;
            var_151.height = param2.height;
         }
         if(param3.width < param2.width || param3.height < param2.height)
         {
            param3.width = param2.width;
            param3.height = param2.height;
            throw new Error("Maximized rectangle can\'t be smaller than minimized rectangle!");
         }
         if(param1 != null)
         {
            setRectangle(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      public function set alphaTreshold(param1:uint) : void
      {
         var_721 = param1 > 255 ? 255 : uint(param1);
      }
      
      public function groupChildrenUnderPoint(param1:Point, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(var_353)
         {
            _loc3_ = 0;
            if(var_22.containsPoint(param1))
            {
               param2.push(this);
               param1.offset(0,0);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  WindowController(_children.getChildAt(_loc4_)).groupChildrenUnderPoint(param1,param2);
                  _loc4_++;
               }
               param1.offset(var_22.x,var_22.y);
            }
            else if(!var_1067)
            {
               param1.offset(0,0);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  WindowController(_children.getChildAt(_loc4_)).groupChildrenUnderPoint(param1,param2);
                  _loc4_++;
               }
               param1.offset(var_22.x,var_22.y);
            }
         }
      }
      
      public function set caption(param1:String) : void
      {
         param1 = !!param1 ? param1 : "";
         if(param1 != caption)
         {
            var_318 = param1;
            var_29.invalidate(this,var_22,WindowRedrawFlag.const_71);
         }
      }
      
      public function unfocus() : Boolean
      {
         if(!getStateFlag(WindowState.const_70))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_958,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         setStateFlag(WindowState.const_70,false);
         _loc1_.type = WindowNotifyEvent.const_960;
         update(this,_loc1_);
         return true;
      }
      
      public function resolve() : uint
      {
         return 0;
      }
      
      protected function forwardNormalEvent(param1:Event) : WindowEvent
      {
         var _loc2_:String = "null";
         switch(param1.type)
         {
            case Event.CHANGE:
               _loc2_ = "null";
         }
         var _loc4_:WindowEvent = new WindowEvent(_loc2_,this,null,false,true);
         procedure(_loc4_,this);
         if(!_loc4_.isWindowOperationPrevented())
         {
            dispatchEvent(_loc4_);
         }
         return _loc4_;
      }
      
      public function get alphaTreshold() : uint
      {
         return var_721;
      }
      
      public function set filters(param1:Array) : void
      {
         if(hasGraphicsContext())
         {
            getGraphicContext(true).filters = param1;
         }
      }
      
      public function close() : Boolean
      {
         if(!getStateFlag(WindowState.const_81))
         {
            return true;
         }
         var _loc1_:WindowNotifyEvent = new WindowNotifyEvent(WindowNotifyEvent.const_938,this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            return false;
         }
         visible = false;
         _loc1_.type = WindowNotifyEvent.const_815;
         update(this,_loc1_);
         return true;
      }
      
      public function resolveHorizontalScale() : Number
      {
         return 0 / 0;
      }
      
      public function get filters() : Array
      {
         return !!hasGraphicsContext() ? getGraphicContext(true).filters : [];
      }
      
      public function childRectToClippedDrawRegion(param1:Rectangle, param2:Rectangle) : Boolean
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = false;
         if(testParamFlag(WindowParam.const_32))
         {
            param1.offset(var_22.x,var_22.y);
            if(clipping)
            {
               _loc4_ = param1.intersection(var_22);
               if(param1.x < var_22.x)
               {
                  param2.x -= param1.x - 0;
                  param1.x = var_22.x;
                  _loc3_ = true;
               }
               if(param1.y < var_22.y)
               {
                  param2.y -= param1.y - 0;
                  param1.y = var_22.y;
                  _loc3_ = true;
               }
               if(param1.width != _loc4_.width)
               {
                  param1.width = _loc4_.width;
                  _loc3_ = true;
               }
               if(param1.height != _loc4_.height)
               {
                  param1.height = _loc4_.height;
                  _loc3_ = true;
               }
               param2.width = _loc4_.width;
               param2.height = _loc4_.height;
            }
            if(var_23 != null)
            {
               _loc3_ = WindowController(var_23).childRectToClippedDrawRegion(param1,param2) || _loc3_;
            }
         }
         else if(clipping)
         {
            if(param1.x < 0)
            {
               param2.x -= param1.x;
               param1.x = 0;
               _loc3_ = true;
            }
            if(param1.y < 0)
            {
               param2.y -= param1.y;
               param1.y = 0;
               _loc3_ = true;
            }
            if(var_22.width < param1.right)
            {
               param2.right -= param1.right - 0;
               param1.right = param1.width;
               _loc3_ = true;
            }
            if(var_22.height < param1.bottom)
            {
               param2.bottom -= param1.bottom - 0;
               param1.bottom = var_22.height;
               _loc3_ = true;
            }
         }
         return !!_loc3_ ? param2.width > 0 && param2.height > 0 : true;
      }
      
      public function getLocalPosition(param1:Point) : void
      {
         param1.x = var_22.x;
         param1.y = var_22.y;
      }
   }
}
