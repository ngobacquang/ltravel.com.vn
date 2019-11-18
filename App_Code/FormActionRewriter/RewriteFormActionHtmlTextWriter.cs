using System;
using System.Data;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace MartinOnDotNet.Web.ControlExtensions
{ 
   /// <summary>
   /// Specialised <see ref="HtmlTextWriter" /> that handles populating the form action attribute appropriately for 
   /// url rewriting
   /// </summary> 
   public class RewriteFormActionHtmlTextWriter : HtmlTextWriter
   { 
       private bool _haveAlreadyWritten;
 
       /// <summary>
       /// Initializes a new instance of the <see cref="RewriteFormActionHtmlTextWriter"/> class. 
       /// </summary>
       /// <param name="writer">The writer.</param> 
       public RewriteFormActionHtmlTextWriter(TextWriter writer) : base(writer) { InnerWriter = writer; }
       
       /// <summary>
       /// Initializes a new instance of the <see cref="RewriteFormActionHtmlTextWriter"/> class. 
       /// </summary>
       /// <param name="writer">The writer.</param> 
       public RewriteFormActionHtmlTextWriter(HtmlTextWriter writer) : base(writer) { InnerWriter = writer.InnerWriter; }
 
       /// <summary>
       /// Writes the specified markup attribute and value to the output stream, and, if specified, writes the value encoded. 
       /// </summary>
       /// <param name="name">The markup attribute to write to the output stream.</param> 
       /// <param name="value">The value assigned to the attribute.</param>
       /// <param name="fEncode">true to encode the attribute and its assigned value; otherwise, false.</param> 
       public override void WriteAttribute(string name, string value, bool fEncode)
       { 
           if (string.Equals(name, "action", StringComparison.OrdinalIgnoreCase) && !_haveAlreadyWritten)
           { 

               value = HttpContext.Current.Request.RawUrl; 
               _haveAlreadyWritten = true;
 
           }
           base.WriteAttribute(name, value, fEncode); 
       }
   } 
}
