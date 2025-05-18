<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LibrarySystem.Home" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookWise - Library Dashboard</title>
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

        /* Stats Card Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            display: flex;
            align-items: center;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.5rem;
        }

        .stat-data {
            flex: 1;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .books-total .stat-icon {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .books-borrowed .stat-icon {
            background-color: rgba(46, 196, 182, 0.1);
            color: var(--success);
        }

        .books-overdue .stat-icon {
            background-color: rgba(231, 29, 54, 0.1);
            color: var(--danger);
        }

        .active-users .stat-icon {
            background-color: rgba(255, 159, 28, 0.1);
            color: var(--warning);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .activity-grid {
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

            .stats-grid {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 1.5rem;
            }
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
                <a href="Home.aspx" class="nav-link active">
                        <i class="fas fa-tachometer-alt"></i>                    
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
                        <i class="fas fa-tachometer-alt"></i>
                        Dashboard
                    </h1>
                    <div class="date-info">
                    <div class="user-name" style="font-weight: 600; color: var(--primary); margin-left: 20px;"></div>
                        <div class="current-date"><%= DateTime.Now.ToString("dddd, MMMM dd, yyyy") %></div>
                        <div class="current-time"><%= DateTime.Now.ToString("hh:mm tt") %></div>
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card books-total">
                        <div class="stat-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div class="stat-data">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Total Books</div>
                        </div>
                    </div>
                    
                    <div class="stat-card books-borrowed">
                        <div class="stat-icon">
                            <i class="fas fa-book-reader"></i>
                        </div>
                        <div class="stat-data">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Books Borrowed</div>
                        </div>
                    </div>
                    
                    <div class="stat-card books-overdue">
                        <div class="stat-icon">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="stat-data">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Overdue Books</div>
                        </div>
                    </div>
                    
                    <div class="stat-card active-users">
                        <div class="stat-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="stat-data">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Active Members</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // You could add JavaScript for interactivity here
        document.addEventListener('DOMContentLoaded', function() {
            // Example: Toggle sidebar for mobile devices
            const menuToggle = document.querySelector('.menu-toggle');
            const sidebar = document.querySelector('.sidebar');
            
            if (menuToggle) {
                menuToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                });
            }

            // Display user name from localStorage
            const userFullName = localStorage.getItem('userFullName');
            if (userFullName) {
                const nameElem = document.querySelector('.user-name');
                if (nameElem) {
                    nameElem.textContent = "Welcome Back, " + userFullName;
                }
            }
        });

        const logout = () => {
            const cf = confirm("Are you sure you want to logout?")
            if (!cf) return
            localStorage.clear()
            window.location.href = "login.aspx"
        }
    </script>
</body>
</html>