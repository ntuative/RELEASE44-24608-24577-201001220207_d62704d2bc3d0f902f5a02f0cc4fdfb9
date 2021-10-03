package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.FriendRequestsView;
   import com.sulake.habbo.friendlist.FriendsView;
   import com.sulake.habbo.friendlist.SearchView;
   
   public class FriendListTabs
   {
       
      
      private var var_2001:int = 200;
      
      private var var_672:int = 200;
      
      private var var_368:IFriendListTabsDeps;
      
      private var var_408:Array;
      
      private var var_1478:FriendListTab;
      
      private var var_1477:int = 200;
      
      public function FriendListTabs(param1:IFriendListTabsDeps)
      {
         var_408 = new Array();
         super();
         var_368 = param1;
         var_408.push(new FriendListTab(var_368.getFriendList(),FriendListTab.const_83,new FriendsView(),"${friendlist.friends}","friends_footer","hdr_friends"));
         var_408.push(new FriendListTab(var_368.getFriendList(),FriendListTab.const_94,new FriendRequestsView(),"${friendlist.tab.friendrequests}","friend_requests_footer","hdr_friend_requests"));
         var_408.push(new FriendListTab(var_368.getFriendList(),FriendListTab.const_303,new SearchView(),"${generic.search}","search_footer","hdr_search"));
         toggleSelected(null);
      }
      
      public function findSelectedTab() : FriendListTab
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
      
      public function get tabContentWidth() : int
      {
         return var_1477 - 2;
      }
      
      public function toggleSelected(param1:FriendListTab) : void
      {
         var _loc2_:FriendListTab = findSelectedTab();
         if(_loc2_ == null)
         {
            var_672 = var_2001;
            setSelected(determineDisplayedTab(param1),true);
         }
         else if(_loc2_ == param1 || param1 == null)
         {
            var_2001 = var_672;
            var_672 = 0;
            clearSelections();
         }
         else
         {
            setSelected(determineDisplayedTab(param1),true);
         }
      }
      
      public function clearSelections() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_408)
         {
            _loc1_.setSelected(false);
         }
      }
      
      public function set tabContentHeight(param1:int) : void
      {
         var_672 = param1;
      }
      
      public function findTab(param1:int) : FriendListTab
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
      
      private function setSelected(param1:FriendListTab, param2:Boolean) : void
      {
         var _loc3_:FriendListTab = findSelectedTab();
         clearSelections();
         param1.setSelected(param2);
         if(param2)
         {
            var_1478 = param1;
         }
      }
      
      private function determineDisplayedTab(param1:FriendListTab) : FriendListTab
      {
         if(param1 != null)
         {
            return param1;
         }
         if(var_1478 != null)
         {
            return var_1478;
         }
         return var_408[0];
      }
      
      public function get tabContentHeight() : int
      {
         return var_672;
      }
      
      public function set windowWidth(param1:int) : void
      {
         var_1477 = param1;
      }
      
      public function getTabs() : Array
      {
         return var_408;
      }
      
      public function get windowWidth() : int
      {
         return var_1477;
      }
   }
}
