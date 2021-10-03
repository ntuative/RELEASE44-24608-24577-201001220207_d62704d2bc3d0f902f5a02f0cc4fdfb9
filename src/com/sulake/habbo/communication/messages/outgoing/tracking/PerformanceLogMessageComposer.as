package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PerformanceLogMessageComposer implements IMessageComposer
   {
       
      
      private var var_1038:int = 0;
      
      private var var_1149:int = 0;
      
      private var var_1850:String = "";
      
      private var var_1037:int = 0;
      
      private var var_1845:String = "";
      
      private var var_1849:int = 0;
      
      private var var_1533:String = "";
      
      private var var_1847:int = 0;
      
      private var var_1851:int = 0;
      
      private var var_1846:String = "";
      
      private var var_1848:int = 0;
      
      public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
      {
         super();
         var_1847 = param1;
         var_1846 = param2;
         var_1533 = param3;
         var_1850 = param4;
         var_1845 = param5;
         if(param6)
         {
            var_1149 = 1;
         }
         else
         {
            var_1149 = 0;
         }
         var_1849 = param7;
         var_1851 = param8;
         var_1037 = param9;
         var_1848 = param10;
         var_1038 = param11;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1847,var_1846,var_1533,var_1850,var_1845,var_1149,var_1849,var_1851,var_1037,var_1848,var_1038];
      }
      
      public function dispose() : void
      {
      }
   }
}
