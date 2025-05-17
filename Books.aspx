
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="LibrarySystem.Books" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookWise - Book Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
            margin: 0;
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

        .user-section {
            margin-top: auto;
            background-color: rgba(0, 0, 0, 0.1);
            padding: 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background-color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            color: var(--primary);
            font-weight: bold;
            font-size: 16px;
        }

        .user-info {
            flex: 1;
        }

        .user-name {
            font-weight: 600;
            font-size: 0.95rem;
        }

        .user-role {
            font-size: 0.8rem;
            opacity: 0.8;
        }
        
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

        .date-info {
            text-align: right;
            font-size: 0.95rem;
            color: var(--text-light);
        }

        .date-info .current-date {
            font-weight: 600;
            color: var(--text);
            font-size: 1.1rem;
            margin-bottom: 4px;
        }

        /* Book Management Section */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 1.5rem;
        }

        .card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        .form-card {
            height: fit-content;
        }

        .form-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .form-title i {
            margin-right: 10px;
            color: var(--primary);
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
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            line-height: 1.5;
            color: var(--text);
            background-color: var(--white);
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .btn {
            display: inline-block;
            font-weight: 500;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 8px;
            transition: var(--transition);
            color: var(--white);
            background-color: var(--primary);
            border: none;
        }

        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--white);
        }

        .btn-success {
            background-color: var(--success);
            color: var(--white);
        }

        .btn-warning {
            background-color: var(--warning);
            color: var(--white);
        }

        .btn-danger {
            background-color: var(--danger);
            color: var(--white);
        }

        /* Book List Section */
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: var(--primary);
        }

        .books-table {
            width: 100%;
            border-collapse: collapse;
        }

        .books-table th,
        .books-table td {
            padding: 0.75rem 1rem;
            text-align: left;
        }

        .books-table th {
            font-weight: 600;
            color: var(--text-light);
            font-size: 0.9rem;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .books-table td {
            border-bottom: 1px solid rgba(0,0,0,0.05);
            vertical-align: middle;
        }

        .books-table tr:last-child td {
            border-bottom: none;
        }

        .book-title {
            display: flex;
            align-items: center;
        }

        .book-color {
            width: 30px;
            height: 18px;
            border-radius: 4px;
            margin-right: 8px;
        }

        .availability-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .avail-yes {
            background-color: rgba(46, 196, 182, 0.1);
            color: var(--success);
        }

        .avail-no {
            background-color: rgba(231, 29, 54, 0.1);
            color: var(--danger);
        }

        .avail-limited {
            background-color: rgba(255, 159, 28, 0.1);
            color: var(--warning);
        }

        .action-links {
            display: flex;
            gap: 0.5rem;
        }

        .action-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 6px;
            text-decoration: none;
            transition: var(--transition);
        }

        .edit-link {
            background-color: rgba(63, 142, 252, 0.1);
            color: var(--secondary);
        }

        .edit-link:hover {
            background-color: rgba(63, 142, 252, 0.2);
        }

        .delete-link {
            background-color: rgba(231, 29, 54, 0.1);
            color: var(--danger);
        }

        .delete-link:hover {
            background-color: rgba(231, 29, 54, 0.2);
        }

        /* Search and Filter Bar */
        .search-filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
        }

        .search-container {
            position: relative;
            max-width: 400px;
            width: 100%;
        }

        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            font-size: 0.95rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: var(--transition);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }

        .filter-btn {
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: var(--white);
            color: var(--text);
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
        }

        .filter-btn i {
            margin-right: 8px;
        }

        .filter-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: flex;
            }
        }

        @media (max-width: 576px) {
            .main-content {
                padding: 1.5rem;
            }
            
            .search-filter-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .search-container {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
                    <a href="Books.aspx" class="nav-link active">
                        <i class="fas fa-book"></i>
                        <span>Books</span>
                    </a>
                    <a href="AddBorrowed.aspx" class="nav-link">
                        <i class="fas fa-bookmark"></i>
                        <span>Borrowed Books</span>
                    </a>
                </div>
                
                <!-- Logout Button -->
                <a class="logout-btn" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
            
            <!-- Main Content -->
            <div class="main-content">
                <div class="top-bar">
                    <h1 class="page-title">
                        <i class="fas fa-book"></i>
                        Books
                    </h1>
                    <div class="date-info">
                        <div class="current-date"><%= DateTime.Now.ToString("dddd, MMMM dd, yyyy") %></div>
                        <div class="current-time"><%= DateTime.Now.ToString("hh:mm tt") %></div>
                    </div>
                </div>
                
                <!-- Book Management Section -->
                <div class="content-grid">
                    <!-- Book Form -->
                    <div class="card form-card">
                        <h2 class="form-title"><i class="fas fa-plus-circle"></i>Add New Book</h2>
                        
                        <div class="form-group">
                            <label for="txtBookTitle" class="form-label">Book Title</label>
                            <asp:TextBox ID="txtBookTitle" runat="server" CssClass="form-control" Placeholder="Enter book title" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtAuthor" class="form-label">Author</label>
                            <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" Placeholder="Enter author name" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtISBN" class="form-label">ISBN</label>
                            <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control" Placeholder="Enter ISBN number" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPublisher" class="form-label">Publisher</label>
                            <asp:TextBox ID="txtPublisher" runat="server" CssClass="form-control" Placeholder="Enter publisher name" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPublishYear" class="form-label">Publication Year</label>
                            <asp:TextBox ID="txtPublishYear" runat="server" CssClass="form-control" Placeholder="Enter publication year" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtQuantity" class="form-label">Quantity</label>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" Placeholder="Enter quantity" TextMode="Number" />
                        </div>
                        
                        <asp:Button ID="btnAddBook" runat="server" Text="Add Book" CssClass="btn btn-primary" />
                    </div>
                    
                    <!-- Book List Table -->
                    <div class="card">
                        <div class="search-filter-bar">
                            <div class="search-container">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" class="search-input" placeholder="Search books...">
                            </div>
                        </div>
                        
                        <h2 class="section-title"><i class="fas fa-list"></i>Book Inventory</h2>
                        
                        <table class="books-table">
                            <thead>
                                <tr>
                                    <th>Book Title</th>
                                    <th>Author</th>
                                    <th>ISBN</th>
                                    <th>Publication</th>
                                    <th>Available</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Sample data -->
                                <tr>
                                    <td class="book-title">
                                        <div class="book-color" style="background-color: #4361ee;"></div>
                                        <span>The Great Gatsby</span>
                                    </td>
                                    <td>F. Scott Fitzgerald</td>
                                    <td>9780743273565</td>
                                    <td>2004</td>
                                    <td><span class="availability-badge avail-yes">In Stock (5)</span></td>
                                    <td class="action-links">
                                        <a href="#" class="action-link edit-link"><i class="fas fa-edit"></i></a>
                                        <a href="#" class="action-link delete-link"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="book-title">
                                        <div class="book-color" style="background-color: #ff9f1c;"></div>
                                        <span>To Kill a Mockingbird</span>
                                    </td>
                                    <td>Harper Lee</td>
                                    <td>9780061120084</td>
                                    <td>2006</td>
                                    <td><span class="availability-badge avail-limited">Low Stock (1)</span></td>
                                    <td class="action-links">
                                        <a href="#" class="action-link edit-link"><i class="fas fa-edit"></i></a>
                                        <a href="#" class="action-link delete-link"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="book-title">
                                        <div class="book-color" style="background-color: #e71d36;"></div>
                                        <span>1984</span>
                                    </td>
                                    <td>George Orwell</td>
                                    <td>9780451524935</td>
                                    <td>1950</td>
                                    <td><span class="availability-badge avail-no">Out of Stock</span></td>
                                    <td class="action-links">
                                        <a href="#" class="action-link edit-link"><i class="fas fa-edit"></i></a>
                                        <a href="#" class="action-link delete-link"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        const logout = () => {
            const cf = confirm("Are you sure you want to logout?")
            if (!cf) return
            window.location.href = "login.aspx"
        }
    </script>
</body>
</html>