using System;
using System.Web;

namespace SistemaMonitoreo
{
    // Clase Global de la aplicación. Se mantiene partial para que ASP.NET pueda combinarla con la clase generada desde Global.asax.
    public partial class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación.
            try
            {
                // Registrar definición de jquery para ScriptManager (App_Start.BundleConfig)
                EnergyMonitor.BundleConfig.RegisterJQueryScriptManager();
            }
            catch
            {
                // Ignorar si no existe o falla; ScriptManager lanzará excepción más adelante si es necesario.
            }

            try
            {
                // Registrar bundles si existe la clase BundleConfig
                EnergyMonitor.BundleConfig.RegisterBundles(System.Web.Optimization.BundleTable.Bundles);
            }
            catch
            {
            }
        }
    }
}
