package deng.fzip
{
   import deng.utils.ChecksumUtil;
   import flash.utils.*;
   
   public class FZipFile
   {
      
      public static const const_657:int = 8;
      
      public static const const_1433:int = 10;
      
      public static const const_1130:int = 6;
      
      private static var var_985:Boolean = describeType(ByteArray).factory.method.(@name == "uncompress").hasComplexContent();
      
      public static const const_1272:int = 0;
      
      public static const const_1534:int = 1;
      
      public static const const_1489:int = 2;
      
      public static const const_1522:int = 3;
      
      public static const const_1438:int = 4;
      
      public static const const_1460:int = 5;
      
      public static const const_1464:int = 9;
      
      public static const const_1435:int = 7;
       
      
      private var var_176:uint = 0;
      
      private var var_986:uint = 0;
      
      private var var_665:Date;
      
      private var var_1960:int = -1;
      
      private var parseFunc:Function;
      
      private var var_472:Boolean = false;
      
      private var var_2265:int = -1;
      
      private var var_1201:uint = 0;
      
      private var var_1959:String = "";
      
      private var _extraFields:Dictionary;
      
      private var var_824:uint;
      
      private var var_35:ByteArray;
      
      private var var_663:uint;
      
      private var var_1468:Boolean = false;
      
      private var var_2266:int = -1;
      
      private var var_1466:String = "2.0";
      
      private var var_175:Boolean = false;
      
      private var var_1961:Boolean = false;
      
      private var var_349:String;
      
      private var var_554:uint = 0;
      
      private var var_1200:int = 0;
      
      private var var_394:String = "";
      
      private var var_664:int = 8;
      
      private var var_1467:Boolean = false;
      
      public function FZipFile(param1:String = "utf-8")
      {
         parseFunc = parseFileHead;
         super();
         var_349 = param1;
         _extraFields = new Dictionary();
         var_35 = new ByteArray();
         var_35.endian = Endian.BIG_ENDIAN;
      }
      
      public function get sizeUncompressed() : uint
      {
         return var_554;
      }
      
      public function set filename(param1:String) : void
      {
         var_394 = param1;
      }
      
      protected function uncompress() : void
      {
         if(var_175 && false)
         {
            var_35.position = 0;
            if(var_985)
            {
               var_35.uncompress.apply(var_35,["deflate"]);
            }
            else
            {
               var_35.uncompress();
            }
            var_35.position = 0;
            var_175 = false;
         }
      }
      
      public function get filename() : String
      {
         return var_394;
      }
      
      public function get date() : Date
      {
         return var_665;
      }
      
      function parse(param1:IDataInput) : Boolean
      {
         while(param1.bytesAvailable && parseFunc(param1))
         {
         }
         return parseFunc === parseFileIdle;
      }
      
      private function parseFileContent(param1:IDataInput) : Boolean
      {
         if(var_1467)
         {
            parseFunc = parseFileIdle;
            throw new Error("Data descriptors are not supported.");
         }
         if(var_176 == 0)
         {
            parseFunc = parseFileIdle;
         }
         else
         {
            if(param1.bytesAvailable < var_176)
            {
               return false;
            }
            parseContent(param1);
            parseFunc = parseFileIdle;
         }
         return true;
      }
      
      public function get versionNumber() : String
      {
         return var_1466;
      }
      
      public function getContentAsString(param1:Boolean = true, param2:String = "utf-8") : String
      {
         var _loc3_:* = null;
         if(var_175)
         {
            uncompress();
         }
         var_35.position = 0;
         if(param2 == "utf-8")
         {
            _loc3_ = var_35.readUTFBytes(var_35.bytesAvailable);
         }
         else
         {
            _loc3_ = var_35.readMultiByte(var_35.bytesAvailable,param2);
         }
         var_35.position = 0;
         if(param1)
         {
            compress();
         }
         return _loc3_;
      }
      
      private function parseFileIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseContent(param1:IDataInput) : void
      {
         var _loc2_:* = 0;
         if(var_664 === const_657 && !var_1468)
         {
            if(var_985)
            {
               param1.readBytes(var_35,0,var_176);
            }
            else
            {
               if(!var_472)
               {
                  throw new Error("Adler32 checksum not found.");
               }
               var_35.writeByte(120);
               _loc2_ = uint(~var_1960 << 6 & 192);
               _loc2_ += 31 - (30720 | _loc2_) % 31;
               var_35.writeByte(_loc2_);
               param1.readBytes(var_35,2,var_176);
               var_35.position = var_35.length;
               var_35.writeUnsignedInt(var_824);
            }
            var_175 = true;
         }
         else
         {
            if(var_664 != const_1272)
            {
               throw new Error("Compression method " + var_664 + " is not supported.");
            }
            param1.readBytes(var_35,0,var_176);
            var_175 = false;
         }
         var_35.position = 0;
      }
      
      private function parseFileHead(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= 30)
         {
            parseHead(param1);
            if(var_986 + var_1201 > 0)
            {
               parseFunc = parseFileHeadExt;
            }
            else
            {
               parseFunc = parseFileContent;
            }
            return true;
         }
         return false;
      }
      
      public function setContentAsString(param1:String, param2:String = "utf-8") : void
      {
         var_35.length = 0;
         var_35.position = 0;
         var_175 = false;
         if(param1 != null && param1.length > 0)
         {
            if(param2 == "utf-8")
            {
               var_35.writeUTFBytes(param1);
            }
            else
            {
               var_35.writeMultiByte(param1,param2);
            }
            var_663 = ChecksumUtil.CRC32(var_35);
            var_472 = false;
         }
         compress();
      }
      
      public function set date(param1:Date) : void
      {
         var_665 = param1 != null ? param1 : new Date();
      }
      
      public function serialize(param1:IDataOutput, param2:Boolean, param3:Boolean = false, param4:uint = 0) : uint
      {
         var _loc10_:* = null;
         var _loc15_:* = null;
         var _loc16_:Boolean = false;
         if(param1 == null)
         {
            return 0;
         }
         if(param3)
         {
            param1.writeUnsignedInt(33639248);
            param1.writeShort(var_1200 << 8 | 20);
         }
         else
         {
            param1.writeUnsignedInt(67324752);
         }
         param1.writeShort(var_1200 << 8 | 20);
         param1.writeShort(var_349 == "utf-8" ? 2048 : 0);
         param1.writeShort(const_657);
         var _loc5_:Date = var_665 != null ? var_665 : new Date();
         var _loc6_:uint = uint(_loc5_.getSeconds()) | uint(_loc5_.getMinutes()) << 5 | uint(_loc5_.getHours()) << 11;
         var _loc7_:uint = uint(_loc5_.getDate()) | uint(_loc5_.getMonth() + 1) << 5 | uint(_loc5_.getFullYear() - 1980) << 9;
         param1.writeShort(_loc6_);
         param1.writeShort(_loc7_);
         param1.writeUnsignedInt(var_663);
         param1.writeUnsignedInt(var_176);
         param1.writeUnsignedInt(var_554);
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.endian = Endian.LITTLE_ENDIAN;
         if(var_349 == "utf-8")
         {
            _loc8_.writeUTFBytes(var_394);
         }
         else
         {
            _loc8_.writeMultiByte(var_394,var_349);
         }
         var _loc9_:uint = _loc8_.position;
         for(_loc10_ in _extraFields)
         {
            _loc15_ = _extraFields[_loc10_] as ByteArray;
            if(_loc15_ != null)
            {
               _loc8_.writeShort(uint(_loc10_));
               _loc8_.writeShort(uint(_loc15_.length));
               _loc8_.writeBytes(_loc15_);
            }
         }
         if(param2)
         {
            if(!var_472)
            {
               _loc16_ = var_175;
               if(_loc16_)
               {
                  uncompress();
               }
               var_824 = ChecksumUtil.Adler32(var_35,0,var_35.length);
               var_472 = true;
               if(_loc16_)
               {
                  compress();
               }
            }
            _loc8_.writeShort(56026);
            _loc8_.writeShort(4);
            _loc8_.writeUnsignedInt(var_824);
         }
         var _loc11_:uint = _loc8_.position - _loc9_;
         if(param3 && false)
         {
            if(var_349 == "utf-8")
            {
               _loc8_.writeUTFBytes(var_1959);
            }
            else
            {
               _loc8_.writeMultiByte(var_1959,var_349);
            }
         }
         var _loc12_:uint = _loc8_.position - _loc9_ - _loc11_;
         param1.writeShort(_loc9_);
         param1.writeShort(_loc11_);
         if(param3)
         {
            param1.writeShort(_loc12_);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeUnsignedInt(0);
            param1.writeUnsignedInt(param4);
         }
         if(_loc9_ + _loc11_ + _loc12_ > 0)
         {
            param1.writeBytes(_loc8_);
         }
         var _loc13_:int = 0;
         if(!param3 && var_176 > 0)
         {
            if(var_985)
            {
               _loc13_ = 0;
               param1.writeBytes(var_35,0,_loc13_);
            }
            else
            {
               _loc13_ = 4294967290;
               param1.writeBytes(var_35,2,_loc13_);
            }
         }
         var _loc14_:uint = 30 + _loc9_ + _loc11_ + _loc12_ + _loc13_;
         if(param3)
         {
            _loc14_ += 16;
         }
         return _loc14_;
      }
      
      public function get sizeCompressed() : uint
      {
         return var_176;
      }
      
      protected function compress() : void
      {
         if(!var_175)
         {
            if(false)
            {
               var_35.position = 0;
               var_554 = var_35.length;
               if(var_985)
               {
                  var_35.compress.apply(var_35,["deflate"]);
                  var_176 = var_35.length;
               }
               else
               {
                  var_35.compress();
                  var_176 = -6;
               }
               var_35.position = 0;
               var_175 = true;
            }
            else
            {
               var_176 = 0;
               var_554 = 0;
            }
         }
      }
      
      private function parseFileHeadExt(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= var_986 + var_1201)
         {
            parseHeadExt(param1);
            parseFunc = parseFileContent;
            return true;
         }
         return false;
      }
      
      protected function parseHeadExt(param1:IDataInput) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         if(var_349 == "utf-8")
         {
            var_394 = param1.readUTFBytes(var_986);
         }
         else
         {
            var_394 = param1.readMultiByte(var_986,var_349);
         }
         var _loc2_:uint = var_1201;
         while(_loc2_ > 4)
         {
            _loc3_ = uint(param1.readUnsignedShort());
            _loc4_ = uint(param1.readUnsignedShort());
            if(_loc4_ > _loc2_)
            {
               throw new Error("Parse error in file " + var_394 + ": Extra field data size too big.");
            }
            if(_loc3_ === 56026 && _loc4_ === 4)
            {
               var_824 = param1.readUnsignedInt();
               var_472 = true;
            }
            else if(_loc4_ > 0)
            {
               _loc5_ = new ByteArray();
               param1.readBytes(_loc5_,0,_loc4_);
               _extraFields[_loc3_] = _loc5_;
            }
            _loc2_ -= _loc4_ + 4;
         }
         if(_loc2_ > 0)
         {
            param1.readBytes(new ByteArray(),0,_loc2_);
         }
      }
      
      protected function parseHead(param1:IDataInput) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         var_1200 = _loc2_ >> 8;
         var_1466 = Math.floor((_loc2_ & 255) / 10) + "." + (_loc2_ & 255) % 10;
         var _loc3_:uint = param1.readUnsignedShort();
         var_664 = param1.readUnsignedShort();
         var_1468 = (_loc3_ & 1) !== 0;
         var_1467 = (_loc3_ & 8) !== 0;
         var_1961 = (_loc3_ & 32) !== 0;
         if((_loc3_ & 800) !== 0)
         {
            var_349 = "utf-8";
         }
         if(var_664 === const_1130)
         {
            var_2266 = (_loc3_ & 2) !== 0 ? 8192 : 4096;
            var_2265 = (_loc3_ & 4) !== 0 ? 3 : 2;
         }
         else if(var_664 === const_657)
         {
            var_1960 = (_loc3_ & 6) >> 1;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = param1.readUnsignedShort();
         var _loc6_:* = _loc4_ & 31;
         var _loc7_:* = (_loc4_ & 2016) >> 5;
         var _loc8_:* = (_loc4_ & 63488) >> 11;
         var _loc9_:* = _loc5_ & 31;
         var _loc10_:* = (_loc5_ & 480) >> 5;
         var _loc11_:int = ((_loc5_ & 65024) >> 9) + 1980;
         var_665 = new Date(_loc11_,_loc10_ - 1,_loc9_,_loc8_,_loc7_,_loc6_,0);
         var_663 = param1.readUnsignedInt();
         var_176 = param1.readUnsignedInt();
         var_554 = param1.readUnsignedInt();
         var_986 = param1.readUnsignedShort();
         var_1201 = param1.readUnsignedShort();
      }
      
      public function set content(param1:ByteArray) : void
      {
         if(param1 != null && param1.length > 0)
         {
            param1.position = 0;
            param1.readBytes(var_35,0,param1.length);
            var_663 = ChecksumUtil.CRC32(var_35);
            var_472 = false;
         }
         else
         {
            var_35.length = 0;
            var_35.position = 0;
            var_175 = false;
         }
         compress();
      }
      
      public function toString() : String
      {
         return "[FZipFile]\n  name:" + var_394 + "\n  date:" + var_665 + "\n  sizeCompressed:" + var_176 + "\n  sizeUncompressed:" + var_554 + "\n  versionHost:" + var_1200 + "\n  versionNumber:" + var_1466 + "\n  compressionMethod:" + var_664 + "\n  encrypted:" + var_1468 + "\n  hasDataDescriptor:" + var_1467 + "\n  hasCompressedPatchedData:" + var_1961 + "\n  filenameEncoding:" + var_349 + "\n  crc32:" + var_663.toString(16) + "\n  adler32:" + var_824.toString(16);
      }
      
      public function get content() : ByteArray
      {
         if(var_175)
         {
            uncompress();
         }
         return var_35;
      }
   }
}
