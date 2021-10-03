package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.utils.getTimer;
   
   public class LagWarningLogger
   {
      
      public static const const_966:int = 0;
      
      public static const WARNING_TYPE_CHAT_DELAY:int = 1;
       
      
      private var var_1293:Boolean = true;
      
      private var var_1283:int = 0;
      
      private var var_820:int = 0;
      
      private var var_1194:int = 0;
      
      private var var_821:int = 0;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_1280:int = 15;
      
      private var var_180:IHabboConfigurationManager;
      
      private var _connection:IConnection;
      
      private var var_1281:int = 60;
      
      public function LagWarningLogger()
      {
         super();
         var_1194 = getTimer();
      }
      
      public function logWarnings() : void
      {
         if(!var_1293)
         {
            return;
         }
         if(nothingToReport)
         {
            return;
         }
         var _loc1_:LagWarningReportMessageComposer = new LagWarningReportMessageComposer(var_820,var_821);
         if(_connection != null)
         {
            _connection.send(_loc1_);
         }
         resetLog();
         ++var_1283;
      }
      
      private function get nothingToReport() : Boolean
      {
         return var_820 == 0 && var_821 == 0;
      }
      
      private function resetLog() : void
      {
         var_820 = 0;
         var_821 = 0;
      }
      
      public function update(param1:uint) : void
      {
         if(!var_1293)
         {
            return;
         }
         if(getTimer() - var_1194 > var_1281 * 1000 && var_1283 < var_1280)
         {
            var_1194 = getTimer();
            logWarnings();
         }
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         var_180 = param1;
         var_1281 = int(var_180.getKey("lagwarninglog.interval","60"));
         var_1280 = int(var_180.getKey("lagwarninglog.reportlimit","15"));
         var_1293 = Boolean(int(var_180.getKey("lagwarninglog.enabled","1")));
      }
      
      public function registerWarning(param1:int) : void
      {
         switch(param1)
         {
            case WARNING_TYPE_CHAT_DELAY:
               var_821 += 1;
            case const_966:
               var_820 += 1;
         }
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         _connection = param1;
      }
   }
}
