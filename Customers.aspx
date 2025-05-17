<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="LibrarySystem.Customers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <title>Library Dashboard - Add Borrowed Book</title>
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

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        /* Borrow Book Section */
        .section {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
        }

        .section h3 {
            color: #333;
            margin-bottom: 20px;
        }

        .input-text {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 1.5px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .input-text:focus {
            border-color: #1abc9c;
            outline: none;
        }

        .btn {
            padding: 12px 25px;
            background-color: #1abc9c;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #16a085;
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
                        <i class="fas fa-home"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="Books.aspx" class="nav-link">
                        <i class="fas fa-book"></i>
                        <span>Books</span>
                    </a>
                    <a href="AddBorrowed.aspx" class="nav-link">
                        <i class="fas fa-bookmark"></i>
                        <span>Borrowed Books</span>
                    </a>
                    <a href="Customers.aspx" class="nav-link active">
                        <i class="fas fa-users"></i>
                        <span>Customers</span>
                    </a>
                </div>
    
                <!-- Logout Button -->
                <a class="logout-btn" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>

            <!-- Borrowed Info Section -->
            <div class="main-content">
                <div id="borrowedInfoSection" class="section">
                    <h3>Borrowed Books Info</h3>
                    <asp:GridView ID="gridBorrowedBooks" runat="server" AutoGenerateColumns="true" CssClass="borrowed-grid" />
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