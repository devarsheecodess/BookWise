<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBorrowed.aspx.cs" Inherits="LibrarySystem.AddBorrowed" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Borrowed Books</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #3f8efc;
            --accent: #60efff;
            --text: #2b2d42;
            --text-light: #8d99ae;
            --background: #f8f9fa;
            --white: #ffffff;
            --success: #2ec4b6;
            --warning: #ff9f1c;
            --danger: #e71d36;
            --card-shadow: 0 4px 12px rgba(0,0,0,0.08);
            --transition: all 0.25s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            background-color: var(--background);
            color: var(--text);
            overflow-x: hidden;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
.sidebar {
    width: 280px;
    background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
    color: var(--white);
    padding: 2rem 1.5rem;
    display: flex;
    flex-direction: column;
    transition: var(--transition);
    position: fixed;
    height: 100vh;
    z-index: 100;
}

.sidebar-header {
    display: flex;
    align-items: center;
    margin-bottom: 2.5rem;
}

.logo-icon {
    font-size: 24px;
    margin-right: 10px;
}

.sidebar-brand {
    font-size: 1.75rem;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.nav-menu {
    display: flex;
    flex-direction: column;
    flex: 1;
}

.nav-link {
    display: flex;
    align-items: center;
    padding: 0.875rem 1rem;
    text-decoration: none;
    color: rgba(255, 255, 255, 0.85);
    border-radius: 8px;
    margin-bottom: 0.5rem;
    transition: var(--transition);
    font-weight: 500;
}

.nav-link i {
    margin-right: 12px;
    font-size: 1.1rem;
    width: 24px;
    text-align: center;
}

.nav-link:hover {
    background-color: rgba(255, 255, 255, 0.1);
    color: var(--white);
}

.nav-link.active {
    background-color: var(--white);
    color: var(--primary);
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.12);
}

        /* Logout button style */
      .logout-btn {
    margin-top: 1rem;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    text-align: center;
    color: var(--white) !important;
    font-weight: 500;
    transition: var(--transition);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0.875rem 1rem;
    cursor: pointer;
}

