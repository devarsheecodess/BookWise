<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LibrarySystem.Search" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Dashboard - Search Books</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
        }

        .dashboard-container {
            display: flex;
            height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .sidebar h2 {
            margin: 0 0 30px;
            font-size: 22px;
            text-align: center;
        }

        .sidebar a {
            padding: 12px 16px;
            text-decoration: none;
            color: white;
            border-radius: 6px;
            margin-bottom: 10px;
            transition: background 0.3s ease;
            cursor: pointer;
            display: block;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #1abc9c;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        /* Search Book Section */
        .section {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            max-width: 600px;
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
            margin-bottom: 20px;
        }

        .btn:hover {
            background-color: #16a085;
        }

        /* GridView styling */
        .search-grid {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .search-grid th, .search-grid td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .search-grid th {
            background-color: #1abc9c;
            color: white;
            font-weight: 600;
        }

        .search-grid tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .search-grid tr:hover {
            background-color: #e0f7f4;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <h2>BookWise</h2>
                <a href="Home.aspx">🏠 Home</a>
                <a href="Books.aspx">➕ Books</a>
                <a href="AddBorrowed.aspx">📗 Add Borrowed Book</a>
                <a href="Search.aspx" class="active">🔍 Search Books</a>
                <a href="Customers.aspx">📋 Customer Info</a>
            </div>

            <!-- Search Book Section -->
            <div class="main-content">
                <div id="searchBookSection" class="section">
                    <h3>Search Books</h3>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="input-text" Placeholder="Enter book title or author" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" />
                    <asp:GridView ID="gridSearchResults" runat="server" CssClass="search-grid" AutoGenerateColumns="true" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
