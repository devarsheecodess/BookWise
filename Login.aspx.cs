using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace LibrarySystem
{
    public partial class Login : Page
    {
        protected void btnLogin_ServerClick(object sender, EventArgs e)
        {
            string email = txtEmail.Value.Trim();
            string password = txtPassword.Value;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowAlert("Please enter both Email and Password.");
                return;
            }

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Updated query to also select the ID
                    string query = "SELECT ID, FullName, Password FROM Users WHERE Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int userId = Convert.ToInt32(reader["ID"]);
                                string fullName = reader["FullName"].ToString();
                                string storedHashedPassword = reader["Password"].ToString();
                                string hashedInputPassword = ComputeSha256Hash(password);

                                if (storedHashedPassword == hashedInputPassword)
                                {
                                    Session["userName"] = fullName;

                                    string escapedFullName = fullName.Replace("'", "\\'");

                                    // Store ID and FullName in localStorage and redirect
                                    string script = $@"
                                        <script type='text/javascript'>
                                            localStorage.setItem('userID', '{userId}');
                                            localStorage.setItem('userFullName', '{escapedFullName}');
                                            window.location.href = 'Home.aspx';
                                        </script>";

                                    ClientScript.RegisterStartupScript(this.GetType(), "loginSuccess", script);
                                }
                                else
                                {
                                    ShowAlert("Incorrect password.");
                                }
                            }
                            else
                            {
                                ShowAlert("Email not found.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("An error occurred: " + ex.Message);
            }
        }

        private string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ShowAlert(string message)
        {
            string safeMessage = message.Replace("'", "\\'");
            string script = $"alert('{safeMessage}');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}
