package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.utils.getTimer;
   
   public class LatencyTracker
   {
       
      
      private var var_155:Array;
      
      private var var_46:Boolean = false;
      
      private var var_1362:int = 0;
      
      private var var_1361:int = 0;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_437:Map;
      
      private var var_1676:int = 0;
      
      private var var_1359:int = 0;
      
      private var var_180:IHabboConfigurationManager;
      
      private var var_1104:int = 0;
      
      private var _connection:IConnection;
      
      private var var_1360:int = 0;
      
      public function LatencyTracker()
      {
         super();
      }
      
      public function update(param1:uint) : void
      {
         if(!var_46)
         {
            return;
         }
         if(getTimer() - var_1362 > var_1361)
         {
            testLatency();
         }
      }
      
      private function testLatency() : void
      {
         var_1362 = getTimer();
         var_437.add(var_1104,var_1362);
         _connection.send(new LatencyPingRequestMessageComposer(var_1104));
         ++var_1104;
      }
      
      public function set communication(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
      }
      
      public function init() : void
      {
         if(var_180 == null || _communication == null || _connection == null)
         {
            return;
         }
         var_1361 = int(var_180.getKey("latencytest.interval"));
         var_1360 = int(var_180.getKey("latencytest.report.index"));
         var_1676 = int(var_180.getKey("latencytest.report.delta"));
         _communication.addHabboConnectionMessageEvent(new LatencyPingResponseMessageEvent(onPingResponse));
         if(var_1361 < 1)
         {
            return;
         }
         var_437 = new Map();
         var_155 = new Array();
         var_46 = true;
      }
      
      private function onPingResponse(param1:IMessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         if(var_437 == null || var_155 == null)
         {
            return;
         }
         var _loc2_:LatencyPingResponseMessageParser = (param1 as LatencyPingResponseMessageEvent).getParser();
         var _loc3_:int = var_437.getValue(_loc2_.requestId);
         var_437.remove(_loc2_.requestId);
         var _loc4_:int = getTimer() - _loc3_;
         var_155.push(_loc4_);
         if(var_155.length == var_1360 && var_1360 > 0)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < var_155.length)
            {
               _loc5_ += var_155[_loc8_];
               _loc8_++;
            }
            _loc9_ = _loc5_ / 0;
            _loc8_ = 0;
            while(_loc8_ < var_155.length)
            {
               if(var_155[_loc8_] < _loc9_ * 2)
               {
                  _loc6_ += var_155[_loc8_];
                  _loc7_++;
               }
               _loc8_++;
            }
            if(_loc7_ == 0)
            {
               var_155 = [];
               return;
            }
            _loc10_ = _loc6_ / _loc7_;
            if(Math.abs(_loc9_ - var_1359) > var_1676 || var_1359 == 0)
            {
               var_1359 = _loc9_;
               _loc11_ = new LatencyPingReportMessageComposer(_loc9_,_loc10_,var_155.length);
               _connection.send(_loc11_);
            }
            var_155 = [];
         }
      }
      
      public function dispose() : void
      {
         var_46 = false;
         var_180 = null;
         _communication = null;
         _connection = null;
         if(var_437 != null)
         {
            var_437.dispose();
            var_437 = null;
         }
         var_155 = null;
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         var_180 = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         _connection = param1;
      }
   }
}
