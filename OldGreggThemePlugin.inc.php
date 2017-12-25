<?php

/**
 * @file plugins/themes/oldGregg/OldGreggThemePlugin.inc.php
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *
 * @class OldGreggThemePlugin
 *
 * @brief Old Gregg theme is developed on the basis of bootstrap 4; it has build-in fucntionality of JATS Parser Plugin and browse latest articles plugin
 */
import('lib.pkp.classes.plugins.GenericPlugin');
import("plugins.themes.oldGregg.jatsParser.main.Body");
import("plugins.themes.oldGregg.jatsParser.main.Back");

import('lib.pkp.classes.plugins.ThemePlugin');

class OldGreggThemePlugin extends ThemePlugin {
    /**
     * Initialize the theme's styles, scripts and hooks. This is only run for
     * the currently active theme.
     *
     * @return null
     */
    public function init() {

        $this->addStyle('bootstrap', 'bootstrap/css/bootstrap.min.css');
        $this->addStyle('header', 'css/header.css');
        $this->addStyle('footer', 'css/footer.css');
	    $this->addStyle('issue', 'css/issue.css');
	    $this->addStyle('site-wide', 'css/main.css');
	    $this->addStyle('index', 'css/index.css');

        $this->addScript('jquery', 'jquery/jquery.min.js');
        $this->addScript('popper', 'bootstrap/js/popper.min.js');
        $this->addScript('bootstrap', 'bootstrap/js/bootstrap.min.js');
	    $this->addScript('fontawesome', 'js/fontawesome-all.min.js');

        $this->addStyle(
            'my-custom-font1',
            '//fonts.googleapis.com/css?family=Lora',
            array('baseUrl' => 'https://fonts.googleapis.com/css?family=Lora" rel="stylesheet'));

        $this->addStyle(
            'my-custom-font2',
            '//fonts.googleapis.com/css?family=PT+Serif',
            array('baseUrl' => ''));

        $this->addStyle(
            'my-custom-font3',
            '//fonts.googleapis.com/css?family=Arimo',
            array('baseUrl' => ''));
        $this->addStyle(
            'my-custom-font4',
            '//fonts.googleapis.com/css?family=Open+Sans',
            array('baseUrl' => ''));
        $this->addStyle(
            'my-custom-font5',
            '//fonts.googleapis.com/css?family=Play',
            array('baseUrl' => ''));

        $this->addMenuArea(array('primary', 'user'));

        HookRegistry::register ('TemplateManager::display', array($this, 'jatsParser'));
	    HookRegistry::register ('TemplateManager::display', array($this, 'browseLatest'));
    }

    /**
     * Get the display name of this plugin
     * @return string
     */
    function getDisplayName() {
        return __('plugins.themes.oldGregg.name');
    }

    /**
     * Get the description of this plugin
     * @return string
     */
    function getDescription() {
        return __('plugins.themes.oldGregg.description');
    }

    /** For displaying article's JATS XML */
    public function jatsParser ($hookName, $args) {

        // Retrieve the TemplateManager and the template filename
        $smarty = $args[0];
        $template = $args[1];

        // Don't do anything if we're not loading the right template
        if ($template != 'frontend/pages/article.tpl') {
            return;
        }

        $articleArrays = $smarty->get_template_vars('article');

        foreach ($articleArrays->getGalleys() as $galley) {
            if ($galley && in_array($galley->getFileType(), array('application/xml', 'text/xml'))) {
                $xmlGalleys[] = $galley;
            }
        }

        // Return false if no XML galleys available
        if (!$xmlGalleys) {
            return false;
        }

        $xmlGalley = null;
        foreach($xmlGalleys as $xmlNumber => $xmlGalleyOne) {
            if ($xmlNumber > 0) {
                if ($xmlGalleyOne->getLocale() == AppLocale::getLocale()) {
                    $xmlGalley = $xmlGalleyOne;
                }
            } else {
                $xmlGalley = $xmlGalleyOne;
            }
        }

        // Parsing JATS XML
        $document = new DOMDocument;
        $document->load($xmlGalley->getFile()->getFilePath());
        $xpath = new DOMXPath($document);

        $body = new Body();
        $sections = $body->bodyParsing($xpath);

        /* Assigning references */
        $back = new Back();
        $references = $back->parsingBack($xpath);

        // Assigning variables to article template
        $smarty->assign('sections', $sections);
        $smarty->assign('references', $references);
        $smarty->assign('path_template',$this->getTemplatePath());
    }

    /* For retrieving articles from the database */
    public function browseLatest($hookName, $args) {
	    $smarty = $args[0];
	    $template = $args[1];

	    if ($template != 'frontend/pages/indexJournal.tpl') return false;

	    $rangeArticles = new DBResultRange(20, 1);
	    $publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
	    $publishedArticleObjects = $publishedArticleDao->getPublishedArticlesByJournalId($journalId = null, $rangeArticles, $reverse = true);

	    $publishedArticles = array();

	    while ($publishedArticle = $publishedArticleObjects->next()) {
		    $publishedArticles[] = $publishedArticle;
	    }
	    $smarty->assign('publishedArticles', $publishedArticles);
    }
}
?>