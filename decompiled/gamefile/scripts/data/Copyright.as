package data
{
   import flash.display.*;
   import flash.events.ContextMenuEvent;
   import flash.net.*;
   import flash.ui.*;
   
   public class Copyright
   {
      
      private var myName:String = "游戏公国版权所有";
      
      private var myUrl:String = "#";
      
      private var target:InteractiveObject;
      
      public function Copyright(target:InteractiveObject)
      {
         super();
         this.target = target;
         this.removeAndAddItem();
      }
      
      private function removeAndAddItem() : void
      {
         var myContextMenu:* = new ContextMenu();
         var item:ContextMenuItem = new ContextMenuItem(this.myName);
         var item2:ContextMenuItem = new ContextMenuItem(Game.versionNumber);
         myContextMenu.hideBuiltInItems();
         myContextMenu.customItems.push(item);
         myContextMenu.customItems.push(item2);
         this.target.contextMenu = myContextMenu;
      }
      
      private function itemSelectHandler(e:ContextMenuEvent) : void
      {
      }
   }
}

