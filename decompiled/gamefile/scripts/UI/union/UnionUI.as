package UI.union
{
   import UI.change.CarItemsTip;
   import UI.dialog.ItemsTipbox;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class UnionUI extends Sprite
   {
      
      public const postArr:Array = ["见习会员","正式会员","精英会员","资深会员","指挥官","精英指挥官"];
      
      public const postExp:Array = [450,1850,10850,31850,103850,999999999];
      
      public const postPrize1:Array = [5,10,15,20,25,30];
      
      public const postPrize2:Array = [1,2,3,4,5,6];
      
      public const unionExp:Array = [0,147,687,2180,4647,8847,15780,26180,46980,109380,99999999,999999999];
      
      public const unionCount:Array = [0,20,25,30,35,40,45,50,50,50,50,50,50];
      
      public var mc_create:MovieClip = null;
      
      public var mc_asklist:MovieClip = null;
      
      public var mc_requestlist:MovieClip = null;
      
      public var mc_donate:MovieClip = null;
      
      public var mc_techolog:MovieClip = null;
      
      public var mc_light:MovieClip = null;
      
      public var mc_box:MovieClip = null;
      
      public var btn_1:SimpleButton = null;
      
      public var btn_2:SimpleButton = null;
      
      public var btn_3:SimpleButton = null;
      
      public var btn_4:SimpleButton = null;
      
      public var btn_5:SimpleButton = null;
      
      public var btn_6:SimpleButton = null;
      
      public var btn_7:SimpleButton = null;
      
      public var btn_8:SimpleButton = null;
      
      private var _unionList:UnionList = null;
      
      private var _myUnion:MyUnion = null;
      
      private var _myUnionMember:MyUnionMember = null;
      
      private var _unionShop:UnionShop = null;
      
      private var _unionTask:UnionTask = null;
      
      private var _unionBattle:UnionBattle = null;
      
      private var _unionBuild:UnionBuild = null;
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:CarItemsTip = new CarItemsTip();
      
      public var IsHasUnion:Boolean = false;
      
      public var IsPresident:Boolean = false;
      
      public var MyUnionName:String = "";
      
      public var MyUnionID:int = -1;
      
      public var ExtraUnionObj1:Object = {};
      
      public var ExtraUnionObj2:Object = {};
      
      public var UnionPreID:String = "-1";
      
      public var UnionLevel:int = 1;
      
      public var MemberLevel:int = 1;
      
      public function UnionUI()
      {
         super();
         this.mc_light.mouseEnabled = false;
         this.mc_light.x = this.btn_1.x;
         this.mc_light.y = this.btn_1.y;
         for(var i:int = 1; i < 8; i++)
         {
            (this["btn_" + i] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onMenuClickBtn);
         }
         this.tipBox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc3"));
         this.tipBox.visible = false;
         this.tipBox.mouseChildren = false;
         this.tipBox.mouseEnabled = false;
         addChild(this.tipBox);
         this.tip_mc.visible = false;
         this.tip_mc.mouseChildren = false;
         this.tip_mc.mouseEnabled = false;
         addChild(this.tip_mc);
         this.mc_box.gotoAndStop(1);
         this._unionList = new UnionList(this,this.mc_box,this.mc_create,this.tip_mc,this.tipBox);
         this._myUnion = new MyUnion(this,this.mc_box,this.mc_donate);
         this._myUnionMember = new MyUnionMember(this,this.mc_box,this.mc_requestlist);
         this._unionShop = new UnionShop(this,this.mc_box);
         this._unionTask = new UnionTask(this,this.mc_box,this.tip_mc,this.tipBox);
         this._unionBattle = new UnionBattle(this,this.mc_box,this.tip_mc,this.tipBox);
         this._unionBuild = new UnionBuild(this,this.mc_box,this.mc_techolog);
      }
      
      protected function onMenuClickBtn(event:MouseEvent) : void
      {
         var btn:SimpleButton = event.currentTarget as SimpleButton;
         switch(btn.name)
         {
            case "btn_1":
               this.InitBox(1);
               break;
            case "btn_2":
               this.InitBox(2);
               break;
            case "btn_3":
               this.InitBox(3);
               break;
            case "btn_4":
               this.InitBox(4);
               break;
            case "btn_5":
               this.InitBox(5);
               break;
            case "btn_6":
               this.InitBox(6);
               break;
            case "btn_7":
               this.InitBox(7);
         }
      }
      
      public function Update(id:int = 2) : void
      {
         this.InitBox(id);
      }
      
      public function InitBox(id:int = 1, iscache:Boolean = true) : void
      {
         this.mc_light.x = this["btn_" + id].x;
         this.mc_light.y = this["btn_" + id].y;
         var name:String = this["btn_" + id].name;
         if(id == 1)
         {
            this._unionList.Init();
         }
         else if(id == 2)
         {
            this._myUnion.Init(iscache);
         }
         else if(id == 3)
         {
            this._myUnionMember.Init();
         }
         else if(id == 4)
         {
            this._unionShop.Init();
         }
         else if(id == 5)
         {
            this._unionTask.Init();
         }
         else if(id == 6)
         {
            this._unionBattle.Init();
         }
         else if(id == 7)
         {
            this._unionBuild.Init();
         }
         this.hideAllWindows();
      }
      
      public function GetMemberLevel(contri:int = 0) : int
      {
         if(this.IsPresident)
         {
            return 99;
         }
         var poststr:int = 0;
         for(var i:int = this.postExp.length - 1; i >= 0; i--)
         {
            if(contri >= this.postExp[i])
            {
               return poststr + 1;
            }
            poststr = i;
         }
         return poststr + 1;
      }
      
      public function GetPostByLv(lv:int = 0) : String
      {
         if(Boolean(this.postArr[lv - 1]))
         {
            return this.postArr[lv - 1];
         }
         return this.postArr[0];
      }
      
      public function GetPost(contri:int = 0) : String
      {
         if(this.IsPresident)
         {
            return "会长";
         }
         var poststr:String = this.postArr[0];
         for(var i:int = this.postExp.length - 1; i >= 0; i--)
         {
            if(contri >= this.postExp[i])
            {
               return poststr;
            }
            poststr = this.postArr[i];
         }
         return poststr;
      }
      
      public function GetNextPostExp(contri:int = 0) : int
      {
         if(this.IsPresident)
         {
            return 0;
         }
         var poststr:int = int(this.postExp[0]);
         for(var i:int = this.postExp.length - 1; i >= 0; i--)
         {
            if(contri >= this.postExp[i])
            {
               return poststr - contri;
            }
            poststr = int(this.postExp[i]);
         }
         if(poststr - contri > 0)
         {
            return poststr - contri;
         }
         return poststr;
      }
      
      public function GetNextPost(contri:int = 0) : String
      {
         if(this.IsPresident)
         {
            return "会长";
         }
         var poststr:String = this.postArr[0];
         var ti:int = 0;
         for(var i:int = this.postExp.length - 1; i >= 0; i--)
         {
            if(contri >= this.postExp[i])
            {
               break;
            }
            poststr = this.postArr[i];
            ti = i;
         }
         ti += 1;
         if(ti > this.postExp.length - 1)
         {
            ti = this.postExp.length - 1;
         }
         return this.postArr[ti];
      }
      
      public function get CUnionTask() : UnionTask
      {
         return this._unionTask;
      }
      
      public function InitBuildAdd() : void
      {
         this._unionBuild.InitBuildAdd();
      }
      
      public function GetBuildAddByType(type:int) : Number
      {
         return this._unionBuild.GetBuildAddByType(type);
      }
      
      public function hideAllWindows() : void
      {
         this.mc_create.visible = false;
         this.mc_asklist.visible = false;
         this.mc_requestlist.visible = false;
         this.mc_donate.visible = false;
         this.mc_techolog.visible = false;
      }
      
      public function FisCityFight() : void
      {
         this._unionBattle.FisCityFight();
      }
      
      public function clearAll() : void
      {
         this.mc_box.gotoAndStop(1);
         this.IsHasUnion = false;
         this.IsPresident = false;
         this.MyUnionID = -1;
         this.ExtraUnionObj1 = {};
         this.ExtraUnionObj2 = {};
         this.UnionPreID = "-1";
         this.UnionLevel = 1;
         this.MemberLevel = 1;
         Game.union_api.Clear();
         this._myUnion.Release();
         this._unionList.Release();
         this._myUnionMember.Release();
         this._unionShop.Release();
         this._unionTask.Release();
         this._unionBattle.Release();
      }
   }
}

