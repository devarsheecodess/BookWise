<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="LibrarySystem.WebForm1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - BookWise</title>
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

        html, body {
            height: 100%;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            overflow: hidden;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }

        .login-container {
            background: var(--surface);
            border-radius: 20px;
            box-shadow: 
                0 25px 50px rgba(67, 97, 238, 0.15),
                0 10px 25px rgba(67, 97, 238, 0.1);
            padding: 48px 40px;
            width: 100%;
            max-width: 420px;
            position: relative;
            z-index: 1;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        .logo-icon::before {
            content: '';
            width: 20px;
            height: 20px;
            background: white;
            border-radius: 4px;
            position: relative;
        }

        .logo-icon::after {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            width: 8px;
            height: 12px;
            border: 2px solid var(--primary);
            border-top: none;
            border-left: none;
            background: transparent;
        }

        .logo-text {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.03em;
        }

        .welcome-text {
            font-size: 32px;
            font-weight: 700;
            color: var(--text-primary);
            text-align: center;
            margin-bottom: 8px;
            letter-spacing: -0.03em;
        }

        .subtitle {
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 40px;
            font-size: 16px;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 28px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 15px;
        }

        .input-wrapper {
            position: relative;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 16px 20px;
            font-size: 16px;
            line-height: 1.5;
            color: var(--text-primary);
            background: var(--surface);
            border: 2px solid var(--border);
            border-radius: 12px;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--border-focus);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
            transform: translateY(-2px);
        }

        .form-group input:hover:not(:focus) {
            border-color: var(--text-secondary);
            transform: translateY(-1px);
        }

        .form-group input::placeholder {
            color: var(--text-secondary);
        }

        .login-btn {
            width: 100%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 18px 24px;
            font-size: 17px;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            position: relative;
            overflow: hidden;
            margin-top: 16px;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(67, 97, 238, 0.4);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .additional-links {
            text-align: center;
            margin-top: 32px;
            padding-top: 32px;
            border-top: 1px solid var(--border);
        }

        .additional-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            display: inline-block;
            margin: 0 16px;
        }

        .additional-links a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
            transform: translateY(-1px);
        }

        .signup-prompt {
            text-align: center;
            margin-top: 24px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .signup-prompt a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .signup-prompt a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        /* Input icons */
        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 18px;
            pointer-events: none;
            transition: color 0.3s ease;
        }

        .form-group input.with-icon {
            padding-left: 52px;
        }

        .form-group input:focus + .input-icon {
            color: var(--primary);
        }

        /* Security notice */
        .security-notice {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 1px solid #bae6fd;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 24px;
            font-size: 13px;
            color: #0369a1;
        }

        .security-notice::before {
            content: '🔒';
            margin-right: 8px;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                padding: 40px 24px;
                margin: 16px;
                border-radius: 16px;
            }
            
            .welcome-text {
                font-size: 28px;
            }
            
            .logo-text {
                font-size: 24px;
            }
        }

        /* Loading state */
        .login-btn.loading {
            opacity: 0.8;
            cursor: not-allowed;
        }

        .login-btn.loading::after {
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

        /* Form validation styles */
        .form-group input.error {
            border-color: var(--error);
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1);
        }

        .error-message {
            color: var(--error);
            font-size: 12px;
            margin-top: 6px;
            display: none;
        }

        .form-group input.error ~ .error-message {
            display: block;
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <form id="form1" runat="server">
            <div class="login-container">
                <div class="logo-section">
                    <div class="logo">
                        <span class="logo-text">BookWise</span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="txtLibraryId">Library ID</label>
                    <div class="input-wrapper">
                        <input id="txtLibraryId" type="text" runat="server" placeholder="Enter your library ID" />
                        <div class="error-message">Please enter your Library ID</div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <div class="input-wrapper">
                        <input id="txtPassword" type="password" runat="server" placeholder="Enter your password" />
                        <div class="error-message">Please enter your password</div>
                    </div>
                </div>
                
                <input id="btnLogin" type="submit" value="Sign In" class="login-btn" runat="server" />
                
                <div class="signup-prompt">
                    Don't have an account? 
                    <a href="Signup.aspx">Create one here</a>
                </div>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('form1');
            const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
            const loginBtn = document.getElementById('btnLogin');
            
            // Add floating animation to inputs
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.parentElement.style.transform = 'scale(1.02)';
                    this.parentElement.parentElement.style.transition = 'transform 0.3s ease';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.parentElement.style.transform = 'scale(1)';
                });
            });
            
            // Form validation
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (input.value.trim() === '') {
                        input.classList.add('error');
                        isValid = false;
                    } else {
                        input.classList.remove('error');
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    return false;
                }
                
                // Add loading state
                loginBtn.classList.add('loading');
                loginBtn.disabled = true;
                loginBtn.value = 'Signing in...';
            });
            
            // Clear error states on input
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    this.classList.remove('error');
                });
            });
            
            // Add ripple effect to button
            loginBtn.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.4);
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    left: ${x}px;
                    top: ${y}px;
                    width: ${size}px;
                    height: ${size}px;
                `;
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
            
            // Add CSS for ripple animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes ripple {
                    to {
                        transform: scale(2);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>