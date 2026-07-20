package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface ITabPages extends IEventDispatcher
   {
      
      function setSize(param1:Number, param2:Number) : void;
      
      function initialize(param1:DisplayObjectContainer, param2:Rectangle, param3:Object) : Boolean;
      
      function removePageAt(param1:uint) : void;
      
      function get count() : uint;
      
      function addPage(param1:String, param2:DisplayObject, param3:DisplayObject) : void;
      
      function get sepx() : int;
      
      function get tabHeight() : int;
      
      function finalize() : void;
      
      function set style(param1:Object) : void;
      
      function addPageAt(param1:String, param2:DisplayObject, param3:DisplayObject, param4:uint) : void;
      
      function get selectedContent() : DisplayObject;
      
      function set tabWidth(param1:int) : void;
      
      function set selectedIndex(param1:int) : void;
      
      function get style() : Object;
      
      function get selectedIndex() : int;
      
      function get tabWidth() : int;
      
      function set sepx(param1:int) : void;
      
      function removeAll() : void;
      
      function set tabHeight(param1:int) : void;
   }
}

