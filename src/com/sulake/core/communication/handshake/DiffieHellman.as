package com.sulake.core.communication.handshake
{
   import com.hurlant.math.BigInteger;
   
   public class DiffieHellman implements IKeyExchange
   {
       
      
      private var var_1516:BigInteger;
      
      private var var_1005:BigInteger;
      
      private var var_2119:BigInteger;
      
      private var var_1515:BigInteger;
      
      private var var_2121:BigInteger;
      
      private var var_2120:BigInteger;
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         super();
         var_1516 = param1;
         var_2119 = param2;
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return var_2121.toRadix(param1);
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         var_1515 = new BigInteger();
         var_1515.fromRadix(param1,param2);
         var_2121 = var_1515.modPow(var_1005,var_1516);
         return getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return var_2120.toRadix(param1);
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         var_1005 = new BigInteger();
         var_1005.fromRadix(param1,param2);
         var_2120 = var_2119.modPow(var_1005,var_1516);
         return true;
      }
   }
}
