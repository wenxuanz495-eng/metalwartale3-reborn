package net
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class TextLoader extends URLLoader
   {
      
      public var url:String;
      
      public var label:String;
      
      public function TextLoader()
      {
         super();
      }
      
      public function loadMe() : *
      {
         load(new URLRequest(this.url));
      }
   }
}

