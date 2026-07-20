package UI.union
{
   import UI.change.CarItemsTip;
   import UI.dialog.ItemsTipbox;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import items.ItemsDefine;
   
   public class UnionTask
   {
      
      private var taskArr:Array = null;
      
      private var taskOverGift:Array = ["props,superalloyStone,\t5","props,achieve_card_1,\t20","props,GCoin_card_2,\t\t20","props,justice2_badge,\t20"];
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      private var tip_mc:CarItemsTip = null;
      
      private var tipBox:ItemsTipbox = null;
      
      public function UnionTask(mc0:UnionUI, mc1:MovieClip, mc3:CarItemsTip, mc4:ItemsTipbox)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.tip_mc = mc3;
         this.tipBox = mc4;
         this.taskArr = [new CTaskData(1,"初试身手","前往普通战役中消灭80只怪物",2,80,["props,GCoin_card_1,5","props,exp_card_1,2","props,justice2_badge,2"]),new CTaskData(2,"抵御机器人","前往普通战役中消灭160只怪物",2,160,["props,GCoin_card_1,5","props,exp_card_1,2","props,justice2_badge,2"]),new CTaskData(3,"收集公会物资","收集10个超合金",3,10,["props,GCoin_card_1,10","props,exp_card_1,4","props,justice2_badge,2"]),new CTaskData(4,"抵御机器人II","前往普通战役中消灭320只怪物",2,320,["props,GCoin_card_1,10","props,exp_card_1,4","props,justice2_badge,2"]),new CTaskData(5,"精英猎手","前往普通战役中消灭8只精英怪物",4,8,["props,GCoin_card_1,15","props,exp_card_1,6","props,justice2_badge,2"]),new CTaskData(6,"精英杀手","前往普通战役中消灭16只精英怪物",4,16,["props,GCoin_card_1,15","props,exp_card_1,6","props,justice2_badge,2"]),new CTaskData(7,"战场清理","前往普通战役中消灭240只怪物",2,240,["props,GCoin_card_1,20","props,exp_card_1,8","props,justice2_badge,2"]),new CTaskData(8,"精英杀手Ⅱ","前往普通战役中消灭32只精英怪物",4,32,["props,GCoin_card_1,20","props,exp_card_1,8","props,justice2_badge,2"]),new CTaskData(9,"抵御机器人Ⅲ","前往普通战役中消灭640只怪物"
         ,2,640,["props,GCoin_card_1,25","props,exp_card_1,10","props,justice2_badge,2"]),new CTaskData(10,"精英杀手Ⅲ","前往普通战役中消灭64只精英怪物",4,64,["props,GCoin_card_1,25","props,exp_card_1,10","props,justice2_badge,2"])];
      }
      
      public function Init() : void
      {
         var taskID:int;
         var ntaskData:CTaskData;
         var npt:String;
         var nptArr:Array;
         var gc:int = 0;
         var jumfun:Function = function():void
         {
            father.InitBox(1);
         };
         if(!this.father.IsHasUnion && !Game.getTest())
         {
            Game.uiGroup.checkTip.showCheck2("您还没有加入任何公会,请先加入公会!",2,jumfun);
            return;
         }
         this.mc_box.gotoAndStop(5);
         (this.mc_box["btn_getprize"] as SimpleButton).mouseEnabled = false;
         (this.mc_box["btn_getprize"] as SimpleButton).alpha = 0.3;
         (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = false;
         (this.mc_box["btn_over"] as SimpleButton).alpha = 0.3;
         (this.mc_box["btn_get"] as SimpleButton).mouseEnabled = false;
         (this.mc_box["btn_get"] as SimpleButton).alpha = 0.3;
         (this.mc_box["btn_get"] as SimpleButton).visible = false;
         (this.mc_box["btn_over"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onClick);
         (this.mc_box["btn_get"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onClick);
         (this.mc_box["btn_getprize"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onClick);
         taskID = Game.gameData.giftData.getNowUnionTaskID();
         if(taskID == -1)
         {
            (this.mc_box["btn_over"] as SimpleButton).visible = false;
            (this.mc_box["btn_get"] as SimpleButton).visible = false;
            (this.mc_box["txt_title"] as TextField).text = "今日公会任务已经全部完成!";
            (this.mc_box["txt_progress"] as TextField).text = "";
            (this.mc_box["txt_progressall"] as TextField).text = "(" + this.taskArr.length + "/" + this.taskArr.length + ")";
            this.setIconAndText("mc_icon2_","txt_icon2_",null);
            this.setIconAndText("mc_icon1_","txt_icon1_",this.taskOverGift);
            gc = 1 - Game.gameData.giftData.GetUnionTaskGeted();
            if(gc > 0)
            {
               (this.mc_box["btn_getprize"] as SimpleButton).mouseEnabled = true;
               (this.mc_box["btn_getprize"] as SimpleButton).alpha = 1;
            }
            else
            {
               (this.mc_box["btn_getprize"] as SimpleButton).mouseEnabled = false;
               (this.mc_box["btn_getprize"] as SimpleButton).alpha = 0.3;
            }
            return;
         }
         ntaskData = this.getTaskData(taskID);
         npt = Game.gameData.giftData.GetUnionTaskByID(taskID);
         nptArr = npt.split(":");
         (this.mc_box["txt_title"] as TextField).text = ntaskData.Desc;
         (this.mc_box["txt_progress"] as TextField).text = "(" + nptArr[1] + "/" + ntaskData.GoalCount + ")";
         (this.mc_box["txt_progressall"] as TextField).text = "(" + taskID + "/" + this.taskArr.length + ")";
         this.setIconAndText("mc_icon2_","txt_icon2_",ntaskData.PrizeArr);
         this.setIconAndText("mc_icon1_","txt_icon1_",this.taskOverGift);
         this.setBtnState(int(nptArr[2]),int(nptArr[1]),ntaskData);
      }
      
      private function setBtnState(state:int, num:int, ntaskData:CTaskData) : void
      {
         switch(state)
         {
            case 0:
               if(num >= ntaskData.GoalCount)
               {
                  (this.mc_box["btn_over"] as SimpleButton).visible = true;
                  (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = true;
                  (this.mc_box["btn_over"] as SimpleButton).alpha = 1;
                  (this.mc_box["btn_get"] as SimpleButton).visible = false;
               }
               else
               {
                  (this.mc_box["btn_over"] as SimpleButton).visible = true;
                  (this.mc_box["btn_get"] as SimpleButton).visible = false;
                  (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = false;
                  (this.mc_box["btn_over"] as SimpleButton).alpha = 0.3;
               }
               break;
            case 1:
               if(num >= ntaskData.GoalCount)
               {
                  (this.mc_box["btn_over"] as SimpleButton).visible = true;
                  (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = true;
                  (this.mc_box["btn_over"] as SimpleButton).alpha = 1;
                  (this.mc_box["btn_get"] as SimpleButton).visible = false;
               }
               else
               {
                  (this.mc_box["btn_over"] as SimpleButton).visible = true;
                  (this.mc_box["btn_get"] as SimpleButton).visible = false;
                  (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = false;
                  (this.mc_box["btn_over"] as SimpleButton).alpha = 0.3;
               }
               break;
            case 2:
               (this.mc_box["btn_over"] as SimpleButton).visible = true;
               (this.mc_box["btn_get"] as SimpleButton).visible = false;
               (this.mc_box["btn_over"] as SimpleButton).mouseEnabled = false;
               (this.mc_box["btn_over"] as SimpleButton).alpha = 0.3;
         }
      }
      
      private function setIconAndText(iconStr:String, txtStr:String, arr:Array) : void
      {
         var prizestr:String = null;
         var prizeID:String = null;
         var itemdefine:ItemsDefine = null;
         for(var i:int = 0; i < 4; i++)
         {
            (this.mc_box[txtStr + (i + 1)] as TextField).text = "";
            this.addIcon(this.mc_box[iconStr + (i + 1)],"");
            if(Boolean(arr) && Boolean(arr[i]))
            {
               prizestr = arr[i];
               prizeID = prizestr.split(",")[1];
               itemdefine = Game.itemsDefineGroup.getDefine(prizeID);
               this.addIcon(this.mc_box[iconStr + (i + 1)],itemdefine.imgLabel);
               (this.mc_box[txtStr + (i + 1)] as TextField).text = prizestr.split(",")[2];
               this.mc_box[iconStr + (i + 1)]["edata"] = itemdefine;
               this.mc_box[iconStr + (i + 1)].addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
               this.mc_box[iconStr + (i + 1)].addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
            }
         }
      }
      
      public function onItemOut(event:*) : *
      {
         this.tipBox.hide();
      }
      
      protected function onItemOver(event:MouseEvent) : void
      {
         var mc:MovieClip = event.currentTarget as MovieClip;
         if(mc == null || mc.edata == null)
         {
            return;
         }
         var ed:ItemsDefine = mc["edata"];
         if(ed == null)
         {
            return;
         }
         this.tip_mc.title_txt.text = ed.cnName;
         this.tip_mc.txt.htmlText = ed.description;
         this.tipBox.showDialog(this.tip_mc,event.currentTarget,event.currentTarget.x,event.currentTarget.y);
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         var taskID:int = 0;
         var ntaskData:CTaskData = null;
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         switch(name)
         {
            case "btn_over":
               taskID = Game.gameData.giftData.getNowUnionTaskID();
               Game.gameData.giftData.SetUnionTaskState(taskID,2);
               ntaskData = this.getTaskData(taskID);
               Game.uiGroup.addGift_byArr(ntaskData.PrizeArr,false,1,true);
               this.Init();
               break;
            case "btn_get":
               taskID = Game.gameData.giftData.getNowUnionTaskID();
               Game.gameData.giftData.SetUnionTaskState(taskID,1);
               this.Init();
               break;
            case "btn_getprize":
               Game.uiGroup.addGift_byArr(this.taskOverGift,false,1,true);
               Game.gameData.giftData.AddUnionTaskGeted();
               this.Init();
         }
      }
      
      private function addIcon(mccontains:DisplayObjectContainer, imgLabel:String) : void
      {
         var bit:Bitmap = null;
         if(mccontains == null)
         {
            return;
         }
         while(mccontains.numChildren > 0)
         {
            mccontains.removeChildAt(0);
         }
         if(imgLabel == "")
         {
            return;
         }
         var temp:* = Game.swfLoaderManager.getResource("",imgLabel);
         if(temp == null)
         {
            return;
         }
         var mc:MovieClip = null;
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         mccontains.addChild(mc);
      }
      
      public function AddTaskGoal(type:int, num:int = 1) : void
      {
         var taskID:int = Game.gameData.giftData.getNowUnionTaskID();
         var ntaskData:CTaskData = this.getTaskData(taskID);
         if(ntaskData == null)
         {
            return;
         }
         if(type != ntaskData.Type)
         {
            return;
         }
         Game.gameData.giftData.AddUnionTaskGoal(taskID,num);
      }
      
      public function getTaskData(id:int) : CTaskData
      {
         var ctd:CTaskData = null;
         for(var i:int = 0; i < this.taskArr.length; i++)
         {
            ctd = this.taskArr[i];
            if(ctd.Id == id)
            {
               return ctd;
            }
         }
         return null;
      }
      
      public function Release() : void
      {
      }
   }
}

class CTaskData
{
   
   public var Id:int = 0;
   
   public var Name:String = "";
   
   public var Desc:String = "";
   
   public var Type:int = 1;
   
   public var GoalCount:int = 0;
   
   public var PrizeArr:Array = null;
   
   public function CTaskData(id:int, name:String, desc:String, type:int, goalcount:int, prizearr:Array)
   {
      super();
      this.Id = id;
      this.Name = name;
      this.Desc = desc;
      this.Type = type;
      this.GoalCount = goalcount;
      this.PrizeArr = prizearr;
   }
}
