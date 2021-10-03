package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowStyle;
   import com.sulake.core.window.enum.WindowType;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowNotifyEvent;
   import com.sulake.core.window.graphics.WindowRedrawFlag;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.Iterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ItemListController extends WindowController implements IItemListWindow
   {
      
      protected static const const_1012:String = "resize_on_item_update";
      
      protected static const const_1011:String = "spacing";
      
      protected static const const_1381:Boolean = false;
      
      protected static const DEF_SPACING:int = 0;
      
      protected static const const_1013:String = "scale_to_fit_items";
      
      protected static const DEF_RESIZE_ON_ITEM_UPDATE:Boolean = false;
      
      protected static const const_1380:Boolean = true;
      
      protected static const const_1010:String = "auto_arrange_items";
       
      
      protected var _container:IWindowContainer;
      
      protected var _spacing:int = 0;
      
      protected var var_76:Number;
      
      protected var var_2294:Number = 0;
      
      protected var var_514:Boolean = false;
      
      protected var var_2293:Number = 0;
      
      protected var var_516:Number;
      
      protected var var_1069:Boolean = false;
      
      protected var var_515:Number;
      
      protected var var_188:Boolean = false;
      
      protected var var_98:Number;
      
      protected var var_1333:Boolean = false;
      
      protected var _horizontal:Boolean = false;
      
      protected var var_722:Boolean = true;
      
      public function ItemListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_516 = 0;
         var_515 = 0;
         var_98 = 0;
         var_76 = 0;
         _horizontal = param2 == WindowType.const_277;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _drawable = var_5 || !testParamFlag(WindowParam.const_32);
         _container = var_29.create("_CONTAINER","",WindowType.const_298,WindowStyle.const_270,0 | 0 | 0,new Rectangle(0,0,width,height),null,this,0,null,[WindowController.INTERNAL_CHILD_TAG,WindowController.EXCLUDE_CHILD_TAG]) as IWindowContainer;
         _container.addEventListener(WindowEvent.const_44,containerEventHandler);
         _container.addEventListener(WindowEvent.const_436,containerEventHandler);
         _container.addEventListener(WindowEvent.const_312,containerEventHandler);
         _container.addEventListener(WindowEvent.const_365,containerEventHandler);
         resizeOnItemUpdate = var_1069;
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _container.swapChildrenAt(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(var_516 * maxScrollH,var_515 * maxScrollV,width,height);
      }
      
      public function get maxScrollH() : int
      {
         var _loc1_:int = var_98 - width;
         return _loc1_ < 0 ? 0 : int(_loc1_);
      }
      
      public function get scrollH() : Number
      {
         return var_516;
      }
      
      override public function dispose() : void
      {
         _container.removeEventListener(WindowEvent.const_44,containerEventHandler);
         _container.removeEventListener(WindowEvent.const_436,containerEventHandler);
         _container.removeEventListener(WindowEvent.const_312,containerEventHandler);
         _container.removeEventListener(WindowEvent.const_365,containerEventHandler);
         super.dispose();
      }
      
      public function get maxScrollV() : int
      {
         var _loc1_:int = var_76 - height;
         return _loc1_ < 0 ? 0 : int(_loc1_);
      }
      
      public function get scrollV() : Number
      {
         return var_515;
      }
      
      public function set scrollH(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 != var_516)
         {
            var_516 = param1;
            _container.x = -var_516 * maxScrollH;
            var_29.invalidate(_container,visibleRegion,WindowRedrawFlag.const_71);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(new PropertyStruct(const_1011,_spacing,PropertyStruct.const_58,_spacing != DEF_SPACING));
         _loc1_.push(new PropertyStruct(const_1010,var_722,PropertyStruct.const_56,var_722 != const_1380));
         _loc1_.push(new PropertyStruct(const_1013,var_514,PropertyStruct.const_56,var_514 != const_1381));
         _loc1_.push(new PropertyStruct(const_1012,var_1069,PropertyStruct.const_56,var_1069 != DEF_RESIZE_ON_ITEM_UPDATE));
         return _loc1_;
      }
      
      public function get scrollStepH() : Number
      {
         return !!_horizontal ? Number(0 / numListItems) : Number(0);
      }
      
      public function setListItemIndex(param1:IWindow, param2:int) : void
      {
         _container.setChildIndex(param1,param2);
      }
      
      public function get scrollStepV() : Number
      {
         return !!_horizontal ? 0 : Number(0 / numListItems);
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:Boolean = false) : uint
      {
         return _container.groupChildrenWithID(param1,param2,param3);
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 != var_515)
         {
            var_515 = param1;
            _container.y = -var_515 * maxScrollV;
            var_29.invalidate(_container,visibleRegion,WindowRedrawFlag.const_71);
         }
      }
      
      public function set scrollStepH(param1:Number) : void
      {
         var_2294 = Math.max(param1,0);
      }
      
      override public function set properties(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case const_1011:
                  spacing = _loc2_.value as int;
                  break;
               case const_1013:
                  scaleToFitItems = _loc2_.value as Boolean;
                  break;
               case const_1012:
                  resizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case const_1010:
                  var_722 = _loc2_.value as Boolean;
                  break;
            }
         }
         super.properties = param1;
      }
      
      public function addListItemAt(param1:IWindow, param2:uint) : IWindow
      {
         param1 = _container.addChildAt(param1,param2);
         updateScrollAreaRegion();
         return param1;
      }
      
      public function get iterator() : IIterator
      {
         return new Iterator(this);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:Boolean = false) : uint
      {
         return _container.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function swapListItems(param1:IWindow, param2:IWindow) : void
      {
         _container.swapChildren(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         var_514 = param1;
         updateScrollAreaRegion();
      }
      
      public function set scrollStepV(param1:Number) : void
      {
         var_2293 = Math.max(param1,0);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _container.rectangle.clone();
      }
      
      private function containerEventHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case WindowEvent.const_436:
               updateScrollAreaRegion();
               break;
            case WindowEvent.const_312:
               if(!var_1333)
               {
                  updateScrollAreaRegion();
               }
               break;
            case WindowEvent.const_365:
               updateScrollAreaRegion();
               break;
            case WindowEvent.const_44:
               dispatchEvent(new WindowEvent(WindowEvent.const_44,this,null));
               break;
            default:
               Logger.log("ItemListController::containerEventHandler(" + param1.type + ")");
         }
      }
      
      public function removeListItem(param1:IWindow) : IWindow
      {
         param1 = _container.removeChild(param1);
         updateScrollAreaRegion();
         return param1;
      }
      
      public function arrangeListItems() : void
      {
         updateScrollAreaRegion();
      }
      
      public function get lastListItem() : IWindow
      {
         return numListItems > 0 ? getListItemAt(numListItems - 1) : null;
      }
      
      public function removeListItemAt(param1:int) : IWindow
      {
         return _container.removeChildAt(param1);
      }
      
      public function set spacing(param1:int) : void
      {
         if(param1 != _spacing)
         {
            _spacing = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function addListItem(param1:IWindow) : IWindow
      {
         var_188 = true;
         if(_horizontal)
         {
            param1.x = var_98 + (numListItems > 0 ? _spacing : 0);
            var_98 = param1.rectangle.right;
            _container.width = var_98;
         }
         else
         {
            if(autoArrangeItems)
            {
               param1.y = var_76 + (numListItems > 0 ? _spacing : 0);
               var_76 = param1.rectangle.bottom;
            }
            else
            {
               var_76 = Math.max(var_76,param1.rectangle.bottom);
            }
            _container.height = var_76;
         }
         param1 = _container.addChild(param1);
         var_188 = false;
         return param1;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         var_722 = param1;
         updateScrollAreaRegion();
      }
      
      public function getListItemByID(param1:uint) : IWindow
      {
         return _container.getChildByID(param1);
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         var_1069 = param1;
         if(_container)
         {
            if(_horizontal)
            {
               _container.setParamFlag(WindowParam.const_392,param1);
            }
            else
            {
               _container.setParamFlag(WindowParam.WINDOW_PARAM_REFLECT_VERTICAL_RESIZE_TO_PARENT,param1);
            }
         }
      }
      
      public function get firstListItem() : IWindow
      {
         return numListItems > 0 ? getListItemAt(0) : null;
      }
      
      protected function updateScrollAreaRegion() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(var_722 && !var_188 && _container)
         {
            var_188 = true;
            _loc1_ = 0;
            if(_horizontal)
            {
               var_98 = 0;
               var_76 = var_22.height;
               _loc4_ = 0;
               while(_loc4_ < _loc1_)
               {
                  _loc2_ = _container.getChildAt(_loc4_);
                  if(_loc2_.visible)
                  {
                     _loc2_.x = var_98;
                     var_98 += _loc2_.width + _spacing;
                     if(var_514)
                     {
                        _loc3_ = _loc2_.height + _loc2_.y;
                        var_76 = _loc3_ > var_76 ? Number(_loc3_) : Number(var_76);
                     }
                  }
                  _loc4_++;
               }
               if(_loc1_ > 0)
               {
                  var_98 -= _spacing;
               }
            }
            else
            {
               var_98 = var_22.width;
               var_76 = 0;
               _loc4_ = 0;
               while(_loc4_ < _loc1_)
               {
                  _loc2_ = _container.getChildAt(_loc4_);
                  if(_loc2_.visible)
                  {
                     _loc2_.y = var_76;
                     var_76 += _loc2_.height + _spacing;
                     if(var_514)
                     {
                        _loc3_ = _loc2_.width + _loc2_.x;
                        var_98 = _loc3_ > var_98 ? Number(_loc3_) : Number(var_98);
                     }
                  }
                  _loc4_++;
               }
               if(_loc1_ > 0)
               {
                  var_76 -= _spacing;
               }
            }
            if(var_516 > 0)
            {
               if(var_98 <= var_22.width)
               {
                  scrollH = 0;
               }
               else
               {
                  _container.x = -(var_516 * maxScrollH);
               }
            }
            if(var_515 > 0)
            {
               if(var_76 <= var_22.height)
               {
                  scrollV = 0;
               }
               else
               {
                  _container.y = -(var_515 * maxScrollV);
               }
            }
            _container.height = var_76;
            _container.width = var_98;
            var_188 = false;
         }
      }
      
      public function getListItemByName(param1:String) : IWindow
      {
         return _container.getChildByName(param1);
      }
      
      public function removeListItems() : void
      {
         var_188 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0);
         }
         var_188 = false;
         updateScrollAreaRegion();
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return var_514;
      }
      
      override protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < numListItems)
         {
            IItemListWindow(param1).addListItem(getListItemAt(_loc2_).clone());
            _loc2_++;
         }
      }
      
      override public function update(param1:WindowController, param2:Event) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case WindowNotifyEvent.const_395:
               break;
            case WindowNotifyEvent.const_670:
               var_1333 = true;
               break;
            case WindowNotifyEvent.const_211:
               if(!var_514)
               {
                  if(_horizontal)
                  {
                     _container.height = var_22.height;
                  }
                  else
                  {
                     _container.width = var_22.width;
                  }
               }
               updateScrollAreaRegion();
               var_1333 = false;
               break;
            case MouseEvent.MOUSE_WHEEL:
               if(_horizontal)
               {
                  scrollH -= MouseEvent(param2).delta * 0.01;
               }
               else
               {
                  scrollV -= MouseEvent(param2).delta * 0.01;
               }
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return var_722;
      }
      
      public function getListItemIndex(param1:IWindow) : int
      {
         return _container.getChildIndex(param1);
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return var_1069;
      }
      
      public function getListItemAt(param1:uint) : IWindow
      {
         return _container.getChildAt(param1);
      }
      
      public function get numListItems() : int
      {
         return _container != null ? 0 : 0;
      }
      
      public function destroyListItems() : void
      {
         var_188 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0).destroy();
         }
         var_188 = false;
         updateScrollAreaRegion();
      }
   }
}