.logout-btn:hover {
    background-color: rgba(231, 29, 54, 0.2);
}

        .logout-btn i {
            margin-right: 10px;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            padding: 2rem;
            margin-left: 280px;
            transition: var(--transition);
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
        }

        .page-title i {
            margin-right: 12px;
            font-size: 1.8rem;
            color: var(--primary);
            background-color: rgba(67, 97, 238, 0.1);
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        /* Card Styles */
        .card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text);
            display: flex;
            align-items: center;
            margin: 0;
        }

        .card-title i {
            margin-right: 10px;
            color: var(--primary);
            background-color: rgba(67, 97, 238, 0.1);
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            font-size: 1rem;
        }

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text);
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            font-size: 0.95rem;
            line-height: 1.5;
            color: var(--text);
            background-color: var(--white);
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            transition: var(--transition);
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            background-color: var(--white);
        }

        .form-control:hover {
            border-color: #cbd5e0;
        }

        /* Input Groups */
        .input-group {
            position: relative;
        }

        .input-group-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            font-size: 1rem;
            z-index: 2;
        }

        .input-group .form-control {
            padding-left: 2.75rem;
        }

        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            padding: 0.875rem 1.75rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 8px;
            transition: var(--transition);
            border: none;
            text-decoration: none;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--white);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        /* Icon for Add Button */
        .btn-primary::before {
            content: '\f067';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 8px;
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.08);
        }

        /* Required Field Indicator */
        .required {
            color: var(--danger);
            margin-left: 3px;
        }

        /* Table Styles */
        .table-section {
            margin-top: 2rem;
        }

        .table-header {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid rgba(67, 97, 238, 0.1);
        }

        .table-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text);
            margin: 0;
            display: flex;
            align-items: center;
        }

        .table-title::before {
            content: '\f02d';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 12px;
            color: var(--primary);
            background-color: rgba(67, 97, 238, 0.1);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            font-size: 1.1rem;
        }

        /* Enhanced GridView Styles */
        .books-table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--white);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0,0,0,0.05);
        }

        .books-table th {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: var(--white);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem 1.25rem;
            text-align: left;
            border: none;
        }

        .books-table td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            vertical-align: middle;
            font-size: 0.95rem;
            color: var(--text);
        }

        .books-table tr:last-child td {
            border-bottom: none;
        }

        .books-table tr:hover {
            background-color: rgba(67, 97, 238, 0.02);
            transition: var(--transition);
        }

        /* Empty data styling */
        .books-table .empty-data {
            text-align: center;
            padding: 3rem 2rem;
            color: var(--text-light);
            font-style: italic;
            background-color: rgba(0,0,0,0.02);
        }

        .books-table .empty-data::before {
            content: '\f02d';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            display: block;
            font-size: 3rem;
            color: var(--text-light);
            margin-bottom: 1rem;
            opacity: 0.3;
        }

        /* Column-specific styling */
        .books-table td:nth-child(1) {
            font-weight: 500;
            color: var(--primary);
        }

        .books-table td:nth-child(3) {
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            background-color: rgba(0,0,0,0.02);
        }

        .books-table td:nth-child(4) {
            font-weight: 600;
        }

        /* Action buttons in GridView */
        .books-table a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            transition: var(--transition);
            margin-right: 0.5rem;
        }

        .books-table a:hover {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary-dark);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .main-content {
                margin-left: 0;
                padding: 1.5rem;
            }
            
            .card {
                padding: 1.5rem;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }

            .books-table-container {
                overflow-x: auto;
                border-radius: 12px;
                box-shadow: var(--card-shadow);
            }
            
            .books-table {
                min-width: 600px;
                box-shadow: none;
            }
            
            .books-table th,
            .books-table td {
                padding: 0.75rem 1rem;
                font-size: 0.85rem;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 1.5rem;
            }
            
            .form-actions {
                gap: 0.75rem;
            }
        }

        /* Hide original form styling */
        #form1 {
            margin-left: 0;
        }

        /* Custom styling for ASP.NET controls */
        input[type="text"], input[type="date"], textarea, select {
            background-color: var(--white) !important;
        }

        /* Message Styles */
        .message {
            padding: 1rem 1.25rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .message i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        .message.error {
            background-color: rgba(231, 29, 54, 0.1);
            color: var(--danger);
            border: 1px solid rgba(231, 29, 54, 0.2);
        }

        .message.success {
            background-color: rgba(46, 196, 182, 0.1);
            color: var(--success);
            border: 1px solid rgba(46, 196, 182, 0.2);
        }

        .message.warning {
            background-color: rgba(255, 159, 28, 0.1);
            color: var(--warning);
            border: 1px solid rgba(255, 159, 28, 0.2);
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <span class="logo-icon"><i class="fas fa-book-open"></i></span>
                <h2 class="sidebar-brand">BookWise</h2>
            </div>

            <div class="nav-menu">
                <a href="Home.aspx" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="Books.aspx" class="nav-link">
                    <i class="fas fa-book"></i>
                    <span>Books</span>
                </a>
                <a href="AddBorrowed.aspx" class="nav-link active">
                    <i class="fas fa-bookmark"></i>
                    <span>Borrowed Books</span>
                </a>
            </div>

            <a class="logout-btn" onclick="logout()">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="top-bar">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-bookmark"></i>
                        Borrowed Books
                    </h1>
                </div>
            </div>

            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <asp:HiddenField ID="hdnUserID" runat="server" />

                <!-- Borrower Form -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">
                            <i class="fas fa-user-plus"></i>
                            Add Borrower
                        </h2>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="<%= txtBorrowerName.ClientID %>">
                                Borrower's Name <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <i class="input-group-icon fas fa-user"></i>
                                <asp:TextBox ID="txtBorrowerName" runat="server" CssClass="form-control" 
                                           placeholder="Enter borrower's full name" required="true" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="<%= txtTitle.ClientID %>">
                                Book Title <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <i class="input-group-icon fas fa-book"></i>
                                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" 
                                           placeholder="Enter book title" required="true" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="<%= txtISBN.ClientID %>">
                                ISBN <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <i class="input-group-icon fas fa-barcode"></i>
                                <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control" 
                                           placeholder="Enter ISBN number" required="true" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="<%= duedate.ClientID %>">
                                Due Date <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <i class="input-group-icon fas fa-calendar"></i>
                                <asp:TextBox ID="duedate" runat="server" CssClass="form-control" 
                                           TextMode="Date" required="true" />
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnAddBook" runat="server" CssClass="btn btn-primary" 
                                  Text="Add Borrowed Book" OnClick="btnAddBook_Click" />
                    </div>
                </div>

                <!-- Borrowed Books Table -->
                <div class="card table-section">
                    <div class="table-header">
                        <h2 class="table-title">Borrowed Books</h2>
                    </div>
                    
                    <div class="books-table-container">
                        <asp:UpdatePanel ID="UpdatePanelBorrowed" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvBorrowedBooks" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="BorrowerID"
                                    CssClass="books-table"
                                    OnRowEditing="gvBorrowedBooks_RowEditing"
                                    OnRowCancelingEdit="gvBorrowedBooks_RowCancelingEdit"
                                    OnRowUpdating="gvBorrowedBooks_RowUpdating"
                                    OnRowDeleting="gvBorrowedBooks_RowDeleting"
                                    EmptyDataText="No borrowed books found.">
                                    <Columns>
                                        <asp:BoundField DataField="BorrowerName" HeaderText="Borrower Name" />
                                        <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                                        <asp:BoundField DataField="ISBN" HeaderText="ISBN" />
                                        <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:CommandField HeaderText="Actions" ShowEditButton="true" ShowDeleteButton="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        const logout = () => {
            const cf = confirm("Are you sure you want to logout?")
            if (!cf) return
            window.location.href = "login.aspx"
        }

        document.addEventListener("DOMContentLoaded", function () {
            var hasReloaded = sessionStorage.getItem("hasReloaded");
            var userId = localStorage.getItem("userID");

            if (userId) {
                var hiddenInput = document.getElementById('<%= hdnUserID.ClientID %>');
                if (hiddenInput) {
                    hiddenInput.value = userId;

                    if (!hasReloaded) {
                        sessionStorage.setItem("hasReloaded", "true");
                        __doPostBack('ReloadBooks', '');
                    }
                }
            } else {
                alert("User ID not found. Please log in.");
            }
        });
    </script>
</body>
</html>