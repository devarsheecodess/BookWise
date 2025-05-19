<%@ Page Title="BookWise" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibrarySystem._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background);
            color: var(--text);
            line-height: 1.6;
        }

        /* Navigation Styles */
        .navbar {
            background-color: var(--white);
            box-shadow: var(--card-shadow);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            font-size: 1.8rem;
            font-weight: 700;
            margin-right: 50px;
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
        }

        .nav-brand:hover {
            color: var(--primary-dark);
            text-decoration: none;
        }

        .nav-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            cursor: pointer;
            font-size: 0.95rem;
            display: inline-block;
        }

        .btn-outline {
            background-color: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-outline:hover {
            background-color: var(--primary);
            color: var(--white);
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--white);
            border: 2px solid var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            text-decoration: none;
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        /* Main Content Styles */
        .main-content {
            margin-top: 80px;
            min-height: calc(100vh - 80px);
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            width: 100%;
        }

        .hero-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
            min-height: 80vh;
        }

        .hero-content {
            animation: fadeInLeft 1s ease-out;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .hero-title .brand-highlight {
            color: var(--primary);
            position: relative;
        }

        .hero-title .brand-highlight::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            bottom: -5px;
            left: 0;
            border-radius: 2px;
        }

        .hero-tagline {
            font-size: 1.3rem;
            color: var(--text-light);
            margin-bottom: 2rem;
            font-weight: 400;
        }

        .hero-cta {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .hero-visual {
            display: flex;
            justify-content: center;
            align-items: center;
            animation: fadeInRight 1s ease-out;
        }

        .logo-container {
            width: 400px;
            height: 400px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }

        .logo-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shimmer 3s infinite;
        }

        .logo-icon {
            font-size: 8rem;
            color: var(--white);
            z-index: 2;
        }

        /* Animations */
        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes shimmer {
            0% {
                transform: translateX(-100%) translateY(-100%) rotate(45deg);
            }
            100% {
                transform: translateX(100%) translateY(100%) rotate(45deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-container {
                padding: 0 1rem;
            }

            .nav-brand {
                font-size: 1.5rem;
            }

            .nav-buttons {
                gap: 0.5rem;
            }

            .btn {
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }

            .hero-section {
                grid-template-columns: 1fr;
                gap: 2rem;
                text-align: center;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-tagline {
                font-size: 1.1rem;
            }

            .logo-container {
                width: 300px;
                height: 300px;
            }

            .logo-icon {
                font-size: 6rem;
            }

            .hero-cta {
                justify-content: center;
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .hero-title {
                font-size: 2rem;
            }

            .logo-container {
                width: 250px;
                height: 250px;
            }

            .logo-icon {
                font-size: 5rem;
            }

            .nav-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
            }
        }
    </style>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="#" class="nav-brand">BookWise</a>
            <div class="nav-buttons">
                <a href="Login.aspx" class="btn btn-outline">Login</a>
                <a href="Signup.aspx" class="btn btn-primary">Sign Up</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">
                        Welcome to <span class="brand-highlight">BookWise</span>
                    </h1>
                    <p class="hero-tagline">
                        Your intelligent library management solution. Streamline operations, enhance user experience, and bring your library into the digital age.
                    </p>
                    <div class="hero-cta">
                        <a href="Signup.aspx" class="btn btn-primary">Get Started</a>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="logo-container">
                        <span class="logo-icon">📚</span>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>