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

            /* Login button */
            .login-btn {
                position: fixed;
                top: 30px;
                right: 30px;
                background: rgba(255, 255, 255, 0.2);
                backdrop-filter: blur(10px);
                color: white;
                padding: 12px 28px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                border: 2px solid rgba(255, 255, 255, 0.3);
                z-index: 1000;
            }

            .login-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }

            .logout-btn {
                position: fixed;
                top: 30px;
                right: 30px;
                background: rgba(239, 68, 68, 0.3);
                backdrop-filter: blur(10px);
                color: white;
                padding: 12px 28px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                transition: all 0.3s ease;
                border: 2px solid rgba(239, 68, 68, 0.4);
                z-index: 1000;
            }

            .logout-btn:hover {
                background: rgba(239, 68, 68, 0.4);
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }

            /* Main container */
            .container {
                position: relative;
                z-index: 1;
                text-align: center;
                padding: 40px;
                max-width: 900px;
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

            /* Content card */
            .content-card {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(20px);
                border-radius: 30px;
                padding: 60px 50px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.2);
                margin-bottom: 40px;
            }

            .content-card h1 {
                color: white;
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 20px;
                text-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
            }

            .content-card .custom-content {
                color: rgba(255, 255, 255, 0.95);
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .content-card .custom-content p {
                margin-bottom: 15px;
            }

            /* Countdown timer */
            .countdown {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .countdown-item {
                background: rgba(255, 255, 255, 0.2);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 20px 25px;
                min-width: 100px;
                border: 1px solid rgba(255, 255, 255, 0.3);
                transition: transform 0.3s ease;
            }

            .countdown-item:hover {
                transform: translateY(-5px);
            }

            .countdown-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: white;
                display: block;
                text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.05);
                }
            }

            .countdown-label {
                font-size: 0.8rem;
                color: rgba(255, 255, 255, 0.9);
                text-transform: uppercase;
                letter-spacing: 1.5px;
                margin-top: 8px;
                font-weight: 600;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .content-card {
                    padding: 40px 30px;
                }

                .content-card h1 {
                    font-size: 2.5rem;
                }

                .countdown-item {
                    min-width: 100px;
                    padding: 20px 25px;
                }

                .countdown-number {
                    font-size: 2.5rem;
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

                .countdown {
                    gap: 15px;
                }

                .countdown-item {
                    min-width: 80px;
                    padding: 15px 20px;
                }

                .countdown-number {
                    font-size: 2rem;
                }

                .countdown-label {
                    font-size: 0.75rem;
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

    <!-- Login/Logout button -->
    {if $isLoggedIn}
        <a href="{$logoutUrl|escape}" class="logout-btn">{translate key="user.logOut"}</a>
    {else}
        <a href="{$loginUrl|escape}" class="login-btn">{translate key="plugins.generic.siteMode.comingSoon.login"}</a>
    {/if}

    <!-- Main container -->
    <div class="container">
        <div class="content-card">
            <h1>{translate key="plugins.generic.siteMode.comingSoon.title"}</h1>

            <div class="custom-content">
                {$content}
            </div>

            <div class="countdown" id="countdown">
                <div class="countdown-item">
                    <span class="countdown-number" id="days">0</span>
                    <span class="countdown-label">{translate key="plugins.generic.siteMode.comingSoon.days"}</span>
                </div>
                <div class="countdown-item">
                    <span class="countdown-number" id="hours">0</span>
                    <span class="countdown-label">{translate key="plugins.generic.siteMode.comingSoon.hours"}</span>
                </div>
                <div class="countdown-item">
                    <span class="countdown-number" id="minutes">0</span>
                    <span class="countdown-label">{translate key="plugins.generic.siteMode.comingSoon.minutes"}</span>
                </div>
                <div class="countdown-item">
                    <span class="countdown-number" id="seconds">0</span>
                    <span class="countdown-label">{translate key="plugins.generic.siteMode.comingSoon.seconds"}</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Set the target date
        var targetDate = new Date("{$targetDate|escape:'javascript'}").getTime();

        // Update countdown every second
        var countdownInterval = setInterval(function() {
            var now = new Date().getTime();
            var distance = targetDate - now;

            if (distance < 0) {
                clearInterval(countdownInterval);
                document.getElementById("countdown").innerHTML = "<h2 style='color: white; font-size: 2.5rem;'>{translate key="plugins.generic.siteMode.comingSoon.launched"}</h2>";
                return;
            }

            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((distance % (1000 * 60)) / 1000);

            document.getElementById("days").textContent = days;
            document.getElementById("hours").textContent = hours;
            document.getElementById("minutes").textContent = minutes;
            document.getElementById("seconds").textContent = seconds;
        }, 1000);
    </script>
</body>

</html>