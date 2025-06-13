using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankingApp
{
    public partial class BankingApp : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the current page name
                string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

                // Show LinkButton only if the user is on "TargetPage.aspx"
                if (currentPage.Equals("RegistrationPage.aspx", StringComparison.OrdinalIgnoreCase) ||
                    currentPage.Equals("HomePage.aspx", StringComparison.OrdinalIgnoreCase) ||
                    currentPage.Equals("AdminLogin.aspx", StringComparison.OrdinalIgnoreCase))
                {
                    lnkLogin.Visible = true;
                    lnkLogOut.Visible = false;                 
                }
                else
                {
                    lnkLogin.Visible = false;
                    lnkLogOut.Visible = true;
                    
                }
            }
        }

        protected void lnkLogOut_Click(object sender, EventArgs e)
        {
            // Clear session
            Session["cusID"] = "";
            Session["customerName"] = "";
            Session["customerSurname"] = "";

            Response.Redirect("HomePage.aspx");
            Response.Write("<script>alert('User logged out successfully.')</script>");
        }
    }
}