<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="LibrarySystem.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - Library System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .signup-box {
            background: white;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 360px;
        }
        .signup-box h2 {
            margin-bottom: 24px;
            font-weight: 600;
            color: #222;
            text-align: center;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #444;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1.8px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.25s ease-in-out;
        }
        input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus {
            border-color: #0078d7;
            outline: none;
        }
        .btn-signup {
            width: 100%;
            background-color: #0078d7;
            color: white;
            padding: 12px 0;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-signup:hover {
            background-color: #005a9e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-box">
            <h2>Create an Account</h2>

            <div class="form-group">
                <label for="txtName">Full Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="input-field" />
            </div>

            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="input-field" />
            </div>

            <div class="form-group">
                <label for="txtLibraryID">Library ID</label>
                <asp:TextBox ID="txtLibraryID" runat="server" CssClass="input-field" />
            </div>

            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" />
            </div>

            <div class="form-group">
                <label for="txtConfirmPassword">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="input-field" />
            </div>

            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="btn-signup" />
        </div>
    </form>
</body>
</html>
