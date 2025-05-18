using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace LibrarySystem
{
    public partial class Signup : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string fullName = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Basic validation
            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ShowAlert("All fields are required.");
                return;
            }

            if (password.Length < 8)
            {
                ShowAlert("Password must be at least 8 characters long.");
                return;
            }

            if (password != confirmPassword)
            {
                ShowAlert("Passwords do not match.");
                return;
            }

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Check if user already exists by email
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);

                        int exists = (int)checkCmd.ExecuteScalar();
                        if (exists > 0)
                        {
                            ShowAlert("A user with this Email already exists.");
                            return;
                        }
                    }

                    // Insert new user and get inserted ID
                    string insertQuery = @"
                        INSERT INTO Users (FullName, Email, Password) 
                        OUTPUT INSERTED.ID 
                        VALUES (@FullName, @Email, @Password)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                    {
                        insertCmd.Parameters.AddWithValue("@FullName", fullName);
                        insertCmd.Parameters.AddWithValue("@Email", email);
                        insertCmd.Parameters.AddWithValue("@Password", HashPassword(password));

                        // Execute and get the inserted ID
                        int newUserID = (int)insertCmd.ExecuteScalar();

                        if (newUserID > 0)
                        {
                            // Store ID and FullName in localStorage and redirect
                            string script = $@"
                                <script>
                                    localStorage.setItem('userID', '{newUserID}');
                                    localStorage.setItem('userName', '{fullName}');
                                    window.location.href = 'Home.aspx';
                                </script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "signupSuccess", script);
                        }
                        else
                        {
                            ShowAlert("Something went wrong. Please try again.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // SHA256 password hashing helper
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ShowAlert(string message, bool success = false)
        {
            string script = $"alert('{message}');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        private void ClearFields()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
