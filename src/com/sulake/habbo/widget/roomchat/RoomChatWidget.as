package com.sulake.habbo.widget.roomchat
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RoomChatWidget extends RoomWidgetBase implements ICoreUpdateReceiver
   {
      
      private static const const_742:int = 10;
      
      private static const const_481:int = 25;
      
      private static const const_1045:int = 6000;
      
      private static const const_1046:int = 9;
      
      private static const const_743:int = 4000;
      
      private static const const_1044:int = 3;
      
      private static const const_93:int = 18;
      
      private static const const_1043:int = 25;
      
      private static const const_1047:int = 1;
      
      private static const const_271:int = 9;
      
      private static const const_482:int = 8;
      
      private static const const_334:int = 0;
      
      private static const const_483:int = (const_482 + const_334) * const_93 + const_93;
       
      
      private var var_771:Number = 1;
      
      private var _disposed:Boolean = false;
      
      private var var_527:int = 18;
      
      private var var_331:IItemListWindow;
      
      private var var_628:int = 0;
      
      private var var_43:IWindowContainer;
      
      private var _isAnimating:Boolean = false;
      
      private var var_157:int;
      
      private var var_1747:int = 0;
      
      private var var_1129:Boolean = false;
      
      private var var_135:IWindowContainer;
      
      private var _itemList:Array;
      
      private var var_38:RoomChatHistoryViewer;
      
      private var var_1746:int = 150;
      
      private var var_450:Number = 1;
      
      private var var_73:Array;
      
      private var var_217:Array;
      
      private var var_627:int = 0;
      
      private var var_1748:int;
      
      private var var_626:Point;
      
      private var var_1390:Number = 0;
      
      private var var_44:Component = null;
      
      public function RoomChatWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager, param5:int, param6:Component)
      {
         _itemList = new Array();
         var_73 = new Array();
         var_217 = new Array();
         var_626 = new Point();
         var_157 = const_483 + const_271;
         super(param1,param2,param3);
         var_1748 = param5;
         var_43 = param1.createWindow("chat_container","",HabboWindowType.const_55,HabboWindowStyle.const_37,HabboWindowParam.const_40,new Rectangle(0,0,200,var_157 + RoomChatHistoryPulldown.const_69),null,0) as IWindowContainer;
         var_43.background = true;
         var_43.color = 33554431;
         var_43.tags.push("room_widget_chat");
         var_331 = param1.createWindow("chat_contentlist","",HabboWindowType.const_933,HabboWindowStyle.const_40,0 | 0,new Rectangle(0,0,200,var_157),null,0) as IItemListWindow;
         var_43.addChild(var_331);
         var_135 = param1.createWindow("chat_active_content","",HabboWindowType.const_55,HabboWindowStyle.const_40,HabboWindowParam.const_64,new Rectangle(0,0,200,var_157),null,0) as IWindowContainer;
         var_331.addListItem(var_135);
         var_38 = new RoomChatHistoryViewer(this,param1,var_43,param2);
         var_1746 = int(param4.getKey("chat.history.item.max.count","150"));
         var _loc7_:Boolean = int(param4.getKey("chat.history.disabled","0")) == 1 ? true : false;
         if(var_38 != null)
         {
            var_38.disabled = _loc7_;
         }
         if(param6 != null)
         {
            var_44 = param6;
            var_44.registerUpdateReceiver(this,1);
         }
      }
      
      public function onPulldownCloseButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_38 != null)
         {
            var_38.hideHistoryViewer();
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetChatUpdateEvent.const_571,onChatMessage);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_267,onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_691,onRoomViewUpdate);
         param1.addEventListener(RoomWidgetRoomViewUpdateEvent.const_504,onRoomViewUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function get mainWindow() : IWindow
      {
         return var_43;
      }
      
      public function onItemMouseOver(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      public function resetArea() : void
      {
         if(var_38 == null)
         {
            return;
         }
         animationStop();
         var_157 = const_483 + const_271;
         var_43.height = var_157 + var_38.pulldownBarHeight;
         var_331.width = 0 - 0;
         var_331.height = var_157;
         var_135.width = 0 - 0;
         if(historyViewerActive())
         {
            var_135.height = getTotalContentHeight() + const_271;
         }
         else
         {
            var_135.height = var_157;
         }
         var_331.scrollV = 1;
         if(!historyViewerActive())
         {
            var_38.containerResized(var_43.rectangle);
         }
         purgeItems();
         alignItems();
      }
      
      public function resizeContainerToLowestItem() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_73.length)
         {
            _loc4_ = var_73[_loc2_];
            if(_loc4_.y > _loc1_)
            {
               _loc1_ = _loc4_.y;
            }
            _loc2_++;
         }
         _loc1_ += const_481;
         _loc1_ = _loc1_ < 0 ? 0 : int(_loc1_);
         var _loc3_:int = var_43.rectangle.bottom;
         stretchAreaBottomTo(var_43.rectangle.top + _loc1_);
         _loc3_ -= var_43.rectangle.bottom;
         if(Math.abs(_loc3_) < RoomChatHistoryViewer.const_987)
         {
            resetArea();
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc4_ = _itemList[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_73.length)
         {
            _loc4_ = var_73[_loc2_];
            _loc4_.y += _loc3_;
            _loc2_++;
         }
         var_1129 = true;
      }
      
      private function processBuffer() : void
      {
         if(_isAnimating)
         {
            return;
         }
         if(false)
         {
            return;
         }
         while(var_73.length > const_1047 || historyViewerActive() && false)
         {
            activateItemFromBuffer();
         }
         var _loc1_:Boolean = false;
         if(false)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = checkLastItemAllowsAdding(var_73[0]);
         }
         if(_loc1_)
         {
            activateItemFromBuffer();
            var_628 = getTimer() + const_743;
         }
         else
         {
            if(false && false)
            {
               var_527 = getItemSpacing(_itemList["-1"],var_73[0]);
            }
            else
            {
               var_527 = const_93;
            }
            animationStart();
         }
      }
      
      private function setChatItemLocHorizontal(param1:RoomChatItem) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 == null || var_38 == null)
         {
            return;
         }
         var _loc2_:Number = (param1.senderX + var_626.x) * var_771;
         var _loc3_:Number = _loc2_ - param1.width / 2;
         var _loc4_:Number = _loc3_ + param1.width;
         var _loc5_:Number = 0 - const_742;
         var _loc6_:Number = 0 + const_742 - 0;
         var _loc7_:Boolean = _loc3_ >= _loc5_ && _loc3_ <= _loc6_;
         var _loc8_:Boolean = _loc4_ >= _loc5_ && _loc4_ <= _loc6_;
         if(_loc7_ && _loc8_)
         {
            _loc9_ = _loc3_;
            _loc10_ = _loc9_;
         }
         else if(_loc2_ >= 0)
         {
            _loc9_ = _loc6_ - param1.width;
         }
         else
         {
            _loc9_ = _loc5_;
         }
         param1.x = _loc9_ + 0 + var_43.x;
         if(_loc2_ < _loc5_ || _loc2_ > _loc6_)
         {
            param1.hidePointer();
         }
         else
         {
            param1.setPointerOffset(_loc3_ - _loc9_);
         }
      }
      
      public function onItemMouseOut(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
      }
      
      private function checkLastItemAllowsAdding(param1:RoomChatItem) : Boolean
      {
         if(false)
         {
            return true;
         }
         var _loc2_:RoomChatItem = _itemList["-1"];
         if(param1 == null || _loc2_ == null)
         {
            return false;
         }
         if(_loc2_.view == null)
         {
            return true;
         }
         if(var_135.rectangle.bottom - (var_135.y + _loc2_.y + _loc2_.height) <= getItemSpacing(_loc2_,param1))
         {
            return false;
         }
         return true;
      }
      
      public function mouseUp() : void
      {
         var _loc1_:Number = var_43.rectangle.bottom - 0;
         if(_loc1_ < const_483)
         {
            if(_loc1_ <= var_157 + var_43.y)
            {
               if(historyViewerActive())
               {
                  hideHistoryViewer();
               }
               resetArea();
               return;
            }
         }
         if(var_1129 && !historyViewerActive())
         {
            resetArea();
            var_1129 = false;
         }
      }
      
      private function getFreeItemId() : String
      {
         return "chat_" + var_1748.toString() + "_item_" + (var_1747++).toString();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         while(false)
         {
            _loc1_ = var_217.shift();
         }
         var_38.dispose();
         var_38 = null;
         while(false)
         {
            _loc1_ = _itemList.shift();
            _loc1_.dispose();
         }
         while(false)
         {
            _loc1_ = var_73.shift();
            _loc1_.dispose();
         }
         var_43.dispose();
         if(var_44 != null)
         {
            var_44.removeUpdateReceiver(this);
            var_44 = null;
         }
         super.dispose();
         _disposed = true;
      }
      
      private function animationStop() : void
      {
         _isAnimating = false;
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetChatUpdateEvent.const_571,onChatMessage);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_267,onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_691,onRoomViewUpdate);
         param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.const_504,onRoomViewUpdate);
      }
      
      public function onPulldownMouseDown(param1:WindowMouseEvent) : void
      {
         if(var_38 != null)
         {
            var_38.beginDrag(param1.stageY,true);
         }
      }
      
      private function alignItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_38 == null)
         {
            return;
         }
         _loc1_ = -1;
         while(_loc1_ >= 0)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemLocHorizontal(_loc2_);
               setChatItemLocVertical(_loc2_);
            }
            _loc1_--;
         }
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemRenderable(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < var_73.length)
         {
            _loc2_ = var_73[_loc1_];
            if(_loc2_ != null)
            {
               setChatItemLocHorizontal(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function onChatMessage(param1:RoomWidgetChatUpdateEvent) : void
      {
         var _loc2_:RoomChatItem = new RoomChatItem(this,windowManager,assets,getFreeItemId(),localizations);
         _loc2_.define(param1);
         if(var_771 != 1)
         {
            _loc2_.senderX /= var_771;
         }
         _loc2_.senderX -= 0;
         setChatItemLocHorizontal(_loc2_);
         var_73.push(_loc2_);
         processBuffer();
      }
      
      private function setChatItemLocVertical(param1:RoomChatItem) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 != null)
         {
            _loc2_ = _itemList.indexOf(param1);
            _loc3_ = !!historyViewerActive() ? 0 : Number(var_450);
            if(_loc2_ == -1)
            {
               param1.y = getAreaBottom() - (_loc3_ + 1) * const_93 - const_271;
            }
            else
            {
               _loc4_ = _itemList[_loc2_ + 1].aboveLevels;
               if(_loc4_ < 2)
               {
                  param1.y = _itemList[_loc2_ + 1].y - getItemSpacing(param1,_itemList[_loc2_ + 1]);
               }
               else
               {
                  param1.y = _itemList[_loc2_ + 1].y - _loc4_ * const_93;
               }
            }
         }
      }
      
      public function disableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_73.length)
         {
            _loc1_ = var_73[_loc2_];
            _loc1_.disableTooltip();
            _loc2_++;
         }
      }
      
      private function animationStart() : void
      {
         if(_isAnimating)
         {
            return;
         }
         selectItemsToMove();
         _isAnimating = true;
      }
      
      public function hideHistoryViewer() : void
      {
         if(var_38 != null)
         {
            var_38.hideHistoryViewer();
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(getTimer() > var_628 && var_628 > 0)
         {
            var_628 = -1;
            animationStart();
         }
         if(_isAnimating)
         {
            _loc2_ = param1 / const_1043 * const_1044;
            if(_loc2_ + var_627 > var_527)
            {
               _loc2_ = var_527 - var_627;
            }
            if(_loc2_ > 0)
            {
               moveItemsUp(_loc2_);
               var_627 += _loc2_;
            }
            if(var_627 >= var_527)
            {
               var_527 = const_93;
               var_627 = 0;
               animationStop();
               processBuffer();
               var_628 = getTimer() + const_743;
            }
         }
         if(var_38 != null)
         {
            var_38.update(param1);
         }
      }
      
      public function getTotalContentHeight() : int
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc3_];
            if(_loc1_ != null)
            {
               if(_loc3_ == 0)
               {
                  _loc2_ += const_93;
               }
               else
               {
                  _loc2_ += getItemSpacing(_itemList[_loc3_ - 1],_loc1_);
               }
               _loc2_ += (_loc1_.aboveLevels - 1) * const_93;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent) : void
      {
         var _loc2_:Rectangle = param1.rect;
         if(param1.scale > 0)
         {
            if(var_1390 == 0)
            {
               var_1390 = param1.scale;
            }
            else
            {
               var_771 = param1.scale / var_1390;
            }
         }
         if(param1.positionDelta != null)
         {
            var_626.x += param1.positionDelta.x / var_771;
            var_626.y += param1.positionDelta.y / var_771;
         }
         if(param1.rect != null)
         {
            if(var_38 == null)
            {
               return;
            }
            var_43.x = _loc2_.x;
            var_43.y = _loc2_.y;
            var_43.width = _loc2_.width;
            var_43.height = var_157 + var_38.pulldownBarHeight;
            var_331.width = 0 - 0;
            var_331.height = var_157;
            var_331.x = var_43.x;
            var_331.y = var_43.y;
            var_135.width = 0 - 0;
            var_135.height = var_157;
            if(historyViewerActive())
            {
               reAlignItemsToHistoryContent();
            }
            var_38.containerResized(var_43.rectangle,true);
         }
         alignItems();
      }
      
      private function getAreaBottom() : Number
      {
         if(historyViewerActive())
         {
            return var_135.height;
         }
         return var_157 + var_43.y;
      }
      
      private function purgeItems() : void
      {
         var _loc2_:* = null;
         if(historyViewerActive())
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         while(_itemList.length > var_1746)
         {
            _loc2_ = _itemList.shift();
            _loc3_ = var_217.indexOf(_loc2_);
            if(_loc3_ > -1)
            {
               var_217.splice(_loc3_,1);
            }
            if(_loc2_.view != null)
            {
               var_135.removeChild(_loc2_.view);
               _loc2_.hideView();
            }
            _loc2_.dispose();
            _loc2_ = null;
         }
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         for(; _loc1_ < _itemList.length; _loc1_++)
         {
            _loc2_ = _itemList[_loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.y > -const_481)
               {
                  _loc4_ = true;
               }
               _loc2_.aboveLevels = 1;
               if(_loc2_.view != null)
               {
                  _loc3_ = var_217.indexOf(_loc2_);
                  if(_loc3_ > -1)
                  {
                     var_217.splice(_loc3_,1);
                  }
                  var_135.removeChild(_loc2_.view);
                  _loc2_.hideView();
               }
               continue;
               break;
            }
         }
         if(false)
         {
            _loc4_ = true;
         }
         if(getTotalContentHeight() > const_93 && !_loc4_ && !historyViewerActive())
         {
            if(var_38 != null)
            {
               stretchAreaBottomTo(var_43.y);
               alignItems();
               if(!historyViewerActive())
               {
                  var_38.showHistoryViewer();
               }
               if(!historyViewerVisible())
               {
                  var_38.visible = true;
               }
            }
         }
         else if(historyViewerVisible())
         {
            var_38.visible = false;
         }
      }
      
      public function stretchAreaBottomBy(param1:Number) : void
      {
         var _loc2_:Number = var_43.rectangle.bottom + param1 - 0;
         stretchAreaBottomTo(_loc2_);
      }
      
      private function activateItemFromBuffer() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(false)
         {
            return;
         }
         if(historyViewerMinimized())
         {
            resetArea();
            hideHistoryViewer();
         }
         if(!checkLastItemAllowsAdding(var_73[0]))
         {
            selectItemsToMove();
            moveItemsUp(getItemSpacing(_itemList["-1"],var_73[0]));
            if(!checkLastItemAllowsAdding(var_73[0]))
            {
               var_135.height += const_93;
               if(var_38 != null)
               {
                  var_38.containerResized(var_43.rectangle);
               }
            }
         }
         _loc1_ = var_73.shift();
         if(_loc1_ != null)
         {
            _loc1_.renderView();
            _loc2_ = _loc1_.view;
            if(_loc2_ != null)
            {
               var_135.addChild(_loc2_);
               _loc1_.timestamp = new Date().time;
               _itemList.push(_loc1_);
               _loc3_ = 0;
               if(false)
               {
                  _loc3_ = _itemList["-2"].screenLevel;
                  if(historyViewerActive())
                  {
                     _loc1_.screenLevel = _loc3_ + 1;
                  }
                  else
                  {
                     _loc1_.screenLevel = _loc3_ + Math.max(var_450,1);
                  }
               }
               else
               {
                  _loc1_.screenLevel = 100;
               }
               _loc1_.aboveLevels = var_450;
               if(_loc1_.aboveLevels > const_482 + const_334 + 2)
               {
                  _loc1_.aboveLevels = const_482 + const_334 + 2;
               }
               var_450 = 0;
               setChatItemLocHorizontal(_loc1_);
               setChatItemLocVertical(_loc1_);
               setChatItemRenderable(_loc1_);
            }
         }
      }
      
      public function stretchAreaBottomTo(param1:Number) : void
      {
         var _loc2_:int = var_43.context.getDesktopWindow().height - 0;
         param1 = Math.min(param1,_loc2_);
         var_157 = param1 - 0;
         var_43.height = var_157 + RoomChatHistoryPulldown.const_69;
         if(var_38 != null)
         {
            var_38.containerResized(var_43.rectangle);
         }
      }
      
      public function onItemMouseClick(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
         if(param5.shiftKey)
         {
            if(var_38 != null)
            {
               var_38.toggleHistoryViewer();
            }
            return;
         }
         var _loc6_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_297,param1,param2);
         messageListener.processWidgetMessage(_loc6_);
         var _loc7_:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.const_671,param1,param3,param4);
         messageListener.processWidgetMessage(_loc7_);
      }
      
      private function selectItemsToMove() : void
      {
         var _loc4_:* = null;
         if(_isAnimating)
         {
            return;
         }
         purgeItems();
         var_217 = new Array();
         var _loc1_:int = new Date().time;
         var _loc2_:int = 0;
         if(false)
         {
            var_450 = 1;
            return;
         }
         if(historyViewerActive())
         {
            return;
         }
         ++var_450;
         var _loc3_:int = -1;
         while(_loc3_ >= 0)
         {
            _loc4_ = _itemList[_loc3_];
            if(_loc4_.view != null)
            {
               if(_loc4_.screenLevel > const_334 || _loc4_.screenLevel == _loc2_ - 1 || _loc1_ - _loc4_.timestamp >= const_1045)
               {
                  _loc4_.timestamp = _loc1_;
                  _loc2_ = _loc4_.screenLevel;
                  --_loc4_.screenLevel;
                  var_217.push(_loc4_);
               }
            }
            _loc3_--;
         }
      }
      
      public function enableDragTooltips() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < var_73.length)
         {
            _loc1_ = var_73[_loc2_];
            _loc1_.enableTooltip();
            _loc2_++;
         }
      }
      
      public function reAlignItemsToHistoryContent() : void
      {
         if(historyViewerActive())
         {
            var_135.height = getTotalContentHeight() + const_271;
            alignItems();
         }
      }
      
      private function setChatItemRenderable(param1:RoomChatItem) : void
      {
         if(param1 != null)
         {
            if(param1.y < -const_481)
            {
               if(param1.view != null)
               {
                  var_135.removeChild(param1.view);
                  param1.hideView();
               }
            }
            else if(param1.view == null)
            {
               param1.renderView();
               if(param1.view != null)
               {
                  var_135.addChild(param1.view);
               }
            }
         }
      }
      
      private function historyViewerMinimized() : Boolean
      {
         return true;
      }
      
      private function moveItemsUp(param1:int) : void
      {
         var _loc3_:Boolean = false;
         if(var_217 == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc2_:* = null;
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         while(_loc5_ >= 0)
         {
            _loc2_ = var_217[_loc5_];
            if(_loc2_ != null)
            {
               if(_loc4_ == -1)
               {
                  _loc4_ = _itemList.indexOf(_loc2_);
               }
               else
               {
                  _loc4_++;
               }
               _loc3_ = true;
               if(historyViewerActive())
               {
                  if(_loc2_.y - param1 + _loc2_.height < 0)
                  {
                     _loc3_ = false;
                  }
               }
               if(_loc4_ > 0)
               {
                  if(_itemList[_loc4_ - 1].view != null)
                  {
                     if(_loc2_.y - param1 - _itemList[_loc4_ - 1].y < getItemSpacing(_itemList[_loc4_ - 1],_loc2_))
                     {
                        _loc3_ = false;
                     }
                  }
               }
               if(_loc3_)
               {
                  _loc2_.y -= param1;
               }
            }
            _loc5_--;
         }
      }
      
      private function historyViewerActive() : Boolean
      {
         return var_38 == null ? false : Boolean(var_38.active);
      }
      
      private function getItemSpacing(param1:RoomChatItem, param2:RoomChatItem) : Number
      {
         if(param1.checkOverlap(param2.x,param1.y,param2.width,param2.height))
         {
            return const_93;
         }
         return const_1046;
      }
      
      public function onItemMouseDown(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent) : void
      {
         if(historyViewerVisible())
         {
            return;
         }
         if(var_38 != null)
         {
            var_38.beginDrag(param5.stageY);
         }
      }
      
      private function historyViewerVisible() : Boolean
      {
         return var_38 == null ? false : Boolean(var_38.visible);
      }
   }
}
