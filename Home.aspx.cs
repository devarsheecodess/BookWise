using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibrarySystem
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["userName"] != null)
            {
                string name = Session["userName"].ToString();
                string script = $"localStorage.setItem('userName', '{name}');";
                ClientScript.RegisterStartupScript(this.GetType(), "storeName", script, true);
                Session["userName"] = null;
            }
        }
    }
}