using System;
using System.Configuration;
using System.Data.SqlClient;

namespace LibrarySystem
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Store userName in localStorage from Session on first load
            if (!IsPostBack && Session["userName"] != null)
            {
                string name = Session["userName"].ToString();
                string script = $"localStorage.setItem('userName', '{name}');";
                ClientScript.RegisterStartupScript(this.GetType(), "storeName", script, true);
                Session["userName"] = null;
            }

            if (!IsPostBack)
            {
                // Maybe nothing yet, or load default stats
                LoadStats(null);
            }
            else
            {
                string userID = HiddenUserID.Value;
                if (!string.IsNullOrEmpty(userID))
                {
                    // Use this userID for your stats
                    LoadStats(userID);

                    // Optional debug alert:
                    string script = $"alert('UserID is: {userID}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "showUserID", script, true);
                }
                else
                {
                    LoadStats(null);
                }
            }
        }

        private void LoadStats(string userID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;

            int totalBooks = 0;
            int booksBorrowed = 0;
            int overdueBooks = 0;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Total Books
                string totalBooksQuery = userID != null
                    ? "SELECT COUNT(*) FROM Books WHERE UserID = @UserID"
                    : "SELECT COUNT(*) FROM Books";

                using (SqlCommand cmd = new SqlCommand(totalBooksQuery, conn))
                {
                    if (userID != null)
                        cmd.Parameters.AddWithValue("@UserID", userID);

                    totalBooks = (int)cmd.ExecuteScalar();
                }

                // Books Borrowed
                string booksBorrowedQuery = userID != null
                    ? "SELECT COUNT(*) FROM Borrowers WHERE LibraryID = @UserID"
                    : "SELECT COUNT(*) FROM Borrowers";

                using (SqlCommand cmd = new SqlCommand(booksBorrowedQuery, conn))
                {
                    if (userID != null)
                        cmd.Parameters.AddWithValue("@UserID", userID);

                    booksBorrowed = (int)cmd.ExecuteScalar();
                }

                // Overdue Books
                string overdueBooksQuery = userID != null
                    ? "SELECT COUNT(*) FROM Borrowers WHERE DueDate < GETDATE() AND LibraryID = @UserID"
                    : "SELECT COUNT(*) FROM Borrowers WHERE DueDate < GETDATE()";

                using (SqlCommand cmd = new SqlCommand(overdueBooksQuery, conn))
                {
                    if (userID != null)
                        cmd.Parameters.AddWithValue("@UserID", userID);

                    overdueBooks = (int)cmd.ExecuteScalar();
                }
            }

            // Update server-side controls (make sure these have runat="server" in aspx)
            BooksTotalValue.InnerText = totalBooks.ToString();
            BooksBorrowedValue.InnerText = booksBorrowed.ToString();
            BooksOverdueValue.InnerText = overdueBooks.ToString();
        }
    }
}
