package UI.research
{
   import data.StringToDefine;
   import data.TextWay;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.AdditionalData;
   import gameAll.data.GoodsItemsData;
   
   public class ChipAffixGroup extends Sprite
   {
      
      internal var _num:String = TextWay.toCode("5");
      
      public var arr:Array = [];
      
      public function ChipAffixGroup()
      {
         super();
      }
      
      public function getMustX() : int
      {
         return int(TextWay.getText(this._num));
      }
      
      public function inNewChip(gd0:GoodsItemsData) : *
      {
         this.clear();
         var add0:AdditionalData = new AdditionalData();
         add0.inData_byArr(gd0.addArr);
         this.flesh_byArr(add0);
         this.fleshLock(new AdditionalData());
      }
      
      public function getLockNum() : int
      {
         var n:* = undefined;
         var bar0:ChipAffixBar = null;
         var num0:int = 0;
         for(n in this.arr)
         {
            bar0 = this.arr[n];
            if(bar0.lockB)
            {
               num0++;
            }
         }
         return num0;
      }
      
      public function flesh_byArr(add0:AdditionalData) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var bar0:ChipAffixBar = null;
         this.clear();
         var nameArr0:Array = add0.getNameArr();
         for(n in nameArr0)
         {
            name0 = nameArr0[n];
            bar0 = new ChipAffixBar();
            bar0.affixName = name0;
            bar0.affixValue = add0[name0];
            bar0.txt.text = add0.getOneStr_byName(name0);
            bar0.lock_btn.addEventListener(MouseEvent.CLICK,this.lock);
            bar0.unlock_btn.addEventListener(MouseEvent.CLICK,this.lock);
            addChild(bar0);
            this.arr.push(bar0);
            bar0.x = 0;
            bar0.y = 25 * n;
         }
      }
      
      public function fleshLock(add0:AdditionalData) : *
      {
         var n:* = undefined;
         var bar0:ChipAffixBar = null;
         var nameArr:Array = add0.getNameArr();
         for(n in this.arr)
         {
            bar0 = this.arr[n];
            if(nameArr.indexOf(bar0.affixName) >= 0)
            {
               bar0.lock();
            }
            else
            {
               bar0.unlock();
            }
         }
         trace("-----------------------------------");
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var bar0:ChipAffixBar = null;
         for(n in this.arr)
         {
            bar0 = this.arr[n];
            removeChild(bar0);
            bar0.lock_btn.removeEventListener(MouseEvent.CLICK,this.lock);
            bar0.unlock_btn.removeEventListener(MouseEvent.CLICK,this.lock);
         }
         this.arr.length = 0;
      }
      
      public function lock(e:*) : *
      {
         var bar0:ChipAffixBar = e.target.parent;
         if(bar0.lockB)
         {
            bar0.unlock();
         }
         else
         {
            bar0.lock();
         }
         Game.uiGroup.researchUI.crystalBox.chipBaptizeUI.fleshMust();
      }
      
      public function repeat(gd0:GoodsItemsData) : *
      {
         var add0:AdditionalData = new AdditionalData();
         add0.inData_byArr(gd0.addArr);
         var add_lock:AdditionalData = this.getUnlockAdd();
         var lock_nameArr:Array = add_lock.getNameArr();
         var surplusArr:Array = StringToDefine.deductArr(AdditionalData.allName,lock_nameArr);
         var num2:int = add0.getNameArr().length - add_lock.getNameArr().length;
         var add2:AdditionalData = Game.gameDefine.addDefine.getAdditionalData(num2,gd0.affixLevel,null,surplusArr);
         add2.addData(add_lock);
         gd0.addArr = add2.getStrArr();
         this.flesh_byArr(add2);
         this.fleshLock(add_lock);
      }
      
      public function getUnlockAdd() : AdditionalData
      {
         var n:* = undefined;
         var bar0:ChipAffixBar = null;
         var add_lock:AdditionalData = new AdditionalData();
         for(n in this.arr)
         {
            bar0 = this.arr[n];
            if(bar0.lockB)
            {
               add_lock[bar0.affixName] = bar0.affixValue;
            }
         }
         return add_lock;
      }
   }
}

