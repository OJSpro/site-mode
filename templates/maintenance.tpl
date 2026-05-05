<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$pageTitle|escape}</title>
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
                background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow-x: hidden;
            }

            /* Subtle grid pattern */
            body::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image:
                    linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
                background-size: 50px 50px;
                z-index: 0;
            }

            /* Login button */
            .login-btn {
                position: fixed;
                top: 30px;
                right: 30px;
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(10px);
                color: white;
                padding: 12px 28px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                border: 2px solid rgba(255, 255, 255, 0.2);
                z-index: 1000;
            }

            .login-btn:hover {
                background: rgba(255, 255, 255, 0.25);
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .logout-btn {
                position: fixed;
                top: 30px;
                right: 30px;
                background: rgba(239, 68, 68, 0.25);
                backdrop-filter: blur(10px);
                color: white;
                padding: 12px 28px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                border: 2px solid rgba(239, 68, 68, 0.3);
                z-index: 1000;
            }

            .logout-btn:hover {
                background: rgba(239, 68, 68, 0.35);
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            /* Main container */
            .container {
                position: relative;
                z-index: 1;
                text-align: center;
                padding: 40px;
                max-width: 800px;
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

            /* Icon container */
            .icon-container {
                margin-bottom: 20px;
            }

            .maintenance-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                animation: rotate 10s linear infinite;
            }

            @keyframes rotate {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(360deg);
                }
            }

            .maintenance-icon svg {
                width: 40px;
                height: 40px;
                fill: rgba(255, 255, 255, 0.9);
            }

            /* Content card */
            .content-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(20px);
                border-radius: 25px;
                padding: 30px 35px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            .content-card h1 {
                color: white;
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 12px;
                text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
            }

            .content-card .custom-content {
                color: rgba(255, 255, 255, 0.9);
                font-size: 0.9rem;
                line-height: 1.5;
                max-width: 600px;
                margin: 0 auto;
            }

            .content-card .custom-content p {
                margin-bottom: 12px;
            }

            /* Pulsing dots */
            .status-indicator {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .dot {
                width: 12px;
                height: 12px;
                background: rgba(255, 255, 255, 0.6);
                border-radius: 50%;
                animation: pulse-dot 1.5s ease-in-out infinite;
            }

            .dot:nth-child(2) {
                animation-delay: 0.3s;
            }

            .dot:nth-child(3) {
                animation-delay: 0.6s;
            }

            @keyframes pulse-dot {

                0%,
                100% {
                    opacity: 0.3;
                    transform: scale(0.8);
                }

                50% {
                    opacity: 1;
                    transform: scale(1.2);
                }
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .content-card {
                    padding: 40px 30px;
                }

                .content-card h1 {
                    font-size: 2.5rem;
                }

                .maintenance-icon {
                    width: 100px;
                    height: 100px;
                }

                .maintenance-icon svg {
                    width: 50px;
                    height: 50px;
                }

                .login-btn {
                    top: 20px;
                    right: 20px;
                    padding: 10px 20px;
                    font-size: 13px;
                }
            }

            @media (max-width: 480px) {
                .content-card h1 {
                    font-size: 2rem;
                }

                .content-card .custom-content {
                    font-size: 1rem;
                }

                .maintenance-icon {
                    width: 80px;
                    height: 80px;
                }

                .maintenance-icon svg {
                    width: 40px;
                    height: 40px;
                }
            }

        {/literal}
    </style>
</head>

<body>
    <!-- Login/Logout button -->
    {if $isLoggedIn}
        <a href="{$logoutUrl|escape}" class="logout-btn">{translate key="user.logOut"}</a>
    {else}
        <a href="{$loginUrl|escape}" class="login-btn">{translate key="plugins.generic.siteMode.maintenance.login"}</a>
    {/if}

    <!-- Main container -->
    <div class="container">
        <div class="icon-container">
            <div class="maintenance-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path
                        d="M22.7 19l-9.1-9.1c.9-2.3.4-5-1.5-6.9-2-2-5-2.4-7.4-1.3L9 6 6 9 1.6 4.7C.4 7.1.9 10.1 2.9 12.1c1.9 1.9 4.6 2.4 6.9 1.5l9.1 9.1c.4.4 1 .4 1.4 0l2.3-2.3c.5-.4.5-1.1.1-1.4z" />
                </svg>
            </div>
        </div>

        <div class="content-card">
            <h1>{translate key="plugins.generic.siteMode.maintenance.title"}</h1>

            <div class="custom-content">
                {$content}
            </div>

            <div class="status-indicator">
                <div class="dot"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
        </div>
    </div>
</body>

</html>