package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class TabContextController extends WindowController implements ITabContextWindow, IIterable
   {
      
      private static const const_1099:String = "content";
      
      private static const const_1098:String = "selector";
       
      
      private var var_1272:Boolean = false;
      
      protected var var_894:ITabSelectorWindow;
      
      private var var_778:Boolean = false;
      
      protected var var_1554:IWindowContainer;
      
      public function TabContextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc13_:* = null;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var _loc12_:Array = new Array();
         groupChildrenWithTag(WindowController.INTERNAL_CHILD_TAG,_loc12_,true);
         for each(_loc13_ in _loc12_)
         {
            _loc13_.style = var_89;
            _loc13_.procedure = selectorEventProc;
         }
         var_778 = true;
      }
      
      public function get container() : IWindowContainer
      {
         if(var_1554 == null)
         {
            var_1554 = findChildByTag(TabContextController.const_1099) as IWindowContainer;
         }
         return var_1554;
      }
      
      public function addTabItemAt(param1:ITabButtonWindow, param2:uint) : ITabButtonWindow
      {
         return selector.addSelectableAt(param1,param2) as ITabButtonWindow;
      }
      
      public function get numTabItems() : uint
      {
         return var_894.numSelectables;
      }
      
      public function getTabItemIndex(param1:ITabButtonWindow) : uint
      {
         return selector.getSelectableIndex(param1);
      }
      
      public function getTabItemAt(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableAt(param1) as ITabButtonWindow;
      }
      
      public function get selector() : ITabSelectorWindow
      {
         if(var_894 == null)
         {
            var_894 = findChildByTag(TabContextController.const_1098) as ITabSelectorWindow;
            if(var_894 != null)
            {
               var_894.procedure = selectorEventProc;
            }
         }
         return var_894;
      }
      
      public function removeTabItem(param1:ITabButtonWindow) : void
      {
         selector.removeSelectable(param1);
      }
      
      public function get iterator() : IIterator
      {
         return !!var_778 ? selector.iterator : null;
      }
      
      public function getTabItemByName(param1:String) : ITabButtonWindow
      {
         return selector.getSelectableByName(param1) as ITabButtonWindow;
      }
      
      public function addTabItem(param1:ITabButtonWindow) : ITabButtonWindow
      {
         return selector.addSelectable(param1) as ITabButtonWindow;
      }
      
      private function selectorEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowEvent.const_52)
         {
            notifyEventListeners(param1);
         }
      }
      
      public function method_13(param1:uint) : ITabButtonWindow
      {
         return selector.getSelectableByID(param1) as ITabButtonWindow;
      }
   }
}
