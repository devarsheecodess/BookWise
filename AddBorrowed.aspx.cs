using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace LibrarySystem
{
    public partial class AddBorrowed : System.Web.UI.Page
    {
        // Connection string from web.config
        private string connectionString = ConfigurationManager.ConnectionStrings["BookWiseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBorrowedBooksGrid();
            }
        }

        private void BindBorrowedBooksGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT BorrowerID, BorrowerName, BookTitle, ISBN, DueDate FROM Borrowers";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvBorrowedBooks.DataSource = dt;
                    gvBorrowedBooks.DataBind();
                }
            }
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            string borrowerName = txtBorrowerName.Text.Trim();
            string bookTitle = txtTitle.Text.Trim();
            string isbn = txtISBN.Text.Trim();
            DateTime dueDate;

            // Basic validation for date
            if (!DateTime.TryParse(duedate.Text.Trim(), out dueDate))
            {
                // You can show an error message here
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string LibraryID = hdnUserID.Value;
                string query = "INSERT INTO Borrowers (BorrowerName, BookTitle, ISBN, DueDate, LibraryID) VALUES (@BorrowerName, @BookTitle, @ISBN, @DueDate, @LibraryID)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BorrowerName", borrowerName);
                    cmd.Parameters.AddWithValue("@BookTitle", bookTitle);
                    cmd.Parameters.AddWithValue("@ISBN", isbn);
                    cmd.Parameters.AddWithValue("@DueDate", dueDate);
                    cmd.Parameters.AddWithValue("@LibraryID", LibraryID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ClearForm();
            BindBorrowedBooksGrid();
        }

        private void ClearForm()
        {
            txtBorrowerName.Text = "";
            txtTitle.Text = "";
            txtISBN.Text = "";
            duedate.Text = "";
        }

        protected void gvBorrowedBooks_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBorrowedBooks.EditIndex = e.NewEditIndex;
            BindBorrowedBooksGrid();
        }

        protected void gvBorrowedBooks_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBorrowedBooks.EditIndex = -1;
            BindBorrowedBooksGrid();
        }

        protected void gvBorrowedBooks_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int borrowerID = Convert.ToInt32(gvBorrowedBooks.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvBorrowedBooks.Rows[e.RowIndex];

            string borrowerName = (row.Cells[0].Controls[0] as TextBox)?.Text.Trim();
            string bookTitle = (row.Cells[1].Controls[0] as TextBox)?.Text.Trim();
            string isbn = (row.Cells[2].Controls[0] as TextBox)?.Text.Trim();
            string dueDateText = (row.Cells[3].Controls[0] as TextBox)?.Text.Trim();

            DateTime dueDate;
            if (!DateTime.TryParse(dueDateText, out dueDate))
            {
                // Handle invalid date format
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Borrowers SET BorrowerName=@BorrowerName, BookTitle=@BookTitle, ISBN=@ISBN, DueDate=@DueDate WHERE BorrowerID=@BorrowerID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BorrowerName", borrowerName);
                    cmd.Parameters.AddWithValue("@BookTitle", bookTitle);
                    cmd.Parameters.AddWithValue("@ISBN", isbn);
                    cmd.Parameters.AddWithValue("@DueDate", dueDate);
                    cmd.Parameters.AddWithValue("@BorrowerID", borrowerID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvBorrowedBooks.EditIndex = -1;
            BindBorrowedBooksGrid();
        }

        protected void gvBorrowedBooks_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int borrowerID = Convert.ToInt32(gvBorrowedBooks.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Borrowers WHERE BorrowerID=@BorrowerID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@BorrowerID", borrowerID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindBorrowedBooksGrid();
        }
    }
}
