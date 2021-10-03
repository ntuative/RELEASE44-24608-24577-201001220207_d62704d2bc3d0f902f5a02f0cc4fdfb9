package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ICheckBoxWindow;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
   import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveableRoomSettingsData;
   import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.TextFieldManager;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.geom.Rectangle;
   
   public class RoomSettingsCtrl
   {
       
      
      private var var_854:TextFieldManager;
      
      private var var_1264:TextFieldManager;
      
      private var _window:IWindowContainer;
      
      private var var_413:int;
      
      private var var_1269:IWindowContainer;
      
      private var var_1028:int;
      
      private var var_1029:IWindowContainer;
      
      private var _active:Boolean;
      
      private var var_1032:IWindowContainer;
      
      private var var_2113:ITextWindow;
      
      private var var_1031:IWindowContainer;
      
      private var var_775:TextFieldManager;
      
      private var var_1511:IWindowContainer;
      
      private var var_2112:ITextWindow;
      
      private var var_412:IRoomSettingsCtrlOwner;
      
      private var _inRoom:Boolean;
      
      private var var_1267:TextFieldManager;
      
      private var var_498:Boolean;
      
      private var var_1509:Boolean;
      
      private var var_1512:IWindowContainer;
      
      private var var_777:TextFieldManager;
      
      private var var_1268:ICheckBoxWindow;
      
      private var _navigator:HabboNavigator;
      
      private var var_1266:ICheckBoxWindow;
      
      private var var_279:IWindowContainer;
      
      private var var_1510:ITextWindow;
      
      private var var_1265:IWindowContainer;
      
      private var var_1030:TextFieldManager;
      
      private var var_104:RoomSettingsData;
      
      public function RoomSettingsCtrl(param1:HabboNavigator, param2:IRoomSettingsCtrlOwner, param3:Boolean)
      {
         super();
         _navigator = param1;
         var_412 = param2;
         _inRoom = param3;
      }
      
      private function getFlatCtrl(param1:int) : FlatControllerData
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_104.controllers)
         {
            if(_loc2_.userId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function onRemoveFlatCtrlClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Remove clicked: ");
         var _loc3_:Array = new Array();
         for each(_loc4_ in var_104.controllers)
         {
            if(_loc4_.selected)
            {
               _loc3_.push(_loc4_.userId);
            }
         }
         _loc5_ = new RemoveRightsMessageComposer(_loc3_);
         _navigator.send(_loc5_);
      }
      
      private function getSaveButton() : IButtonWindow
      {
         return IButtonWindow(_window.findChildByName("save"));
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
         this.var_498 = false;
      }
      
      private function onDoorModePasswordSelect(param1:WindowEvent) : void
      {
         changePasswordField(true);
      }
      
      private function setTagError(param1:TextFieldManager, param2:String, param3:String) : void
      {
         if(param2 == param1.getText().toLowerCase())
         {
            param1.displayError(param3);
         }
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         close();
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      private function controllerExists(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < var_104.controllers.length)
         {
            _loc3_ = var_104.controllers[_loc2_];
            if(_loc3_.userId == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function onEditThumbnailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._navigator.roomInfoViewCtrl.startThumbnailEdit();
      }
      
      public function onFlatControllerRemoved(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         if(param1 != this.var_413)
         {
            return;
         }
         --this.var_104.controllerCount;
         var _loc3_:int = 0;
         while(_loc3_ < var_104.controllers.length)
         {
            _loc4_ = var_104.controllers[_loc3_];
            if(_loc4_.userId == param2)
            {
               var_104.controllers.splice(_loc3_,1);
            }
            else
            {
               _loc3_++;
            }
         }
         if(var_498)
         {
            this.var_412.roomSettingsRefreshNeeded();
         }
      }
      
      private function clearErrors() : void
      {
         this.var_854.clearErrors();
         this.var_1267.clearErrors();
         this.var_775.clearErrors();
         this.var_777.clearErrors();
         this.var_1030.clearErrors();
         this.var_1264.clearErrors();
      }
      
      private function onDoorModePasswordUnselect(param1:WindowEvent) : void
      {
         changePasswordField(false);
      }
      
      private function hasSelectedFlatCtrls() : Boolean
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_104.controllers)
         {
            if(_loc1_.selected)
            {
               return true;
            }
         }
         return false;
      }
      
      public function onRoomSettings(param1:RoomSettingsData) : void
      {
         if(param1.roomId != this.var_413)
         {
            return;
         }
         this.var_104 = param1;
         this._active = true;
         this.var_1509 = true;
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      private function refreshCategories() : void
      {
         var categoryMenu:IDropMenuWindow = _window.findChildByName("categories") as IDropMenuWindow;
         var currentSelection:FlatCategory = _navigator.data.getCategoryByIndex(categoryMenu.selection);
         categoryMenu.populate(_navigator.data.categories.map(function(param1:FlatCategory, param2:int, param3:Array):String
         {
            Logger.log("POPULATING: " + param1.nodeName + ", " + param1.nodeId);
            return param1.nodeName;
         }));
         if(currentSelection != null)
         {
            setCategorySelection(currentSelection.nodeId);
         }
      }
      
      private function onConfirmRoomDelete(param1:WindowMouseEvent, param2:int) : void
      {
         var _loc3_:* = null;
         _navigator.send(new DeleteRoomMessageComposer(param2));
         close();
         var_412.roomSettingsRefreshNeeded();
         if(_navigator.data.guestRoomSearchResults != null)
         {
            _loc3_ = _navigator.data.guestRoomSearchResults;
            _navigator.mainViewCtrl.startSearch(_navigator.tabs.getSelected().id,_loc3_.searchType,_loc3_.searchParam);
         }
         _navigator.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_154,HabboToolbarIconEnum.ROOMINFO));
      }
      
      private function addTag(param1:TextFieldManager, param2:Array) : void
      {
         if(param1.getText() != "")
         {
            param2.push(param1.getText());
         }
      }
      
      private function onDeleteButtonClick(param1:WindowMouseEvent) : void
      {
         Logger.log("[RoomSettingsCtrl.onDeleteButtonClick] " + var_413);
         _navigator.registerParameter("navigator.roomsettings.deleteroom.confirm.message","room_name",var_104.name);
         var _loc2_:ConfirmDialogView = new ConfirmDialogView(IFrameWindow(_navigator.getXmlWindow("ros_room_delete_confirm")),this,onConfirmRoomDelete,[var_413]);
         _loc2_.show();
      }
      
      private function onSwitchView(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var_498 = !var_498;
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      private function refreshFlatController(param1:IWindowContainer, param2:int, param3:FlatControllerData) : void
      {
         var _loc6_:* = null;
         var _loc4_:String = "fc." + param2;
         var _loc5_:IWindowContainer = IWindowContainer(param1.getChildByName(_loc4_));
         if(param3 == null)
         {
            if(_loc5_ != null)
            {
               _loc5_.visible = false;
            }
         }
         else
         {
            if(_loc5_ == null)
            {
               _loc5_ = getFlatControllerContainer(_loc4_);
               param1.addChild(_loc5_);
               _loc5_.addChild(_navigator.getXmlWindow("ros_flat_controller"));
            }
            _loc6_ = ITextWindow(_loc5_.findChildByName("flat_controller"));
            _loc6_.text = param3.userName;
            _loc6_.id = param3.userId;
            Util.setProcDirectly(_loc6_,onFlatControllerClick);
            _loc6_.width = _loc6_.textWidth + 5;
            _loc5_.width = _loc6_.width + 3;
            _loc5_.height = _loc6_.height;
            _loc6_.color = !!param3.selected ? 4294967295 : uint(4286216826);
            Logger.log("HUMP: " + param3.userName + ", " + param3.selected + ", " + _loc6_.textBackgroundColor);
            _loc5_.visible = true;
         }
      }
      
      private function onFlatControllerClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:ITextWindow = ITextWindow(param2);
         var _loc4_:int = _loc3_.id;
         Logger.log("FC clicked: " + _loc3_.name + ", " + _loc4_);
         var _loc5_:FlatControllerData = getFlatCtrl(_loc4_);
         if(_loc5_ == null)
         {
            Logger.log("Couldn\'t find fc: " + _loc4_);
            return;
         }
         _loc5_.selected = !_loc5_.selected;
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      private function changePasswordField(param1:Boolean) : void
      {
         var_1032.visible = param1;
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      private function refreshFlatControllers() : void
      {
         var _loc10_:* = null;
         var _loc1_:IWindowContainer = IWindowContainer(var_279.findChildByName("flat_controller_list"));
         var _loc2_:IButtonWindow = IButtonWindow(var_279.findChildByName("remove_flat_ctrl"));
         var _loc3_:IButtonWindow = IButtonWindow(var_279.findChildByName("remove_all_flat_ctrls"));
         var _loc4_:IWindow = var_279.findChildByName("flat_ctrls_caption_txt");
         var _loc5_:IWindow = var_279.findChildByName("flat_ctrls_info_txt");
         var _loc6_:IWindow = var_279.findChildByName("flat_ctrls_limit_txt");
         var _loc7_:IWindowContainer = IWindowContainer(var_279.findChildByName("flat_controllers_footer"));
         Util.hideChildren(var_279);
         var_279.findChildByName("ruler").visible = true;
         _navigator.registerParameter("navigator.roomsettings.flatctrls.caption","cnt","undefined");
         _loc4_.visible = true;
         Util.hideChildren(_loc1_);
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         while(_loc9_ < var_104.controllers.length)
         {
            _loc10_ = var_104.controllers[_loc9_];
            refreshFlatController(_loc1_,_loc9_,_loc10_);
            if(_loc10_.selected)
            {
               _loc8_ = true;
            }
            _loc9_++;
         }
         Util.layoutChildrenInArea(_loc1_,_loc1_.width,15);
         _loc1_.height = Util.getLowestPoint(_loc1_);
         if(var_104.controllers.length > 0)
         {
            _loc1_.visible = true;
            _loc7_.visible = true;
            _loc5_.visible = true;
            if(var_104.controllerCount > var_104.controllers.length)
            {
               _navigator.registerParameter("navigator.roomsettings.flatctrls.limitinfo","cnt","" + var_104.controllers.length);
               _loc6_.visible = true;
            }
            Util.moveChildrenToColumn(var_279,["flat_ctrls_caption_txt","flat_ctrls_limit_txt","flat_controller_list","flat_ctrls_info_txt","flat_controllers_footer"],_loc4_.y,5);
         }
         else
         {
            _loc7_.visible = false;
            _loc5_.visible = false;
            _loc7_.y = _loc1_.y + _loc1_.height + 5;
         }
         if(_loc8_)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
         var_279.height = Util.getLowestPoint(var_279);
      }
      
      private function getFlatControllerContainer(param1:String) : IWindowContainer
      {
         return IWindowContainer(_navigator.windowManager.createWindow(param1,"",HabboWindowType.const_55,HabboWindowStyle.const_37,HabboWindowParam.const_64,new Rectangle(0,0,100,20)));
      }
      
      private function getCancelButton() : IButtonWindow
      {
         return IButtonWindow(_window.findChildByName("cancel"));
      }
      
      public function refresh(param1:IWindowContainer) : void
      {
         if(!_active)
         {
            return;
         }
         prepareWindow(param1);
         Util.hideChildren(_window);
         var_1511.visible = _inRoom;
         var_1512.visible = _inRoom;
         var_2113.visible = var_498;
         var_2112.visible = !var_498;
         if(var_498)
         {
            var_1029.visible = true;
            var_1265.visible = false;
            refreshFlatControllers();
            var_1029.height = Util.getLowestPoint(this.var_1029) + 4;
         }
         else
         {
            populateForm();
            var_1031.visible = true;
            var_1265.visible = true;
            var_1269.visible = _inRoom;
            _navigator.thumbRenderer.refreshThumbnail(IWindowContainer(var_1269.findChildByName("picframe")),_navigator.data.enteredGuestRoom.thumbnail,false);
            var_1031.height = Util.getLowestPoint(this.var_1031) + 4;
         }
         var_1510.text = !!var_498 ? "${navigator.roomsettings.tobasicsettings}" : "${navigator.roomsettings.toadvancedsettings}";
         Util.moveChildrenToColumn(_window,[var_1511.name,var_1269.name,var_1031.name,var_1029.name,var_1265.name,var_1512.name],0,0);
         _window.height = Util.getLowestPoint(this._window) + 4;
         _window.visible = true;
      }
      
      private function populateForm() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(!var_1509)
         {
            return;
         }
         var_1509 = false;
         var _loc1_:RoomSettingsData = var_104;
         var_854.setText(_loc1_.name);
         var_1267.setText(_loc1_.description);
         var_1030.setText("");
         var_1264.setText("");
         var _loc2_:ISelectorWindow = _window.findChildByName("doormode") as ISelectorWindow;
         var _loc3_:IRadioButtonWindow = _window.findChildByName("doormode_password") as IRadioButtonWindow;
         switch(_loc1_.doorMode)
         {
            case RoomSettingsData.const_169:
               _loc4_ = _window.findChildByName("doormode_doorbell") as IRadioButtonWindow;
               _loc2_.setSelected(_loc4_);
               break;
            case RoomSettingsData.const_128:
               _loc2_.setSelected(_loc3_);
               break;
            default:
               _loc5_ = _window.findChildByName("doormode_open") as IRadioButtonWindow;
               _loc2_.setSelected(_loc5_);
         }
         changePasswordField(_loc1_.doorMode == RoomSettingsData.const_128);
         Logger.log("CATEGORY ID: " + _loc1_.categoryId);
         setCategorySelection(_loc1_.categoryId);
         refreshMaxVisitors(_loc1_);
         setTag(var_775,_loc1_.tags[0]);
         setTag(var_777,_loc1_.tags[1]);
         if(var_1266)
         {
            if(_loc1_.allowPets)
            {
               this.var_1266.select();
            }
            else
            {
               this.var_1266.unselect();
            }
         }
         if(var_1268)
         {
            if(_loc1_.allowFoodConsume)
            {
               var_1268.select();
            }
            else
            {
               var_1268.unselect();
            }
         }
         this.clearErrors();
      }
      
      private function setTag(param1:TextFieldManager, param2:String) : void
      {
         param1.setText(param2 == null ? "" : param2);
      }
      
      public function load(param1:int) : void
      {
         this.var_413 = param1;
         _navigator.send(new GetRoomSettingsMessageComposer(var_413));
         if(var_1032 != null)
         {
            var_1032.visible = false;
         }
      }
      
      private function onSaveButtonClick(param1:WindowMouseEvent) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc2_:SaveableRoomSettingsData = new SaveableRoomSettingsData();
         _loc2_.roomId = var_104.roomId;
         _loc2_.name = var_854.getText();
         _loc2_.description = var_1267.getText();
         var _loc3_:ISelectorWindow = _window.findChildByName("doormode") as ISelectorWindow;
         var _loc4_:IWindow = _loc3_.getSelected();
         switch(_loc4_.name)
         {
            case "doormode_doorbell":
               _loc2_.doorMode = RoomSettingsFlatInfo.const_169;
               break;
            case "doormode_password":
               _loc2_.doorMode = RoomSettingsFlatInfo.const_128;
               break;
            default:
               _loc2_.doorMode = RoomSettingsFlatInfo.const_377;
         }
         if(_loc2_.doorMode == RoomSettingsFlatInfo.const_128)
         {
            _loc8_ = var_1030.getText();
            _loc9_ = var_1264.getText();
            if(_loc8_ != _loc9_)
            {
               this.var_1030.clearErrors();
               this.var_1264.displayError("${navigator.roomsettings.invalidconfirm}");
               return;
            }
            if(_loc8_ != "")
            {
               _loc2_.password = _loc8_;
            }
         }
         var _loc5_:IDropMenuWindow = _window.findChildByName("categories") as IDropMenuWindow;
         var _loc6_:FlatCategory = _navigator.data.getCategoryByIndex(_loc5_.selection);
         _loc2_.categoryId = _loc6_.nodeId;
         var _loc7_:IDropMenuWindow = _window.findChildByName("maxvisitors") as IDropMenuWindow;
         _loc2_.maximumVisitors = 10 + _loc7_.selection * 5;
         _loc2_.allowPets = var_1266.isSelected;
         _loc2_.allowFoodConsume = var_1268.isSelected;
         _loc2_.tags = new Array();
         addTag(var_775,_loc2_.tags);
         addTag(var_777,_loc2_.tags);
         this.clearErrors();
         this.var_1028 = _loc2_.roomId;
         _navigator.send(new SaveRoomSettingsMessageComposer(_loc2_));
      }
      
      private function getDeleteButton() : IButtonWindow
      {
         return IButtonWindow(_window.findChildByName("delete"));
      }
      
      private function onRemoveAllFlatCtrlsClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Remove all clicked: ");
         _navigator.send(new RemoveAllRightsMessageComposer(this.var_413));
      }
      
      public function onRoomSettingsSaved(param1:int) : void
      {
         if(param1 != this.var_413 || var_1028 < 1)
         {
            return;
         }
         close();
         this.var_412.roomSettingsRefreshNeeded();
      }
      
      public function onFlatControllerAdded(param1:int, param2:FlatControllerData) : void
      {
         if(param1 != this.var_413)
         {
            return;
         }
         if(!controllerExists(param2.userId))
         {
            this.var_104.controllers.splice(0,0,param2);
            ++this.var_104.controllerCount;
         }
         if(var_498)
         {
            this.var_412.roomSettingsRefreshNeeded();
         }
      }
      
      public function setCategorySelection(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = _navigator.data.getCategoryIndexById(param1);
         if(_loc2_ >= 0)
         {
            _loc3_ = _window.findChildByName("categories") as IDropMenuWindow;
            _loc3_.selection = _loc2_;
         }
      }
      
      public function onRoomSettingsSaveError(param1:int, param2:int, param3:String) : void
      {
         if(param1 != this.var_413 || var_1028 < 1)
         {
            return;
         }
         var_1028 = 0;
         if(param2 == RoomSettingsSaveErrorMessageParser.const_1159)
         {
            this.var_854.displayError("${navigator.roomsettings.roomnameismandatory}");
         }
         else if(param2 == RoomSettingsSaveErrorMessageParser.const_1274)
         {
            this.var_854.displayError("${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == RoomSettingsSaveErrorMessageParser.const_1189)
         {
            this.var_1267.displayError("${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == RoomSettingsSaveErrorMessageParser.const_1176)
         {
            setTagError(this.var_775,param3,"${navigator.roomsettings.unacceptablewords}");
            setTagError(this.var_777,param3,"${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == RoomSettingsSaveErrorMessageParser.const_1324)
         {
            setTagError(this.var_775,param3,"${navigator.roomsettings.nonuserchoosabletag}");
            setTagError(this.var_777,param3,"${navigator.roomsettings.nonuserchoosabletag}");
         }
         else if(param2 == RoomSettingsSaveErrorMessageParser.const_1124)
         {
            this.var_1030.displayError("${navigator.roomsettings.passwordismandatory}");
         }
         else
         {
            this.var_854.displayError("Update failed: error " + param2);
         }
      }
      
      public function close() : void
      {
         this._active = false;
         this.var_413 = 0;
         this.var_104 = null;
         this.var_1028 = 0;
      }
      
      private function prepareWindow(param1:IWindowContainer) : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(_navigator.getXmlWindow("ros_room_settings"));
         param1.addChildAt(_window,0);
         var _loc2_:IRadioButtonWindow = _window.findChildByName("doormode_password") as IRadioButtonWindow;
         _loc2_.addEventListener(WindowEvent.const_661,onDoorModePasswordSelect);
         _loc2_.addEventListener(WindowEvent.const_847,onDoorModePasswordUnselect);
         getSaveButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onSaveButtonClick);
         getCancelButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onCancelButtonClick);
         getDeleteButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onDeleteButtonClick);
         Util.setProc(_window,"edit_thumbnail",onEditThumbnailButtonClick);
         Util.setProc(_window,"remove_all_flat_ctrls",onRemoveAllFlatCtrlsClick);
         Util.setProc(_window,"remove_flat_ctrl",onRemoveFlatCtrlClick);
         refreshCategories();
         this.var_854 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("room_name")),60);
         this.var_1267 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("description")),255);
         this.var_775 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("tag1")),30);
         this.var_777 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("tag2")),30);
         this.var_1030 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("password")),30);
         this.var_1264 = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("password_confirm")),30);
         this.var_1266 = ICheckBoxWindow(_window.findChildByName("allow_pets_checkbox"));
         this.var_1268 = ICheckBoxWindow(_window.findChildByName("allow_foodconsume_checkbox"));
         var_1511 = IWindowContainer(_window.findChildByName("header_container"));
         var_1269 = IWindowContainer(_window.findChildByName("thumbnail_container"));
         var_1031 = IWindowContainer(_window.findChildByName("basic_settings_container"));
         var_1029 = IWindowContainer(_window.findChildByName("advanced_settings_container"));
         var_1512 = IWindowContainer(_window.findChildByName("switch_view_container"));
         var_1265 = IWindowContainer(_window.findChildByName("footer_container"));
         var_279 = IWindowContainer(_window.findChildByName("flat_controllers_container"));
         var_1032 = IWindowContainer(_window.findChildByName("password_container"));
         var_2112 = ITextWindow(_window.findChildByName("basic_caption"));
         var_2113 = ITextWindow(_window.findChildByName("advanced_caption"));
         var_1510 = ITextWindow(_window.findChildByName("switch_view_text"));
         var_1510.procedure = onSwitchView;
         var_1032.visible = false;
         if(!_inRoom)
         {
            _window.color = 4294967295;
            Util.setColors(_window,4278190080);
         }
      }
      
      private function refreshMaxVisitors(param1:RoomSettingsData) : void
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         var _loc5_:int = 10;
         while(_loc5_ <= param1.maximumVisitorsLimit)
         {
            _loc2_.push("" + _loc5_);
            if(_loc5_ == param1.maximumVisitors)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
            _loc5_ += 5;
         }
         var _loc6_:IDropMenuWindow = _window.findChildByName("maxvisitors") as IDropMenuWindow;
         _loc6_.populate(_loc2_);
         _loc6_.selection = _loc3_ > -1 ? int(_loc3_) : 0;
      }
   }
}
