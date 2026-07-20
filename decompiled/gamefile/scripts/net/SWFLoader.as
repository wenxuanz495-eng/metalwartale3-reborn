package net
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   
   public class SWFLoader extends Loader
   {
      
      public var loadcount:int = 3;
      
      public var url:String;
      
      public var label:String;
      
      public var info:String = "敌人";
      
      public function SWFLoader()
      {
         super();
      }
      
      public function loadMe() : *
      {
         load(new URLRequest(this.url));
      }
   }
}

