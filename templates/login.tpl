<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{translate key="user.login"}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        {literal}
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow-x: hidden;
            }

            /* Animated background particles */
            .particles {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
                z-index: 0;
            }

            .particle {
                position: absolute;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                animation: float 20s infinite;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translateY(0) translateX(0);
                    opacity: 0;
                }

                10% {
                    opacity: 1;
                }

                90% {
                    opacity: 1;
                }

                100% {
                    transform: translateY(-100vh) translateX(50px);
                    opacity: 0;
                }
            }

            /* Main container */
            .container {
                position: relative;
                z-index: 1;
                padding: 40px;
                max-width: 450px;
                width: 90%;
                animation: fadeIn 1s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Login card */
            .login-card {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(20px);
                border-radius: 30px;
                padding: 50px 40px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .login-card h1 {
                color: white;
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 10px;
                text-align: center;
                text-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
            }

            .login-card .subtitle {
                color: rgba(255, 255, 255, 0.85);
                font-size: 0.95rem;
                text-align: center;
                margin-bottom: 35px;
            }

            /* Form elements */
            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                color: rgba(255, 255, 255, 0.95);
                font-size: 0.9rem;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .form-group input[type="text"],
            .form-group input[type="password"] {
                width: 100%;
                padding: 14px 18px;
                border: 2px solid rgba(255, 255, 255, 0.2);
                border-radius: 12px;
                background: rgba(255, 255, 255, 0.1);
                color: white;
                font-size: 1rem;
                font-family: inherit;
                transition: all 0.3s ease;
            }

            .form-group input[type="text"]::placeholder,
            .form-group input[type="password"]::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .form-group input[type="text"]:focus,
            .form-group input[type="password"]:focus {
                outline: none;
                border-color: rgba(255, 255, 255, 0.5);
                background: rgba(255, 255, 255, 0.15);
            }

            .form-group input[type="checkbox"] {
                margin-right: 8px;
            }

            .remember-me {
                display: flex;
                align-items: center;
                color: rgba(255, 255, 255, 0.9);
                font-size: 0.9rem;
                margin-bottom: 25px;
            }

            /* Submit button */
            .submit-btn {
                width: 100%;
                padding: 16px;
                background: rgba(255, 255, 255, 0.25);
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                color: white;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .submit-btn:hover {
                background: rgba(255, 255, 255, 0.35);
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }

            .submit-btn:active {
                transform: translateY(0);
            }

            /* Error message */
            .error-message {
                background: rgba(239, 68, 68, 0.2);
                border: 2px solid rgba(239, 68, 68, 0.4);
                border-radius: 12px;
                padding: 12px 16px;
                color: white;
                margin-bottom: 20px;
                font-size: 0.9rem;
            }

            /* Back link */
            .back-link {
                text-align: center;
                margin-top: 25px;
            }

            .back-link a {
                color: rgba(255, 255, 255, 0.9);
                text-decoration: none;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .back-link a:hover {
                color: white;
            }

            /* Responsive design */
            @media (max-width: 480px) {
                .login-card {
                    padding: 40px 30px;
                }

                .login-card h1 {
                    font-size: 1.75rem;
                }

                .container {
                    padding: 20px;
                }
            }

        {/literal}
    </style>
</head>

<body>
    <!-- Animated particles -->
    <div class="particles">
        <div class="particle" style="width: 80px; height: 80px; left: 10%; animation-delay: 0s;"></div>
        <div class="particle" style="width: 60px; height: 60px; left: 20%; animation-delay: 2s;"></div>
        <div class="particle" style="width: 40px; height: 40px; left: 30%; animation-delay: 4s;"></div>
        <div class="particle" style="width: 100px; height: 100px; left: 50%; animation-delay: 1s;"></div>
        <div class="particle" style="width: 70px; height: 70px; left: 70%; animation-delay: 3s;"></div>
        <div class="particle" style="width: 50px; height: 50px; left: 85%; animation-delay: 5s;"></div>
    </div>

    <!-- Main container -->
    <div class="container">
        <div class="login-card">
            <h1>{translate key="user.login"}</h1>
            <p class="subtitle">{translate key="plugins.generic.siteMode.login.subtitle"}</p>

            {if $error}
                <div class="error-message">
                    {$error|escape}
                </div>
            {/if}

            <form method="post" action="{$loginUrl|escape}">
                {csrf}

                <div class="form-group">
                    <label for="username">{translate key="user.username"}</label>
                    <input type="text" id="username" name="username" value="{$username|escape}" required autofocus
                        placeholder="{translate key="user.username"}">
                </div>

                <div class="form-group">
                    <label for="password">{translate key="user.password"}</label>
                    <input type="password" id="password" name="password" required
                        placeholder="{translate key="user.password"}">
                </div>

                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember" value="1">
                    <label for="remember">{translate key="user.login.rememberUsernameAndPassword"}</label>
                </div>

                <input type="hidden" name="source" value="{$source|escape}">

                <button type="submit" class="submit-btn">
                    {translate key="user.login"}
                </button>
            </form>

            <div class="back-link">
                <a href="{$homeUrl|escape}">
                    ← {translate key="plugins.generic.siteMode.login.backToHome"}
                </a>
            </div>
        </div>
    </div>
</body>

</html>