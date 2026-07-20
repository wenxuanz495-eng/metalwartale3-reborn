package UI.honor
{
   import UI.button.BasicButton;
   import flash.text.TextField;
   import gameAll.honor.OneHonorDefine;
   
   public class HonorTextBar extends BasicButton
   {
      
      public var nameTxt:TextField;
      
      public var index:int = 0;
      
      public var itemsData:OneHonorDefine = null;
      
      public function HonorTextBar()
      {
         super();
         this.stop();
      }
      
      override public function setState(value:int) : *
      {
         state = value;
         if(value == 0)
         {
            this.gotoAndStop("normal");
            actived = true;
         }
         else if(value == 1)
         {
            actived = false;
            this.gotoAndStop("normal2");
         }
         else if(value == 2)
         {
            this.gotoAndStop("no");
            actived = false;
         }
         else if(value == 3)
         {
            actived = true;
            this.gotoAndStop("normal");
         }
      }
      
      public function setText(str0:String) : *
      {
         this.nameTxt.text = str0;
      }
      
      public function get text() : String
      {
         return this.nameTxt.text;
      }
      
      public function inData_byDefine(d0:OneHonorDefine) : *
      {
         this.itemsData = d0;
         this.setText(d0.cnName);
      }
   }
}

