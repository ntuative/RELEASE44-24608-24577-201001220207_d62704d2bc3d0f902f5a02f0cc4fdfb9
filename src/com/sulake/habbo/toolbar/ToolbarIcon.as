package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.enum.WindowType;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ToolbarIcon
   {
       
      
      private var var_456:ToolbarIconGroup;
      
      private var var_954:Boolean = false;
      
      private var var_1794:String;
      
      private var var_860:Number;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_956:String = "-1";
      
      private var _window:IBitmapWrapperWindow;
      
      private var var_46:String = "-1";
      
      private var var_107:IRegionWindow;
      
      private var _bitmapData:BitmapData;
      
      private var var_639:String;
      
      private var var_1795:int;
      
      private var var_638:Timer;
      
      private var var_1408:Array;
      
      private var var_955:ToolbarIconBouncer;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _events:IEventDispatcher;
      
      private var var_2247:Array;
      
      private var var_259:ToolbarBarMenuAnimator;
      
      private var var_379:ToolbarIconAnimator;
      
      private var var_532:Array;
      
      private var var_791:Array;
      
      private var var_792:String = "-1";
      
      private var var_2318:Boolean = true;
      
      private var var_953:Array;
      
      private var var_1143:Timer;
      
      private var var_1796:int;
      
      private var var_94:Number = 0;
      
      private var _y:Number = 0;
      
      public function ToolbarIcon(param1:ToolbarIconGroup, param2:IHabboWindowManager, param3:IAssetLibrary, param4:String, param5:IEventDispatcher, param6:ToolbarBarMenuAnimator)
      {
         var_532 = new Array();
         var_791 = new Array();
         var_2247 = new Array();
         var_955 = new ToolbarIconBouncer(0.8,1);
         super();
         var_456 = param1;
         _windowManager = param2;
         _assetLibrary = param3;
         var_639 = param4;
         _events = param5;
         var_259 = param6;
         var_1143 = new Timer(40,40);
         var_1143.addEventListener(TimerEvent.TIMER,updateBouncer);
         var_107 = param2.createWindow("TOOLBAR_ICON_" + param4 + "_REGION","",WindowType.const_419,HabboWindowStyle.const_40,HabboWindowParam.const_39,new Rectangle(0,0,1,1),onMouseEvent) as IRegionWindow;
         var_107.background = true;
         var_107.alphaTreshold = 0;
         var_107.visible = false;
         _window = IBitmapWrapperWindow(param2.createWindow("TOOLBAR_ICON_" + param4,"",HabboWindowType.BITMAP_WRAPPER,HabboWindowStyle.const_40,HabboWindowParam.const_40,new Rectangle(0,0,1,1),onMouseEvent,0));
         var_107.addChild(_window);
         _window.addEventListener(WindowEvent.const_44,onWindowResized);
      }
      
      private function getStateObject(param1:String) : StateItem
      {
         return var_1408[var_953.indexOf(param1)];
      }
      
      public function get windowOffsetFromIcon() : Number
      {
         return var_1796;
      }
      
      public function get iconId() : String
      {
         return var_639;
      }
      
      private function onWindowResized(param1:WindowEvent) : void
      {
         updateRegion();
      }
      
      public function changePosition(param1:Number) : void
      {
         var_860 = param1;
         updateRegion();
      }
      
      public function setIcon(param1:Boolean = true) : void
      {
         exists = param1;
         setAnimator();
      }
      
      public function set state(param1:String) : void
      {
         var_46 = param1;
         exists = true;
         setAnimator();
         setTooltip();
      }
      
      private function updateRegion() : void
      {
         if(var_107 == null || _window == null)
         {
            return;
         }
         var_107.width = _window.width;
         var_107.height = _window.height;
         var _loc1_:Boolean = false;
         if(_loc1_)
         {
            var_94 = (0 - 0) / 2;
            _y = var_860 + (0 - 0) / 2;
         }
         else
         {
            var_94 = var_860 + (0 - 0) / 2;
            _y = (0 - 0) / 2;
         }
         var_107.x = var_94;
         var_107.y = _y;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_107 != null)
         {
            var_107.dispose();
            var_107 = null;
         }
         var_532 = null;
         var_791 = null;
         exists = false;
         _windowManager = null;
         _events = null;
         var_259 = null;
         var_379 = null;
         _bitmapData = null;
      }
      
      public function dockMenu(param1:String, param2:Array = null, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         if(var_532.indexOf(param1) < 0)
         {
            var_532.push(param1);
            _loc4_ = new MenuSettingsItem(param1,param2,param3);
            var_791.push(_loc4_);
         }
      }
      
      private function onMouseEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         if(!var_954)
         {
            return;
         }
         var _loc3_:StateItem = getCurrentStateObject();
         switch(param1.type)
         {
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
               if(var_259)
               {
                  var_259.repositionWindow(var_639,true);
               }
               if(_events != null)
               {
                  _loc4_ = new HabboToolbarEvent(HabboToolbarEvent.const_60);
                  _loc4_.iconId = var_639;
                  _events.dispatchEvent(_loc4_);
               }
               break;
            case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
               if(false)
               {
                  if(_loc3_.hasStateOver)
                  {
                     state = _loc3_.stateOver;
                  }
                  else
                  {
                     state = var_956;
                  }
               }
               break;
            case WindowMouseEvent.const_29:
               if(false)
               {
                  if(_loc3_.hasDefaultState)
                  {
                     state = _loc3_.defaultState;
                  }
                  else
                  {
                     state = var_792;
                  }
               }
         }
      }
      
      public function docksMenu(param1:String) : Boolean
      {
         return var_532.indexOf(param1) > -1;
      }
      
      public function menuLockedToIcon(param1:String) : Boolean
      {
         if(!docksMenu(param1))
         {
            return false;
         }
         var _loc2_:MenuSettingsItem = var_791[var_532.indexOf(param1)];
         return _loc2_.lockToIcon;
      }
      
      public function set exists(param1:Boolean) : void
      {
         var_954 = param1;
         if(var_107 != null)
         {
            var_107.visible = var_954;
         }
      }
      
      private function setTooltip() : void
      {
         if(var_107 == null)
         {
            return;
         }
         var _loc1_:StateItem = getCurrentStateObject();
         if(_loc1_ != null && _loc1_.tooltip != null)
         {
            var_107.toolTipCaption = "${toolbar.icon.tooltip." + _loc1_.tooltip + "}";
         }
         else
         {
            var_107.toolTipCaption = "${toolbar.icon.tooltip." + var_1794.toLowerCase() + "}";
         }
         var_107.toolTipDelay = 100;
      }
      
      public function animateWindowIn(param1:String, param2:IWindowContainer, param3:Number, param4:String, param5:Point) : void
      {
         if(var_259 != null)
         {
            var_259.animateWindowIn(this,param1,param2,var_639,param3,param4,getMenuYieldList(param1));
         }
      }
      
      private function updateAnimator(param1:Event) : void
      {
         if(var_379 != null && _window != null)
         {
            var_379.update(_window);
            if(var_379.hasNextState())
            {
               state = var_379.nextState;
            }
         }
      }
      
      public function defineFromXML(param1:XML) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var_1408 = new Array();
         var_953 = new Array();
         var_1794 = param1.@id;
         var_1796 = int(param1.@window_offset_from_icon);
         var_1795 = int(param1.@window_margin);
         var _loc2_:XMLList = param1.elements("state");
         if(_loc2_.length() > 0)
         {
            if(param1.attribute("state_over").length() > 0)
            {
               var_956 = param1.@state_over;
            }
            if(param1.attribute("state_default").length() > 0)
            {
               var_792 = param1.@state_default;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length())
            {
               _loc4_ = _loc2_[_loc3_];
               _loc5_ = new StateItem(_loc4_,param1.@id.toLowerCase());
               var_953.push(_loc5_.id);
               var_1408.push(_loc5_);
               if(_loc3_ == 0)
               {
                  if(var_956 == "-1")
                  {
                     var_956 = _loc5_.id;
                  }
                  if(var_792 == "-1")
                  {
                     var_792 = _loc5_.id;
                  }
               }
               _loc3_++;
            }
         }
         var_46 = var_792;
      }
      
      public function setIconBitmapData(param1:BitmapData = null) : void
      {
         exists = true;
         _bitmapData = param1;
         setAnimator();
      }
      
      public function hideWindow(param1:String, param2:IWindowContainer, param3:Number, param4:String) : void
      {
         if(var_259 != null)
         {
            var_259.hideWindow(param1,param2,var_639,param3);
         }
      }
      
      public function positionWindow(param1:String, param2:IWindowContainer, param3:Number, param4:String) : void
      {
         if(var_259 != null)
         {
            var_259.positionWindow(this,param1,param2,var_639,param3,getMenuYieldList(param1));
         }
      }
      
      public function animateWindowOut(param1:String, param2:IWindowContainer, param3:String) : void
      {
         if(var_259 != null)
         {
            var_259.animateWindowOut(this,param1,param2,param3);
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get exists() : Boolean
      {
         return var_954;
      }
      
      private function updateBouncer(param1:Event) : void
      {
         if(var_955 != null && _window != null)
         {
            var_955.update();
            _window.y = var_955.location;
         }
      }
      
      private function setAnimator() : void
      {
         if(var_638 != null)
         {
            var_638.stop();
            var_638 = null;
         }
         var _loc1_:StateItem = getCurrentStateObject();
         if(_loc1_ != null && var_954)
         {
            if(_loc1_.frames == null)
            {
               return;
            }
            var_379 = new ToolbarIconAnimator(_loc1_,_assetLibrary,_window,var_94,_y,_bitmapData);
            if(false)
            {
               var_638 = new Timer(_loc1_.timer);
               var_638.addEventListener(TimerEvent.TIMER,updateAnimator);
               var_638.start();
            }
            if(_loc1_.bounce)
            {
               var_955.reset(-7);
               var_1143.reset();
               var_1143.start();
            }
         }
         else
         {
            var_379 = null;
            _window.bitmap = null;
         }
      }
      
      public function get windowMargin() : Number
      {
         return var_1795 + var_456.windowMargin;
      }
      
      private function getCurrentStateObject() : StateItem
      {
         return getStateObject(var_46);
      }
      
      public function get window() : IWindow
      {
         return var_107;
      }
      
      public function get x() : Number
      {
         return var_94;
      }
      
      private function getMenuYieldList(param1:String) : Array
      {
         if(!docksMenu(param1))
         {
            return null;
         }
         var _loc2_:MenuSettingsItem = var_791[var_532.indexOf(param1)];
         return _loc2_.yieldList;
      }
      
      public function get group() : ToolbarIconGroup
      {
         return var_456;
      }
   }
}
