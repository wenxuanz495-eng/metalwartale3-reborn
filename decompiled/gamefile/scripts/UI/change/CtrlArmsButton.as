package UI.change
{
   import UI.button.BasicButton;
   import flash.text.TextField;
   
   public class CtrlArmsButton extends BasicButton
   {
      
      public var txt:TextField;
      
      public var text:String = "";
      
      public var index:int = 0;
      
      public var overTextShowB:Boolean = true;
      
      public function CtrlArmsButton()
      {
         super();
         init();
         noLabelB = true;
      }
      
      public function show() : *
      {
      }
      
      public function setText(str:String) : *
      {
         this.text = str;
         this.txt.text = str;
      }
      
      override protected function fleshTest() : *
      {
         this.setText(this.text);
         if(!this.overTextShowB)
         {
            if(this.currentFrameLabel == "normal")
            {
               this.txt.visible = false;
            }
            else
            {
               this.txt.visible = true;
            }
         }
      }
   }
}

