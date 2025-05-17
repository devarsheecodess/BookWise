<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LibrarySystem.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Dashboard</title>
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
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #1abc9c;
        }

        .main-content {
            flex: 1;
            padding: 30px;
        }

        .section {
            display: none;
        }

        .section.active {
            display: block;
        }

        h3 {
            margin-bottom: 15px;
            color: #333;
        }

        input[type="text"], input[type="date"] {
            width: 300px;
            padding: 8px 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            display: block;
        }

        .btn {
            padding: 10px 20px;
            background-color: #1abc9c;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn:hover {
            background-color: #16a085;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <div class="sidebar">
                <h2>Dashboard</h2>
                <a href="Home.aspx">🏠 Home</a>
                <a data-target="addBookSection">➕ Add Book</a>
                <a data-target="borrowBookSection">📗 Add Borrowed Book</a>
                <a data-target="searchBookSection">🔍 Search Books</a>
                <a data-target="borrowedInfoSection">📋 Borrowed Info</a>
            </div>

            <div class="main-content">

               

                

               

               

            </div>
        </div>
    </form>
</body>
</html>
