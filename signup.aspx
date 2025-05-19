<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="LibrarySystem.Signup" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --primary-light: #6f84ff;
            --background: #f8fafc;
            --surface: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border: #e2e8f0;
            --border-focus: #4361ee;
            --success: #10b981;
            --error: #ef4444;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .signup-container {
            width: 100%;
            max-width: 420px;
            position: relative;
        }

        .signup-card {
            background: var(--surface);
            border-radius: 16px;
            box-shadow: 
                0 10px 25px rgba(67, 97, 238, 0.1),
                0 20px 48px rgba(67, 97, 238, 0.1);
            padding: 40px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 32px;
        }

        .logo {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
        }

        .logo-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .logo-icon::before {
            content: '';
            width: 16px;
            height: 16px;
            background: white;
            border-radius: 3px;
            position: relative;
        }

        .logo-icon::after {
            content: '';
            position: absolute;
            top: 8px;
            left: 8px;
            width: 6px;
            height: 10px;
            border: 2px solid var(--primary);
            border-top: none;
            border-left: none;
            background: transparent;
        }

        .logo-text {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.02em;
        }

        .signup-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            text-align: center;
            margin-bottom: 8px;
            letter-spacing: -0.03em;
        }

        .signup-subtitle {
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 32px;
            font-size: 15px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-primary);
            font-size: 14px;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            font-size: 15px;
            line-height: 1.5;
            color: var(--text-primary);
            background: var(--surface);
            border: 2px solid var(--border);
            border-radius: 12px;
            transition: all 0.2s ease;
            font-family: inherit;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--border-focus);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .form-input:hover:not(:focus) {
            border-color: var(--text-secondary);
        }

        .form-input::placeholder {
            color: var(--text-secondary);
        }

        .btn-signup {
            width: 100%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 16px 24px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            font-family: inherit;
            position: relative;
            overflow: hidden;
        }

        .btn-signup:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.4);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .btn-signup::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-signup:hover::before {
            left: 100%;
        }

        .form-footer {
            text-align: center;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid var(--border);
        }

        .form-footer-text {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .form-footer-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .form-footer-link:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 18px;
        }

        .form-input.with-icon {
            padding-left: 48px;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .signup-card {
                padding: 32px 24px;
                margin: 16px;
            }
            
            .signup-title {
                font-size: 24px;
            }
        }

        /* Loading state */
        .btn-signup.loading {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .btn-signup.loading::after {
            content: '';
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 8px;
            display: inline-block;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Success/Error states */
        .form-input.success {
            border-color: var(--success);
        }

        .form-input.error {
            border-color: var(--error);
        }

        .error-message {
            color: var(--error);
            font-size: 12px;
            margin-top: 4px;
            display: none;
        }

        .form-input.error + .error-message {
            display: block;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-card">
            <div class="logo-section">
                <div class="logo">
                    <span class="logo-text">BookWise</span>
                </div>
            </div>
            
            <h1 class="signup-title">Create Account</h1>
            
            <form id="form1" runat="server">
                <div class="form-group">
                    <label for="txtName" class="form-label">Full Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter your full name" />
                    <div class="error-message">Please enter your full name</div>
                </div>
                
                <div class="form-group">
                    <label for="txtEmail" class="form-label">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-input" placeholder="Enter your email address" />
                    <div class="error-message">Please enter a valid email address</div>
                </div>
                
                <div class="form-group">
                    <label for="txtPassword" class="form-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Create a password" />
                    <div class="error-message">Password must be at least 8 characters</div>
                </div>
                
                <div class="form-group">
                    <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Confirm your password" />
                    <div class="error-message">Passwords do not match</div>
                </div>
                
                <asp:Button ID="Button1" runat="server" Text="Create Account" CssClass="btn-signup" OnClick="btnSignup_Click" />

                <div class="form-footer">
                    <span class="form-footer-text">Already have an account? </span>
                    <a href="Login.aspx" class="form-footer-link">Sign in</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('.form-input');
            const form = document.getElementById('form1');
            
            // Add focus/blur effects
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                    this.parentElement.style.transition = 'transform 0.2s ease';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });
            
            // Form validation (basic client-side)
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (input.value.trim() === '') {
                        input.classList.add('error');
                        isValid = false;
                    } else {
                        input.classList.remove('error');
                        input.classList.add('success');
                    }
                });
                
                // Password matching
                const password = document.getElementById('txtPassword');
                const confirmPassword = document.getElementById('txtConfirmPassword');
                
                if (password.value !== confirmPassword.value) {
                    confirmPassword.classList.add('error');
                    isValid = false;
                }
                
                if (!isValid) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>