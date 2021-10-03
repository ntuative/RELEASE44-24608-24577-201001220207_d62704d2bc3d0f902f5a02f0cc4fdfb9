package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public class ToolbarIconGroup
   {
       
      
      private var var_313:Array;
      
      private var var_860:Number;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_508:String;
      
      private var var_43:IWindowContainer;
      
      private var var_1795:int = 5;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _events:IEventDispatcher;
      
      private var var_702:Array;
      
      private var var_2162:Number;
      
      private var var_379:ToolbarBarMenuAnimator;
      
      private var var_1292:Array;
      
      private var var_150:Number;
      
      private var var_2161:XML;
      
      private var var_2160:int;
      
      private var var_1291:Number;
      
      private var var_1290:Array;
      
      public function ToolbarIconGroup(param1:IHabboWindowManager, param2:IAssetLibrary, param3:int, param4:IEventDispatcher, param5:IWindowContainer, param6:ToolbarBarMenuAnimator, param7:Number)
      {
         var_313 = new Array();
         var_702 = new Array();
         var_1292 = new Array();
         var_1290 = new Array();
         super();
         _windowManager = param1;
         _assetLibrary = param2;
         var_43 = param5;
         _events = param4;
         var_379 = param6;
         var_150 = param7;
      }
      
      public function get size() : Number
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_313.length)
         {
            if(var_313[_loc2_].exists)
            {
               _loc1_ += var_1291;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function setIcon(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         _loc3_ = getIconById(param1);
         if(_loc3_ != null)
         {
            _loc3_.setIcon(param2);
            alignItems();
         }
      }
      
      public function acceptsIcon(param1:String) : Boolean
      {
         return var_1290.indexOf(param1) > -1;
      }
      
      public function get iconCount() : int
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         while(_loc2_ < var_313.length)
         {
            if(var_313[_loc2_].exists)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set windowBottomMargin(param1:int) : void
      {
         var_2160 = param1;
      }
      
      public function get iconSize() : Number
      {
         return var_1291;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         while(false)
         {
            var_702.shift();
            _loc1_ = var_313.shift();
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      public function set orientation(param1:String) : void
      {
         var_508 = param1;
      }
      
      public function getIconByMenuId(param1:String) : ToolbarIcon
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < var_313.length)
         {
            _loc2_ = var_313[_loc3_];
            if(_loc2_ != null)
            {
               if(_loc2_.docksMenu(param1))
               {
                  return _loc2_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function set iconSize(param1:Number) : void
      {
         var_1291 = param1;
      }
      
      public function setContent(param1:String, param2:BitmapData) : void
      {
         var _loc3_:* = null;
         _loc3_ = getIconById(param1);
         if(_loc3_ != null)
         {
            _loc3_.setIconBitmapData(param2);
            alignItems();
         }
      }
      
      public function containsIcon(param1:String) : Boolean
      {
         return var_702.indexOf(param1) > -1;
      }
      
      public function get toolbarUsableWidth() : Number
      {
         return var_150;
      }
      
      private function alignItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(_loc4_ < var_1292.length)
         {
            _loc2_ = var_702.indexOf(var_1292[_loc4_]);
            if(_loc2_ > -1)
            {
               _loc1_ = var_313[_loc2_];
               if(_loc1_.exists)
               {
                  _loc1_.changePosition(var_860 + _loc3_);
                  _loc3_ += var_1291;
               }
            }
            _loc4_++;
         }
      }
      
      public function get windowMargin() : int
      {
         return var_1795;
      }
      
      public function get windowBottomMargin() : int
      {
         return var_2160;
      }
      
      private function createIconObject(param1:String) : ToolbarIcon
      {
         var _loc2_:* = null;
         _loc2_ = getIconById(param1);
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = new ToolbarIcon(this,_windowManager,_assetLibrary,param1,_events,var_379);
         var_43.addChild(_loc2_.window);
         var_702.push(param1);
         var_313.push(_loc2_);
         return _loc2_;
      }
      
      public function addContentIndexFromXmlList(param1:XML) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var_2161 = param1;
         _loc4_ = param1.elements("icon");
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.length())
         {
            _loc8_ = _loc4_[_loc7_];
            _loc2_ = "null";
            if(_loc2_ != null)
            {
               if(!containsIcon(_loc2_))
               {
                  _loc6_ = createIconObject(_loc2_);
                  if(_loc6_ == null)
                  {
                     return false;
                  }
                  _loc6_.defineFromXML(_loc8_);
                  var_1292.push(_loc2_);
                  _loc5_ = _loc8_.elements("dock");
                  if(_loc5_.length() > 0)
                  {
                     _loc9_ = 0;
                     while(_loc9_ < _loc5_.length())
                     {
                        _loc3_ = "null";
                        var_1290.push(_loc3_);
                        _loc6_.dockMenu(_loc3_,getMenuYieldList(_loc3_),_loc5_[_loc9_].@locktoicon == "true");
                        _loc9_++;
                     }
                  }
                  else
                  {
                     var_1290.push(_loc2_);
                     if(_loc8_.elements("nodock").length() == 0)
                     {
                        _loc6_.dockMenu(_loc2_);
                     }
                  }
               }
            }
            _loc7_++;
         }
         return true;
      }
      
      public function removeContent(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = var_702.indexOf(param1);
         if(_loc2_ > -1)
         {
            _loc3_ = getIconById(param1);
            if(_loc3_ != null)
            {
               _loc3_.setIcon(false);
            }
         }
      }
      
      public function get orientation() : String
      {
         return var_508;
      }
      
      public function set position(param1:Number) : void
      {
         var_860 = param1;
         alignItems();
      }
      
      public function getIconById(param1:String) : ToolbarIcon
      {
         if(!containsIcon(param1))
         {
            return null;
         }
         return var_313[var_702.indexOf(param1)];
      }
      
      public function set defaultIconSize(param1:Number) : void
      {
         var_2162 = param1;
      }
      
      public function get defaultIconSize() : Number
      {
         return var_2162;
      }
      
      public function set windowMargin(param1:int) : void
      {
         var_1795 = param1;
      }
      
      public function getMenuYieldList(param1:String) : Array
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:XMLList = var_2161.elements("menu");
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length())
         {
            if(HabboToolbarIconEnum[_loc3_[_loc5_].@id] == param1)
            {
               _loc4_ = _loc3_[_loc5_].elements("yield");
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length())
               {
                  _loc2_.push(HabboToolbarIconEnum[_loc4_[_loc6_].@id]);
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
