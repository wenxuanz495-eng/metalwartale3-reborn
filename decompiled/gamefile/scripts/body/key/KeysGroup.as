package body.key
{
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class KeysGroup
   {
      
      public var arr:Array;

      public var moveKeys:Array = [65,68,87,83];

      public var weaponKeys:Array = [49,50,51,52,53,54,55,56];

      public var skillKeys:Object = {"rocket":81,"plasma":69,"change":70,"lighting":32};

      public var menuKey:int = 27;
      
      public function KeysGroup()
      {
         var n:int = 0;
         this.arr = new Array(256);
         for(super(); n <= this.arr.length - 1; )
         {
            this.arr[n] = new Keys(n);
            n++;
         }
      }

      public function getBinding(action:String) : int
      {
         if(action == "moveLeft") return int(this.moveKeys[0]);
         if(action == "moveRight") return int(this.moveKeys[1]);
         if(action == "jump") return int(this.moveKeys[2]);
         if(action == "interact") return int(this.moveKeys[3]);
         if(action == "menu") return this.menuKey;
         if(action.indexOf("weapon") == 0) return int(this.weaponKeys[int(action.substr(6))]);
         return int(this.skillKeys[action]);
      }

      public function setBinding(action:String, code:int) : *
      {
         if(action == "moveLeft") this.moveKeys[0] = code;
         else if(action == "moveRight") this.moveKeys[1] = code;
         else if(action == "jump") this.moveKeys[2] = code;
         else if(action == "interact") this.moveKeys[3] = code;
         else if(action == "menu") this.menuKey = code;
         else if(action.indexOf("weapon") == 0) this.weaponKeys[int(action.substr(6))] = code;
         else this.skillKeys[action] = code;
      }

      public function resetBindings() : *
      {
         this.moveKeys = [65,68,87,83];
         this.weaponKeys = [49,50,51,52,53,54,55,56];
         this.skillKeys = {"rocket":81,"plasma":69,"change":70,"lighting":32};
         this.menuKey = 27;
      }
      
      public function gamingInit() : *
      {
         var n:* = undefined;
         var key0:Keys = null;
         for(n in this.arr)
         {
            key0 = this.arr[n];
            key0.s = "uping";
         }
      }
      
      public function keyDown(event:KeyboardEvent) : *
      {
         var key0:Keys = null;
         if(event.target is TextField && TextField(event.target).type == TextFieldType.INPUT)
         {
            return;
         }
         var code:int = int(event.keyCode);
         if(code < this.arr.length)
         {
            key0 = this.arr[code];
            if(key0.s != "downing")
            {
               key0.s = "down";
            }
         }
      }
      
      public function keyUp(event:KeyboardEvent) : *
      {
         var key0:Keys = null;
         if(event.target is TextField && TextField(event.target).type == TextFieldType.INPUT)
         {
            return;
         }
         var code:int = int(event.keyCode);
         if(code < this.arr.length)
         {
            key0 = this.arr[code];
            key0.s = "up";
         }
      }
      
      public function KeyTimer() : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].toing();
         }
      }
   }
}

