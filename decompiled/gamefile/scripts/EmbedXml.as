package
{
   public class EmbedXml
   {
      
      private var xmlClass1:Class = EmbedXml_xmlClass1;
      
      private var xmlClass2:Class = EmbedXml_xmlClass2;
      
      private var xmlClass3:Class = EmbedXml_xmlClass3;
      
      private var xmlClass4:Class = EmbedXml_xmlClass4;
      
      private var xmlClass5:Class = EmbedXml_xmlClass5;
      
      private var xmlClass6:Class = EmbedXml_xmlClass6;
      
      private var xmlClass7:Class = EmbedXml_xmlClass7;
      
      private var xmlClass8:Class = EmbedXml_xmlClass8;
      
      private var xmlClass9:Class = EmbedXml_xmlClass9;
      
      private var xmlClass10:Class = EmbedXml_xmlClass10;
      
      private var xmlClass11:Class = EmbedXml_xmlClass11;
      
      private var xmlClass12:Class = EmbedXml_xmlClass12;
      
      private var xmlClass13:Class = EmbedXml_xmlClass13;
      
      private var xmlClass14:Class = EmbedXml_xmlClass14;
      
      private var xmlClass15:Class = EmbedXml_xmlClass15;
      
      private var xmlClass16:Class = EmbedXml_xmlClass16;
      
      private var xmlClass17:Class = EmbedXml_xmlClass17;
      
      private var xmlClass18:Class = EmbedXml_xmlClass18;
      
      private var xmlClass19:Class = EmbedXml_xmlClass19;
      
      private var xmlClass20:Class = EmbedXml_xmlClass20;
      
      private var xmlClass21:Class = EmbedXml_xmlClass21;
      
      private var xml_name:Array;
      
      private var xml_arr:Array;
      
      public function EmbedXml()
      {
         super();
         this.xml_name = ["skill","drop","arms","car","carProperty","subCar","subArms","enemy","enemyArms","scene","level","items","goods","enemyData","dirtyWord","exchangeConfig","dengjilibao","turntable","unionshop","starconfig","growconfig"];
         this.init();
      }
      
      public function init() : void
      {
         var i:int = 0;
         var xmlClass:Class = null;
         var xmlBytes:Object = null;
         var xmlString:String = null;
         var xmlObject:XML = null;
         this.xml_arr = [];
         for(i = 1; i <= this.xml_name.length; i++)
         {
            xmlClass = this["xmlClass" + i];
            xmlBytes = new xmlClass();
            xmlString = xmlBytes.toString();
            xmlString = "<root>" + xmlString + "</root>";
            try
            {
               xmlObject = new XML(xmlString);
            }
            catch(e:Error)
            {
               throw new Error("XML错误" + xml_name[i - 1]);
            }
            this.xml_arr.push([xmlObject,this.xml_name[i - 1]]);
         }
      }
      
      public function SearchXml(name0:String) : XML
      {
         var i:* = undefined;
         for each(i in this.xml_arr)
         {
            if(i[1] == name0)
            {
               return i[0];
            }
         }
         return null;
      }
   }
}

