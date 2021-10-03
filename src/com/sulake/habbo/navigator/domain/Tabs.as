package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;
   
   public class Tabs
   {
      
      public static const const_614:int = 6;
      
      public static const const_215:int = 5;
      
      public static const const_599:int = 2;
      
      public static const const_295:int = 9;
      
      public static const const_299:int = 4;
      
      public static const const_231:int = 2;
      
      public static const const_595:int = 4;
      
      public static const const_193:int = 8;
      
      public static const const_672:int = 7;
      
      public static const const_256:int = 3;
      
      public static const const_275:int = 1;
      
      public static const const_197:int = 5;
      
      public static const const_431:int = 12;
      
      public static const const_329:int = 1;
      
      public static const const_636:int = 11;
      
      public static const const_687:int = 3;
      
      public static const const_1556:int = 10;
       
      
      private var _navigator:HabboNavigator;
      
      private var var_408:Array;
      
      public function Tabs(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_408 = new Array();
         var_408.push(new Tab(_navigator,const_275,const_431,new EventsTabPageDecorator(_navigator),MainViewCtrl.const_399));
         var_408.push(new Tab(_navigator,const_231,const_329,new RoomsTabPageDecorator(_navigator),MainViewCtrl.const_399));
         var_408.push(new Tab(_navigator,const_299,const_636,new OfficialTabPageDecorator(_navigator),MainViewCtrl.const_1005));
         var_408.push(new Tab(_navigator,const_256,const_215,new MyRoomsTabPageDecorator(_navigator),MainViewCtrl.const_399));
         var_408.push(new Tab(_navigator,const_197,const_193,new SearchTabPageDecorator(_navigator),MainViewCtrl.const_505));
         setSelectedTab(const_275);
      }
      
      public function getSelected() : Tab
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_408)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getTab(param1:int) : Tab
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_408)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function clearSelected() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_408)
         {
            _loc1_.selected = false;
         }
      }
      
      public function onFrontPage() : Boolean
      {
         return this.getSelected().id == const_299;
      }
      
      public function get tabs() : Array
      {
         return var_408;
      }
      
      public function setSelectedTab(param1:int) : void
      {
         this.clearSelected();
         getTab(param1).selected = true;
      }
   }
}
