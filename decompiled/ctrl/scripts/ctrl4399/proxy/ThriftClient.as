package ctrl4399.proxy
{
   import flash.net.URLRequest;
   import org.apache.thrift.protocol.TBinaryProtocol;
   import org.apache.thrift.protocol.TProtocol;
   import org.apache.thrift.transport.THttpClient;
   import org.apache.thrift.transport.TTransport;
   
   public class ThriftClient
   {
      
      public function ThriftClient()
      {
         super();
      }
      
      public static function createClient(param1:String) : TProtocol
      {
         var _loc2_:TTransport = new THttpClient(new URLRequest(param1));
         return new TBinaryProtocol(_loc2_);
      }
   }
}

