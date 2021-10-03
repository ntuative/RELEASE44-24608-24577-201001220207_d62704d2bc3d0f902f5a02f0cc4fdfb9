package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   
   public class WindowEvent extends Event
   {
      
      public static const const_312:String = "WE_CHILD_RESIZED";
      
      public static const const_1352:String = "WE_CLOSE";
      
      public static const const_1245:String = "WE_DESTROY";
      
      public static const const_135:String = "WE_CHANGE";
      
      public static const const_1328:String = "WE_RESIZE";
      
      public static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
      
      public static const const_1508:String = "WE_PARENT_RESIZE";
      
      public static const const_86:String = "WE_UPDATE";
      
      public static const const_1298:String = "WE_MAXIMIZE";
      
      public static const const_400:String = "WE_DESTROYED";
      
      public static const const_847:String = "WE_UNSELECT";
      
      public static const const_1142:String = "WE_MAXIMIZED";
      
      public static const const_1571:String = "WE_UNLOCKED";
      
      public static const const_436:String = "WE_CHILD_REMOVED";
      
      public static const const_166:String = "WE_OK";
      
      public static const const_44:String = "WE_RESIZED";
      
      public static const const_1187:String = "WE_ACTIVATE";
      
      public static const const_225:String = "WE_ENABLED";
      
      public static const const_365:String = "WE_CHILD_RELOCATED";
      
      public static const const_1266:String = "WE_CREATE";
      
      public static const const_661:String = "WE_SELECT";
      
      public static const const_173:String = "";
      
      public static const const_1572:String = "WE_LOCKED";
      
      public static const const_1585:String = "WE_PARENT_RELOCATE";
      
      public static const const_1555:String = "WE_CHILD_REMOVE";
      
      public static const const_1537:String = "WE_CHILD_RELOCATE";
      
      public static const const_1530:String = "WE_LOCK";
      
      public static const const_269:String = "WE_FOCUSED";
      
      public static const const_651:String = "WE_UNSELECTED";
      
      public static const const_801:String = "WE_DEACTIVATED";
      
      public static const const_1237:String = "WE_MINIMIZED";
      
      public static const const_1474:String = "WE_ARRANGED";
      
      public static const const_1471:String = "WE_UNLOCK";
      
      public static const const_1559:String = "WE_ATTACH";
      
      public static const const_1364:String = "WE_OPEN";
      
      public static const const_1321:String = "WE_RESTORE";
      
      public static const const_1551:String = "WE_PARENT_RELOCATED";
      
      public static const const_1311:String = "WE_RELOCATE";
      
      public static const const_1528:String = "WE_CHILD_RESIZE";
      
      public static const const_1466:String = "WE_ARRANGE";
      
      public static const const_1139:String = "WE_OPENED";
      
      public static const const_1221:String = "WE_CLOSED";
      
      public static const const_1574:String = "WE_DETACHED";
      
      public static const const_1519:String = "WE_UPDATED";
      
      public static const const_1149:String = "WE_UNFOCUSED";
      
      public static const const_378:String = "WE_RELOCATED";
      
      public static const const_1154:String = "WE_DEACTIVATE";
      
      public static const const_196:String = "WE_DISABLED";
      
      public static const const_536:String = "WE_CANCEL";
      
      public static const const_582:String = "WE_ENABLE";
      
      public static const const_1294:String = "WE_ACTIVATED";
      
      public static const const_1278:String = "WE_FOCUS";
      
      public static const const_1553:String = "WE_DETACH";
      
      public static const const_1344:String = "WE_RESTORED";
      
      public static const const_1122:String = "WE_UNFOCUS";
      
      public static const const_52:String = "WE_SELECTED";
      
      public static const const_1354:String = "WE_PARENT_RESIZED";
      
      public static const const_1235:String = "WE_CREATED";
      
      public static const const_1532:String = "WE_ATTACHED";
      
      public static const const_1366:String = "WE_MINIMIZE";
      
      public static const WINDOW_EVENT_DISABLE:String = "WE_DISABLE";
       
      
      protected var _type:String = "";
      
      protected var var_1551:IWindow;
      
      protected var _window:IWindow;
      
      protected var var_1320:Boolean;
      
      public function WindowEvent(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false, param5:Boolean = false)
      {
         _type = param1;
         _window = param2;
         var_1551 = param3;
         var_1320 = false;
         super(param1,param4,param5);
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return var_1320;
      }
      
      public function get related() : IWindow
      {
         return var_1551;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      override public function get type() : String
      {
         return _type;
      }
      
      override public function toString() : String
      {
         return formatToString("WindowEvent","type","bubbles","cancelable","window");
      }
      
      override public function clone() : Event
      {
         return new WindowEvent(_type,window,related,bubbles,cancelable);
      }
      
      public function preventWindowOperation() : void
      {
         if(cancelable)
         {
            var_1320 = true;
            stopImmediatePropagation();
            return;
         }
         throw new Error("Attempted to prevent window operation that is not canceable!");
      }
   }
}
