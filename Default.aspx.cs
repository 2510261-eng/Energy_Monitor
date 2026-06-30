using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EnergyMonitor
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirigir la raíz del sitio a la página de Login del proyecto
            Response.Redirect("~/WebSite/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}