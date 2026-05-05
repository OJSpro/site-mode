<?php

/**
 * @file SiteModeSettingsForm.php
 *
 * Copyright (c) 2026 OJSpro
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class SiteModeSettingsForm
 *
 * @brief Form for site mode plugin settings
 */

namespace APP\plugins\generic\siteMode;

use APP\template\TemplateManager;
use PKP\form\Form;
use PKP\form\validation\FormValidator;
use PKP\form\validation\FormValidatorCSRF;
use PKP\form\validation\FormValidatorPost;

class SiteModeSettingsForm extends Form
{
    /** @var SiteModePlugin */
    private $_plugin;

    /** @var int */
    private $_contextId;

    /**
     * Constructor
     *
     * @param SiteModePlugin $plugin
     * @param int $contextId
     */
    public function __construct($plugin, $contextId)
    {
        $this->_plugin = $plugin;
        $this->_contextId = $contextId;

        parent::__construct($plugin->getTemplateResource('settings.tpl'));

        // Add form validators
        $this->addCheck(new FormValidatorPost($this));
        $this->addCheck(new FormValidatorCSRF($this));
    }

    /**
     * @copydoc Form::initData()
     */
    public function initData()
    {
        $contextId = $this->_contextId;
        
        $this->setData('mode', $this->_plugin->getSetting($contextId, 'mode') ?: 'disabled');
        $this->setData('comingSoonContent', $this->_plugin->getSetting($contextId, 'comingSoonContent'));
        $this->setData('comingSoonDate', $this->_plugin->getSetting($contextId, 'comingSoonDate'));
        $this->setData('maintenanceContent', $this->_plugin->getSetting($contextId, 'maintenanceContent'));
    }

    /**
     * @copydoc Form::readInputData()
     */
    public function readInputData()
    {
        $this->readUserVars([
            'mode',
            'comingSoonContent',
            'comingSoonDate',
            'maintenanceContent'
        ]);
    }

    /**
     * @copydoc Form::fetch()
     */
    public function fetch($request, $template = null, $display = false)
    {
        $templateMgr = TemplateManager::getManager($request);
        $templateMgr->assign('pluginName', $this->_plugin->getName());
        
        return parent::fetch($request, $template, $display);
    }

    /**
     * @copydoc Form::execute()
     */
    public function execute(...$functionArgs)
    {
        $contextId = $this->_contextId;
        
        $this->_plugin->updateSetting($contextId, 'mode', $this->getData('mode'));
        $this->_plugin->updateSetting($contextId, 'comingSoonContent', $this->getData('comingSoonContent'));
        $this->_plugin->updateSetting($contextId, 'comingSoonDate', $this->getData('comingSoonDate'));
        $this->_plugin->updateSetting($contextId, 'maintenanceContent', $this->getData('maintenanceContent'));
        
        parent::execute(...$functionArgs);
    }
}
