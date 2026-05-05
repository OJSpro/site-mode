<?php

/**
 * @file SiteModePlugin.php
 *
 * Copyright (c) 2026 OJSpro
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @package plugins.generic.siteMode
 *
 * @class SiteModePlugin
 *
 * @brief SiteMode plugin - Provides Coming Soon and Maintenance Mode pages
 */

namespace APP\plugins\generic\siteMode;

use APP\core\Application;
use APP\facades\Repo;
use APP\template\TemplateManager;
use PKP\core\PKPRequest;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class SiteModePlugin extends GenericPlugin
{
    /**
     * @copydoc Plugin::getDisplayName()
     */
    public function getDisplayName()
    {
        return __('plugins.generic.siteMode.name');
    }

    /**
     * @copydoc Plugin::getDescription()
     */
    public function getDescription()
    {
        $description = __('plugins.generic.siteMode.description');
        if (!$this->isTinyMCEInstalled()) {
            $description .= __('plugins.generic.siteMode.requirement.tinymce');
        }
        return $description;
    }

    /**
     * Check whether or not the TinyMCE plugin is installed.
     *
     * @return bool True iff TinyMCE is installed.
     */
    public function isTinyMCEInstalled()
    {
        $application = Application::get();
        $products = $application->getEnabledProducts('plugins.generic');
        return isset($products['tinymce']);
    }

    /**
     * @copydoc Plugin::register()
     *
     * @param null|mixed $mainContextId
     */
    public function register($category, $path, $mainContextId = null)
    {
        if (parent::register($category, $path, $mainContextId)) {
            if ($this->getEnabled($mainContextId)) {
                // Hook into LoadHandler to intercept requests
                Hook::add('LoadHandler', [$this, 'interceptRequest']);
                
                // Load CSS and JavaScript
                Hook::add('TemplateManager::display', [$this, 'loadAssets']);
            }
            return true;
        }
        return false;
    }

    /**
     * Intercept requests and display mode page if active
     *
     * @param string $hookName
     * @param array $args
     * @return bool
     */
    public function interceptRequest($hookName, $args)
    {
        $request = Application::get()->getRequest();
        $context = $request->getContext();
        
        // Don't intercept if no context
        if (!$context) {
            return false;
        }

        // Get the current mode
        $mode = $this->getSetting($context->getId(), 'mode');
        
        // If disabled, don't intercept
        if (!$mode || $mode === 'disabled') {
            return false;
        }

        // Don't intercept POST requests (form submissions, login authentication, etc.)
        if ($request->isPost()) {
            return false;
        }

        // Check if user has bypass access
        if ($this->userHasBypassAccess($request, $context)) {
            return false;
        }

        // Handle login page separately with custom template
        $page = &$args[0];
        $op = &$args[1];
        
        // Don't intercept logout operation
        if ($page === 'login' && $op === 'signOut') {
            return false;
        }
        
        // Show custom login page for GET requests to login
        if ($page === 'login') {
            $this->displayCustomLoginPage($request, $context);
            return true;
        }
        
        // Don't intercept user registration or other user pages
        if ($page === 'user') {
            return false;
        }

        // Intercept and display appropriate mode page
        if ($mode === 'comingSoon') {
            $this->displayComingSoonPage($request, $context);
            return true;
        } elseif ($mode === 'maintenance') {
            $this->displayMaintenancePage($request, $context);
            return true;
        }

        return false;
    }

    /**
     * Display custom login page
     *
     * @param PKPRequest $request
     * @param Context $context
     */
    private function displayCustomLoginPage($request, $context)
    {
        $templateMgr = TemplateManager::getManager($request);
        
        // Get any error message
        $error = $request->getUserVar('error');
        
        // Assign template variables
        $templateMgr->assign([
            'loginUrl' => $request->url(null, 'login', 'signIn'),
            'homeUrl' => $request->url(null, 'index'),
            'username' => $request->getUserVar('username'),
            'error' => $error,
            'source' => $request->getUserVar('source'),
        ]);
        
        // Display custom login template
        $templateMgr->display($this->getTemplateResource('login.tpl'));
        exit;
    }

    /**
     * Check if the current user has bypass access
     *
     * @param PKPRequest $request
     * @param Context $context
     * @return bool
     */
    private function userHasBypassAccess($request, $context)
    {
        $user = $request->getUser();
        
        if (!$user) {
            return false;
        }

        // Get user groups for this user in this context
        $userGroups = Repo::userGroup()
            ->getCollector()
            ->filterByUserIds([$user->getId()])
            ->filterByContextIds([$context->getId()])
            ->getMany();
        
        // Allowed user group IDs (1-5)
        $allowedGroupIds = [1, 2, 3, 4, 5];
        
        foreach ($userGroups as $userGroup) {
            if (in_array($userGroup->getId(), $allowedGroupIds)) {
                return true;
            }
        }
        
        return false;
    }

    /**
     * Display the Coming Soon page
     *
     * @param PKPRequest $request
     * @param Context $context
     */
    private function displayComingSoonPage($request, $context)
    {
        $templateMgr = TemplateManager::getManager($request);
        
        // Get settings
        $content = $this->getSetting($context->getId(), 'comingSoonContent');
        $targetDate = $this->getSetting($context->getId(), 'comingSoonDate');
        
        // Check if user is logged in (but doesn't have bypass access)
        $user = $request->getUser();
        $isLoggedIn = ($user !== null);
        
        // Assign template variables
        $templateMgr->assign([
            'content' => $content,
            'targetDate' => $targetDate,
            'loginUrl' => $request->url(null, 'login'),
            'logoutUrl' => $request->url(null, 'login', 'signOut'),
            'isLoggedIn' => $isLoggedIn,
            'pageTitle' => __('plugins.generic.siteMode.comingSoon.title'),
        ]);
        
        // Load assets
        $this->loadComingSoonAssets($request);
        
        // Display template
        $templateMgr->display($this->getTemplateResource('comingSoon.tpl'));
        exit;
    }

    /**
     * Display the Maintenance page
     *
     * @param PKPRequest $request
     * @param Context $context
     */
    private function displayMaintenancePage($request, $context)
    {
        $templateMgr = TemplateManager::getManager($request);
        
        // Get settings
        $content = $this->getSetting($context->getId(), 'maintenanceContent');
        
        // Use default message if no content set
        if (empty($content)) {
            $content = __('plugins.generic.siteMode.maintenance.defaultMessage');
        }
        
        // Check if user is logged in (but doesn't have bypass access)
        $user = $request->getUser();
        $isLoggedIn = ($user !== null);
        
        // Assign template variables
        $templateMgr->assign([
            'content' => $content,
            'loginUrl' => $request->url(null, 'login'),
            'logoutUrl' => $request->url(null, 'login', 'signOut'),
            'isLoggedIn' => $isLoggedIn,
            'pageTitle' => __('plugins.generic.siteMode.maintenance.title'),
        ]);
        
        // Load assets
        $this->loadMaintenanceAssets($request);
        
        // Display template
        $templateMgr->display($this->getTemplateResource('maintenance.tpl'));
        exit;
    }

    /**
     * Load assets for Coming Soon page
     *
     * @param PKPRequest $request
     */
    private function loadComingSoonAssets($request)
    {
        $templateMgr = TemplateManager::getManager($request);
        
        $baseUrl = $request->getBaseUrl() . '/' . $this->getPluginPath();
        
        $templateMgr->addStyleSheet(
            'siteModeStyles',
            $baseUrl . '/styles/styles.css'
        );
        
        $templateMgr->addJavaScript(
            'siteModeCountdown',
            $baseUrl . '/js/countdown.js'
        );
    }

    /**
     * Load assets for Maintenance page
     *
     * @param PKPRequest $request
     */
    private function loadMaintenanceAssets($request)
    {
        $templateMgr = TemplateManager::getManager($request);
        
        $baseUrl = $request->getBaseUrl() . '/' . $this->getPluginPath();
        
        $templateMgr->addStyleSheet(
            'siteModeStyles',
            $baseUrl . '/styles/styles.css'
        );
    }

    /**
     * Load assets hook
     *
     * @param string $hookName
     * @param array $args
     * @return bool
     */
    public function loadAssets($hookName, $args)
    {
        // Assets are loaded in the display methods
        return false;
    }

    /**
     * @copydoc Plugin::getActions()
     */
    public function getActions($request, $actionArgs)
    {
        $actions = parent::getActions($request, $actionArgs);
        
        if (!$this->getEnabled()) {
            return $actions;
        }
        
        // Add settings action
        $router = $request->getRouter();
        import('lib.pkp.classes.linkAction.request.AjaxModal');
        $actions[] = new \PKP\linkAction\LinkAction(
            'settings',
            new \PKP\linkAction\request\AjaxModal(
                $router->url(
                    $request,
                    null,
                    null,
                    'manage',
                    null,
                    [
                        'verb' => 'settings',
                        'plugin' => $this->getName(),
                        'category' => 'generic'
                    ]
                ),
                $this->getDisplayName()
            ),
            __('manager.plugins.settings'),
            null
        );
        
        return $actions;
    }

    /**
     * @copydoc Plugin::manage()
     */
    public function manage($args, $request)
    {
        switch ($request->getUserVar('verb')) {
            case 'settings':
                $context = $request->getContext();
                $templateMgr = TemplateManager::getManager($request);
                $templateMgr->registerPlugin('function', 'plugin_url', [$this, 'smartyPluginUrl']);
                
                $this->import('SiteModeSettingsForm');
                $form = new SiteModeSettingsForm($this, $context->getId());
                
                if ($request->getUserVar('save')) {
                    $form->readInputData();
                    if ($form->validate()) {
                        $form->execute();
                        return new \PKP\core\JSONMessage(true);
                    }
                } else {
                    $form->initData();
                }
                
                return new \PKP\core\JSONMessage(true, $form->fetch($request));
        }
        
        return parent::manage($args, $request);
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\generic\siteMode\SiteModePlugin', '\SiteModePlugin');
}
