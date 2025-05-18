using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace LibrarySystem
{
    public partial class Books : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBooks();
                BindBooksGrid();
            }
        }

        private void LoadBooks()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;
            string userId = hdnUserID.Value;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"SELECT Title, Author, ISBN, Publisher, PublishYear, Quantity 
                                   FROM Books WHERE UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvBooks.DataSource = dt;
                        gvBooks.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle or log error here
            }
        }

        protected void BtnAddBook_Click(object sender, EventArgs e)
        {
            string userId = hdnUserID.Value;
            if (string.IsNullOrEmpty(userId))
            {
                ShowAlert("User not logged in.");
                return;
            }

            string title = txtBookTitle.Text.Trim();
            string author = txtAuthor.Text.Trim();
            string isbn = txtISBN.Text.Trim();
            string publisher = txtPublisher.Text.Trim();
            string publishYearText = txtPublishYear.Text.Trim();
            string quantityText = txtQuantity.Text.Trim();

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(author) || string.IsNullOrEmpty(isbn))
            {
                ShowAlert("Please enter Title, Author, and ISBN.");
                return;
            }

            if (!int.TryParse(publishYearText, out int publishYear))
            {
                ShowAlert("Publish Year must be a number.");
                return;
            }

            if (!int.TryParse(quantityText, out int quantity))
            {
                ShowAlert("Quantity must be a number.");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"INSERT INTO Books (UserID, Title, Author, ISBN, Publisher, PublishYear, Quantity)
                           VALUES (@UserID, @Title, @Author, @ISBN, @Publisher, @PublishYear, @Quantity)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Author", author);
                        cmd.Parameters.AddWithValue("@ISBN", isbn);
                        cmd.Parameters.AddWithValue("@Publisher", string.IsNullOrEmpty(publisher) ? DBNull.Value : (object)publisher);
                        cmd.Parameters.AddWithValue("@PublishYear", publishYear);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            ShowAlert("Book added successfully!");
                            ClearForm();
                        }
                        else
                        {
                            ShowAlert("Failed to add book.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        private void ShowAlert(string message)
        {
            string script = $"alert('{message.Replace("'", "\\'")}');";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        private void ClearForm()
        {
            txtBookTitle.Text = "";
            txtAuthor.Text = "";
            txtISBN.Text = "";
            txtPublisher.Text = "";
            txtPublishYear.Text = "";
            txtQuantity.Text = "";
        }

        private void BindBooksGrid()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT BookID, Title, Author, ISBN, Publisher, PublishYear, Quantity FROM Books";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        gvBooks.DataSource = dt;
                        gvBooks.DataBind();
                    }
                }
            }
        }

        protected void gvBooks_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBooks.EditIndex = e.NewEditIndex;
            BindBooksGrid();
        }

        protected void gvBooks_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBooks.EditIndex = -1;
            BindBooksGrid();
        }

        protected void gvBooks_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int bookId = Convert.ToInt32(gvBooks.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvBooks.Rows[e.RowIndex];

            // Get new values from the edited row's TextBoxes
            string title = (row.Cells[0].Controls[0] as TextBox)?.Text.Trim();
            string author = (row.Cells[1].Controls[0] as TextBox)?.Text.Trim();
            string isbn = (row.Cells[2].Controls[0] as TextBox)?.Text.Trim();
            string publisher = (row.Cells[3].Controls[0] as TextBox)?.Text.Trim();

            string publishYearText = (row.Cells[4].Controls[0] as TextBox)?.Text.Trim();
            string quantityText = (row.Cells[5].Controls[0] as TextBox)?.Text.Trim();

            if (!int.TryParse(publishYearText, out int publishYear))
                publishYear = 0; // or handle validation

            if (!int.TryParse(quantityText, out int quantity))
                quantity = 0; // or handle validation

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"UPDATE Books SET Title = @Title, Author = @Author, ISBN = @ISBN, Publisher = @Publisher, 
                               PublishYear = @PublishYear, Quantity = @Quantity WHERE BookID = @BookID";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Author", author);
                    cmd.Parameters.AddWithValue("@ISBN", isbn);
                    cmd.Parameters.AddWithValue("@Publisher", string.IsNullOrEmpty(publisher) ? DBNull.Value : (object)publisher);
                    cmd.Parameters.AddWithValue("@PublishYear", publishYear);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    cmd.Parameters.AddWithValue("@BookID", bookId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvBooks.EditIndex = -1;
            BindBooksGrid();
        }

        protected void gvBooks_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int bookId = Convert.ToInt32(gvBooks.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "DELETE FROM Books WHERE BookID = @BookID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindBooksGrid();
        }

        protected void btnTriggerSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = hdnSearchTerm.Value.Trim();
            BindBooksGrid(searchTerm);
        }

        private void BindBooksGrid(string searchTerm = "")
        {
            string connStr = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT BookID, Title, Author, ISBN, Publisher, PublishYear, Quantity FROM Books";

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    sql += @" WHERE Title LIKE @Search OR Author LIKE @Search OR ISBN LIKE @Search OR Publisher LIKE @Search";
                }

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    gvBooks.DataSource = dt;
                    gvBooks.DataBind();
                }
            }
        }

    }
}
