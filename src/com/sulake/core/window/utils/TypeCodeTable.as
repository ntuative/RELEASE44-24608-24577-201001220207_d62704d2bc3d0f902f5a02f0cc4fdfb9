package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class TypeCodeTable extends WindowType
   {
       
      
      public function TypeCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["background"] = const_729;
         param1["bitmap"] = const_677;
         param1["border"] = const_711;
         param1["border_notify"] = const_1315;
         param1["button"] = const_463;
         param1["button_thick"] = const_541;
         param1["button_icon"] = const_1275;
         param1["button_group_left"] = const_512;
         param1["button_group_center"] = const_658;
         param1["button_group_right"] = const_567;
         param1["canvas"] = const_648;
         param1["checkbox"] = const_568;
         param1["closebutton"] = const_998;
         param1["container"] = const_298;
         param1["container_button"] = const_496;
         param1["display_object_wrapper"] = const_566;
         param1["dropmenu"] = const_393;
         param1["dropmenu_item"] = const_429;
         param1["frame"] = const_314;
         param1["frame_notify"] = const_1319;
         param1["header"] = const_565;
         param1["icon"] = const_780;
         param1["itemgrid"] = const_795;
         param1["itemgrid_horizontal"] = const_471;
         param1["itemgrid_vertical"] = const_559;
         param1["itemlist"] = const_849;
         param1["itemlist_horizontal"] = const_277;
         param1["itemlist_vertical"] = const_287;
         param1["maximizebox"] = const_1234;
         param1["menu"] = const_1223;
         param1["menu_item"] = WINDOW_TYPE_MENU_ITEM;
         param1["submenu"] = const_797;
         param1["minimizebox"] = const_1339;
         param1["notify"] = const_1147;
         param1["HabboWindowManagerCom_habbo_skin_border_slot_xml"] = const_440;
         param1["password"] = const_653;
         param1["radiobutton"] = const_539;
         param1["region"] = const_419;
         param1["restorebox"] = const_1253;
         param1["scaler"] = const_883;
         param1["scaler_horizontal"] = const_1285;
         param1["scaler_vertical"] = const_1188;
         param1["scrollbar_horizontal"] = const_476;
         param1["scrollbar_vertical"] = const_494;
         param1["scrollbar_slider_button_up"] = const_910;
         param1["scrollbar_slider_button_down"] = const_911;
         param1["scrollbar_slider_button_left"] = const_948;
         param1["scrollbar_slider_button_right"] = const_829;
         param1["scrollbar_slider_bar_horizontal"] = const_813;
         param1["scrollbar_slider_bar_vertical"] = const_792;
         param1["scrollbar_slider_track_horizontal"] = const_799;
         param1["scrollbar_slider_track_vertical"] = const_885;
         param1["scrollable_itemlist"] = const_1336;
         param1["scrollable_itemlist_vertical"] = const_368;
         param1["scrollable_itemlist_horizontal"] = const_891;
         param1["selector"] = const_623;
         param1["selector_list"] = const_543;
         param1["submenu"] = const_797;
         param1["tab_button"] = const_546;
         param1["tab_container_button"] = const_968;
         param1["tab_context"] = const_350;
         param1["tab_content"] = const_975;
         param1["tab_selector"] = WINDOW_TYPE_TAB_SELECTOR;
         param1["text"] = const_709;
         param1["input"] = const_610;
         param1["toolbar"] = const_1148;
         param1["tooltip"] = WINDOW_TYPE_TOOLTIP;
         if(param2 != null)
         {
            for(_loc3_ in param1)
            {
               if(param2[param1[_loc3_]] != null)
               {
                  Logger.log("Overlapping window type code " + _loc3_ + "!");
               }
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}
