package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.handler.AvatarEffectsHandler;
   import com.sulake.habbo.session.handler.BaseHandler;
   import com.sulake.habbo.session.handler.GenericErrorHandler;
   import com.sulake.habbo.session.handler.LidoHandler;
   import com.sulake.habbo.session.handler.PlaceObjectErrorHandler;
   import com.sulake.habbo.session.handler.PollHandler;
   import com.sulake.habbo.session.handler.PresentHandler;
   import com.sulake.habbo.session.handler.RoomChatHandler;
   import com.sulake.habbo.session.handler.RoomDataHandler;
   import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
   import com.sulake.habbo.session.handler.RoomPermissionsHandler;
   import com.sulake.habbo.session.handler.RoomSessionHandler;
   import com.sulake.habbo.session.handler.RoomUsersHandler;
   import com.sulake.habbo.session.handler.TeleportErrorHandler;
   import com.sulake.habbo.session.handler.VoteHandler;
   import com.sulake.iid.IIDHabboCommunicationManager;
   
   public class RoomSessionManager extends Component implements IRoomSessionManager, IRoomHandlerListener
   {
       
      
      private var _connection:IConnection = null;
      
      private var var_93:Array = null;
      
      private var var_2018:int = 0;
      
      private var var_1230:String = "";
      
      private var var_778:Boolean = false;
      
      private var _communication:IHabboCommunicationManager = null;
      
      private var var_1229:Boolean = false;
      
      private var var_2020:Boolean = false;
      
      private var var_2019:Boolean = false;
      
      private var var_836:Boolean = false;
      
      private var var_203:Map = null;
      
      public function RoomSessionManager(param1:IContext, param2:uint = 0)
      {
         super(param1,param2);
         var_93 = [];
         var_203 = new Map();
         queueInterface(new IIDHabboCommunicationManager(),communicationReady);
      }
      
      public function gotoRoom(param1:Boolean, param2:int, param3:String = "", param4:String = "") : Boolean
      {
         if(!initialized)
         {
            var_1229 = true;
            var_2020 = param1;
            var_2018 = param2;
            var_1230 = param3;
            return false;
         }
         var _loc5_:int = 0;
         if(param1)
         {
            _loc5_ = 1;
         }
         var _loc6_:String = getRoomIdentifier(param2,_loc5_);
         var_836 = true;
         if(var_203.getValue(_loc6_) != null)
         {
            disposeSession(param2,_loc5_);
         }
         var _loc7_:RoomSession = new RoomSession(param2,_loc5_,param3,param4);
         _loc7_.connection = _connection;
         var_203.add(_loc6_,_loc7_);
         _events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_282,_loc7_));
         return true;
      }
      
      private function initializeManager() : void
      {
         if(_communication != null)
         {
            var_778 = true;
         }
         if(initialized && var_1229)
         {
            gotoRoom(var_2020,var_2018,var_1230);
            var_1229 = false;
            var_1230 = "";
         }
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            _connection = param1;
            createHandlers();
            initializeManager();
         }
      }
      
      public function set roomEngineReady(param1:Boolean) : void
      {
         var_2019 = param1;
         initializeManager();
      }
      
      public function get initialized() : Boolean
      {
         if(var_778 && var_2019)
         {
            return true;
         }
         return false;
      }
      
      private function updateHandlers(param1:IRoomSession) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1 != null && var_93 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_93.length)
            {
               _loc3_ = var_93[_loc2_] as BaseHandler;
               if(_loc3_ != null)
               {
                  _loc3_._xxxRoomId = param1.roomId;
                  _loc3_._xxxRoomCategory = param1.roomCategory;
               }
               _loc2_++;
            }
         }
      }
      
      public function startSession(param1:IRoomSession) : Boolean
      {
         if(param1.state == RoomSessionEvent.const_88)
         {
            return false;
         }
         if(param1.start())
         {
            var_836 = false;
            _events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_88,param1));
            updateHandlers(param1);
            return true;
         }
         disposeSession(param1.roomId,param1.roomCategory);
         var_836 = false;
         return false;
      }
      
      private function createHandlers() : void
      {
         if(_connection == null)
         {
            return;
         }
         var_93.push(new RoomSessionHandler(_connection,this));
         var_93.push(new RoomChatHandler(_connection,this));
         var_93.push(new RoomUsersHandler(_connection,this));
         var_93.push(new RoomPermissionsHandler(_connection,this));
         var_93.push(new AvatarEffectsHandler(_connection,this));
         var_93.push(new RoomDataHandler(_connection,this));
         var_93.push(new PresentHandler(_connection,this));
         var_93.push(new PlaceObjectErrorHandler(_connection,this));
         var_93.push(new TeleportErrorHandler(_connection,this));
         var_93.push(new GenericErrorHandler(_connection,this));
         var_93.push(new PollHandler(_connection,this));
         var_93.push(new VoteHandler(_connection,this));
         var_93.push(new LidoHandler(_connection,this));
         var_93.push(new RoomDimmerPresetsHandler(_connection,this));
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         super.dispose();
         if(_communication != null)
         {
            release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         _connection = null;
         if(var_203)
         {
            while(false)
            {
               _loc1_ = var_203.getKey(0) as String;
               _loc2_ = var_203.remove(_loc1_) as RoomSession;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            var_203.dispose();
            var_203 = null;
         }
         if(var_93)
         {
            _loc3_ = 0;
            while(_loc3_ < var_93.length)
            {
               _loc4_ = var_93[_loc3_] as IDisposable;
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
               _loc3_++;
            }
            var_93 = null;
         }
      }
      
      private function getRoomIdentifier(param1:int, param2:int) : String
      {
         return "hard_coded_room_id";
      }
      
      private function communicationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _communication = param2 as IHabboCommunicationManager;
         if(_communication != null)
         {
            _connection = _communication.getHabboMainConnection(onConnectionReady);
            if(_connection != null)
            {
               onConnectionReady(_connection);
            }
         }
      }
      
      public function getSession(param1:int, param2:int) : IRoomSession
      {
         var _loc3_:String = getRoomIdentifier(param1,param2);
         return var_203.getValue(_loc3_) as IRoomSession;
      }
      
      public function get sessionStarting() : Boolean
      {
         return var_836;
      }
      
      public function sessionReinitialize(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc7_:* = null;
         var _loc5_:String = getRoomIdentifier(param1,param2);
         var _loc6_:RoomSession = var_203.remove(_loc5_) as RoomSession;
         if(_loc6_ != null)
         {
            param4 = param2;
            _loc6_.reset(param3,param4);
            _loc5_ = getRoomIdentifier(param3,param4);
            _loc7_ = var_203.remove(_loc5_);
            if(_loc7_ != null)
            {
            }
            var_203.add(_loc5_,_loc6_);
            updateHandlers(_loc6_);
         }
      }
      
      public function disposeSession(param1:int, param2:int) : void
      {
         var _loc3_:String = getRoomIdentifier(param1,param2);
         var _loc4_:RoomSession = var_203.remove(_loc3_) as RoomSession;
         if(_loc4_ != null)
         {
            _events.dispatchEvent(new RoomSessionEvent(RoomSessionEvent.const_96,_loc4_));
            _loc4_.dispose();
         }
      }
      
      public function sessionUpdate(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:IRoomSession = getSession(param1,param2);
         if(_loc4_ != null)
         {
            switch(param3)
            {
               case RoomSessionHandler.SESSION_CONNECTED:
                  break;
               case RoomSessionHandler.SESSION_READY:
                  break;
               case RoomSessionHandler.SESSION_DISCONNECTED:
                  disposeSession(param1,param2);
            }
         }
      }
   }
}
