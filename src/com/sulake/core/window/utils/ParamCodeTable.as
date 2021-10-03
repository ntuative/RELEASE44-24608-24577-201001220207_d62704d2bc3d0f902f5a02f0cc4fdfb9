package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowParam;
   import flash.utils.Dictionary;
   
   public class ParamCodeTable extends WindowParam
   {
       
      
      public function ParamCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["HabboWindowManagerCom_habbo_skin_border_slot_xml"] = const_97;
         param1["bound_to_parent_rect"] = const_78;
         param1["child_window"] = const_893;
         param1["embedded_controller"] = const_288;
         param1["resize_to_accommodate_children"] = const_62;
         param1["input_event_processor"] = const_48;
         param1["internal_event_handling"] = const_549;
         param1["mouse_dragging_target"] = const_194;
         param1["mouse_dragging_trigger"] = const_286;
         param1["mouse_scaling_target"] = const_233;
         param1["mouse_scaling_trigger"] = const_427;
         param1["horizontal_mouse_scaling_trigger"] = const_204;
         param1["vertical_mouse_scaling_trigger"] = const_210;
         param1["observe_parent_input_events"] = const_836;
         param1["optimize_region_to_layout_size"] = const_445;
         param1["parent_window"] = const_843;
         param1["relative_horizontal_scale_center"] = const_155;
         param1["relative_horizontal_scale_fixed"] = const_105;
         param1["relative_horizontal_scale_move"] = const_311;
         param1["relative_horizontal_scale_strech"] = const_257;
         param1["relative_scale_center"] = const_972;
         param1["relative_scale_fixed"] = const_552;
         param1["relative_scale_move"] = const_882;
         param1["relative_scale_strech"] = const_787;
         param1["relative_vertical_scale_center"] = const_156;
         param1["relative_vertical_scale_fixed"] = const_113;
         param1["relative_vertical_scale_move"] = const_276;
         param1["relative_vertical_scale_strech"] = const_232;
         param1["on_resize_align_left"] = const_550;
         param1["on_resize_align_right"] = const_478;
         param1["on_resize_align_center"] = const_426;
         param1["on_resize_align_top"] = const_678;
         param1["on_resize_align_bottom"] = const_466;
         param1["on_resize_align_middle"] = const_381;
         param1["on_accommodate_align_left"] = const_871;
         param1["on_accommodate_align_right"] = const_433;
         param1["on_accommodate_align_center"] = const_703;
         param1["on_accommodate_align_top"] = const_963;
         param1["on_accommodate_align_bottom"] = WINDOW_PARAM_ON_ACCOMMODATE_ALIGN_BOTTOM;
         param1["on_accommodate_align_middle"] = const_662;
         param1["route_input_events_to_parent"] = const_394;
         param1["use_parent_graphic_context"] = const_32;
         param1["draggable_with_mouse"] = const_965;
         param1["scalable_with_mouse"] = const_894;
         param1["reflect_horizontal_resize_to_parent"] = const_392;
         param1["reflect_vertical_resize_to_parent"] = WINDOW_PARAM_REFLECT_VERTICAL_RESIZE_TO_PARENT;
         param1["reflect_resize_to_parent"] = const_246;
         if(param2 != null)
         {
            for(_loc3_ in param1)
            {
               if(param2[param1[_loc3_]] != null)
               {
                  if(param1[_loc3_] != 0)
                  {
                     Logger.log("Conflictiong flags in window params: \"" + _loc3_ + "\"!");
                  }
               }
               param2[param1[_loc3_]] = _loc3_;
            }
         }
      }
   }
}
