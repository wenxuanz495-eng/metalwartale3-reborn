package org.apache.thrift.transport
{
   import flash.errors.EOFError;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   
   public class THttpClient extends TTransport
   {
      
      private var request_:URLRequest = null;
      
      private var requestBuffer_:ByteArray = new ByteArray();
      
      private var responseBuffer_:ByteArray = null;
      
      private var traceBuffers_:Boolean = Capabilities.isDebugger;
      
      public function THttpClient(param1:URLRequest, param2:Boolean = true)
      {
         super();
         param1.contentType = "application/x-thrift";
         this.request_ = param1;
         if(param2 == false)
         {
            this.traceBuffers_ = param2;
         }
      }
      
      public function getBuffer() : ByteArray
      {
         return this.requestBuffer_;
      }
      
      override public function open() : void
      {
      }
      
      override public function close() : void
      {
      }
      
      override public function isOpen() : Boolean
      {
         return true;
      }
      
      override public function read(param1:ByteArray, param2:int, param3:int) : int
      {
         var buf:ByteArray = param1;
         var off:int = param2;
         var len:int = param3;
         if(this.responseBuffer_ == null)
         {
            throw new TTransportError(TTransportError.UNKNOWN,"Response buffer is empty, no request.");
         }
         try
         {
            this.responseBuffer_.readBytes(buf,off,len);
            if(this.traceBuffers_)
            {
               this.dumpBuffer(buf,"READ");
            }
            return len;
         }
         catch(e:EOFError)
         {
            if(traceBuffers_)
            {
               dumpBuffer(requestBuffer_,"FAILED-RESPONSE-REQUEST");
               dumpBuffer(responseBuffer_,"FAILED-RESPONSE");
            }
            throw new TTransportError(TTransportError.UNKNOWN,"No more data available.");
         }
      }
      
      override public function write(param1:ByteArray, param2:int, param3:int) : void
      {
         this.requestBuffer_.writeBytes(param1,param2,param3);
      }
      
      override public function flush(param1:Function = null) : void
      {
         var callback:Function = param1;
         var loader:URLLoader = new URLLoader();
         if(callback != null)
         {
            loader.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               requestBuffer_.position = 0;
               requestBuffer_.length = 0;
               responseBuffer_ = URLLoader(param1.target).data;
               if(traceBuffers_)
               {
                  dumpBuffer(responseBuffer_,"RESPONSE_BUFFER");
               }
               callback(null);
               responseBuffer_ = null;
            });
            loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
            {
               callback(new TTransportError(TTransportError.UNKNOWN,"IOError: " + param1.text));
               responseBuffer_ = null;
            });
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:SecurityErrorEvent):void
            {
               callback(new TTransportError(TTransportError.UNKNOWN,"SecurityError: " + param1.text));
               responseBuffer_ = null;
            });
         }
         this.request_.method = URLRequestMethod.POST;
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.requestBuffer_.position = 0;
         this.request_.data = this.requestBuffer_;
         loader.load(this.request_);
      }
      
      private function dumpBuffer(param1:ByteArray, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = param2 + " BUFFER ";
         if(param1 != null)
         {
            _loc3_ += "length: " + param1.length + ", ";
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ += "[" + param1[_loc4_].toString(16) + "]";
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = "null";
         }
         trace(_loc3_);
         return _loc3_;
      }
   }
}

