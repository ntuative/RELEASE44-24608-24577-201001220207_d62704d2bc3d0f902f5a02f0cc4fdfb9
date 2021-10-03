package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   
   public class WindowNotifyEvent extends WindowEvent
   {
      
      public static const const_1293:String = "WN_CREATED";
      
      public static const const_872:String = "WN_DISABLE";
      
      public static const const_943:String = "WN_DEACTIVATED";
      
      public static const const_995:String = "WN_OPENED";
      
      public static const const_815:String = "WN_CLOSED";
      
      public static const const_993:String = "WN_DESTROY";
      
      public static const const_1452:String = "WN_ARRANGED";
      
      public static const const_395:String = "WN_PARENT_RESIZED";
      
      public static const const_896:String = "WN_ENABLE";
      
      public static const const_887:String = "WN_RELOCATE";
      
      public static const const_820:String = "WN_FOCUS";
      
      public static const const_907:String = "WN_PARENT_RELOCATED";
      
      public static const const_374:String = "WN_PARAM_UPDATED";
      
      public static const const_507:String = "WN_PARENT_ACTIVATED";
      
      public static const const_211:String = "WN_RESIZED";
      
      public static const const_938:String = "WN_CLOSE";
      
      public static const const_860:String = "WN_PARENT_REMOVED";
      
      public static const const_227:String = "WN_CHILD_RELOCATED";
      
      public static const const_555:String = "WN_ENABLED";
      
      public static const const_254:String = "WN_CHILD_RESIZED";
      
      public static const const_895:String = "WN_MINIMIZED";
      
      public static const const_509:String = "WN_DISABLED";
      
      public static const const_208:String = "WN_CHILD_ACTIVATED";
      
      public static const const_453:String = "WN_STATE_UPDATED";
      
      public static const const_602:String = "WN_UNSELECTED";
      
      public static const const_376:String = "WN_STYLE_UPDATED";
      
      public static const const_1499:String = "WN_UPDATE";
      
      public static const const_387:String = "WN_PARENT_ADDED";
      
      public static const const_670:String = "WN_RESIZE";
      
      public static const const_693:String = "WN_CHILD_REMOVED";
      
      public static const const_1518:String = "";
      
      public static const const_921:String = "WN_RESTORED";
      
      public static const const_306:String = "WN_SELECTED";
      
      public static const const_835:String = "WN_MINIMIZE";
      
      public static const const_908:String = "WN_FOCUSED";
      
      public static const const_1248:String = "WN_LOCK";
      
      public static const const_289:String = "WN_CHILD_ADDED";
      
      public static const const_960:String = "WN_UNFOCUSED";
      
      public static const const_386:String = "WN_RELOCATED";
      
      public static const const_901:String = "WN_DEACTIVATE";
      
      public static const const_1225:String = "WN_CRETAE";
      
      public static const const_942:String = "WN_RESTORE";
      
      public static const const_319:String = "WN_ACTVATED";
      
      public static const const_1256:String = "WN_LOCKED";
      
      public static const const_444:String = "WN_SELECT";
      
      public static const const_980:String = "WN_MAXIMIZE";
      
      public static const const_992:String = "WN_OPEN";
      
      public static const const_618:String = "WN_UNSELECT";
      
      public static const const_1560:String = "WN_ARRANGE";
      
      public static const const_1241:String = "WN_UNLOCKED";
      
      public static const const_1457:String = "WN_UPDATED";
      
      public static const const_918:String = "WN_ACTIVATE";
      
      public static const const_1341:String = "WN_UNLOCK";
      
      public static const const_945:String = "WN_MAXIMIZED";
      
      public static const const_970:String = "WN_DESTROYED";
      
      public static const const_958:String = "WN_UNFOCUS";
       
      
      public function WindowNotifyEvent(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false)
      {
         super(param1,param2,param3,false,param4);
      }
      
      override public function toString() : String
      {
         return formatToString("WindowNotifyEvent","type","cancelable");
      }
      
      override public function clone() : Event
      {
         return new WindowNotifyEvent(type,_window,var_1551,cancelable);
      }
   }
}
