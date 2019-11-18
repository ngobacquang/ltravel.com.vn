using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using MartinOnDotNet.Web.ControlExtensions;

namespace MartinOnDotNet.Web.ControlAdapters 
{
   /// <summary> 
   /// Control adapter to ensure the form action persists the rewritten url
   /// </summary> 
   public class FormActionRewriterControlAdapter : System.Web.UI.Adapters.ControlAdapter
   { 
       /// <summary>
       /// Overrides the <see cref="M:System.Web.UI.Control.OnPreRender(System.EventArgs)"/> method for the associated control. 
       /// </summary>
       /// <param name="e">An <see cref="T:System.EventArgs"/> that contains the event data.</param> 
       protected override void OnPreRender(EventArgs e)
       { 
           HtmlForm form = Control as HtmlForm;
           if (form != null && HttpContext.Current != null) 
           {
               form.Action = HttpContext.Current.Request.RawUrl; 
           }
           base.OnPreRender(e); 
       }

       /// <summary>
       /// Generates the target-specific markup for the control to which the control adapter is attached. 
       /// </summary>
       /// <param name="writer">The <see cref="T:System.Web.UI.HtmlTextWriter"/> to use to render the target-specific output.</param> 
       protected override void Render(System.Web.UI.HtmlTextWriter writer)
       { 

           base.Render(new RewriteFormActionHtmlTextWriter(writer)); 
       }
   } 
}
