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

import('lib.pkp.classes.plugins.ThemePlugin');

define('OLDGREGG_CSL_STYLE_DEFAULT', 'vancouver');
define('OLDGREGG_LATEST_ARTICLES_DEFAULT', 20);
define('OLDGREGG_ISSUE_COVER_RELATIVE_URL', 'images/issue_default.jpg');
define('OLDGREGG_LATEST_ISSUES_DEFAULT', 3);

class OldGreggThemePlugin extends ThemePlugin
{
	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */
	public function init()
	{
		// Register theme options
		$this->addOption('latestArticlesNumber', 'text', array(
			'label' => 'plugins.gregg.latest.number',
			'description' => 'plugins.gregg.latest.description',
			'default' => OLDGREGG_LATEST_ARTICLES_DEFAULT
		));

		$this->addOption('displayIssuesSlider', 'text', array(
			'label' => 'plugins.gregg.if-display.issue-slider',
			'description' => 'plugins.gregg.if-display.issue-slider.description',
			'default' => OLDGREGG_LATEST_ISSUES_DEFAULT
		));

		$this->addOption('journalSummary', 'radio', array(
			'label' => 'plugins.gregg.journal.summary.display',
			'options' => array(
				'true' => 'plugins.gregg.journal.summary.display.true',
				'false' => 'plugins.gregg.journal.summary.display.false',
			),
			'default' => false
		));

		// Number of Categories to display on the front page
		$this->addOption("numCategoriesHomepage", "text", array(
			'label' => 'plugins.gregg.journal.categories.label',
			'description' => 'plugins.gregg.journal.categories.description',
			'default' => 4
		));


		$this->addStyle('bootstrap', 'resources/bootstrap/css/bootstrap.min.css');
		$this->addStyle('less', 'resources/less/import.less');

		$this->addScript('jquery', 'resources/jquery/jquery.min.js');
		$this->addScript('popper', 'resources/bootstrap/js/popper.min.js');
		$this->addScript('bootstrap', 'resources/bootstrap/js/bootstrap.min.js');
		$this->addScript('fontawesome', 'resources/js/fontawesome-all.min.js');
		$this->addScript('main', 'resources/js/main.js');

		$request = $this->getRequest();
		if ($request->getRequestedPage() == "article" && (is_array($request->getRequestedArgs()) && count($request->getRequestedArgs()) == 1)) {
			$this->addScript("article", "resources/js/article.js");
		}


		$this->addStyle(
			'my-custom-font1',
			'//fonts.googleapis.com/css?family=Lora',
			array('baseUrl' => 'https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap&subset=cyrillic,vietnamese" rel="stylesheet'));

		$this->addStyle(
			'my-custom-font2',
			'//fonts.googleapis.com/css?family=PT+Serif:400,400i,700,700i&display=swap&subset=cyrillic',
			array('baseUrl' => ''));

		$this->addStyle(
			'my-custom-font6',
			'//fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,900&display=swap&subset=cyrillic',
			array('baseUrl' => ''));

		$this->addMenuArea(array('primary', 'user'));

		HookRegistry::register('TemplateManager::display', array($this, 'browseLatest'));
		HookRegistry::register('TemplateManager::display', array($this, 'browsePopular'));
		HookRegistry::register('TemplateManager::display', array($this, 'sitewideData'));
		HookRegistry::register('TemplateManager::display', array($this, 'latestIssuesSlider'), HOOK_SEQUENCE_NORMAL);
		HookRegistry::register('TemplateManager::display', array($this, 'journalDescription'), HOOK_SEQUENCE_NORMAL);
		HookRegistry::register('TemplateManager::display', array($this, 'categoriesJournalIndex'), HOOK_SEQUENCE_NORMAL);
	}



	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName()
	{
		return __('plugins.themes.oldGregg.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription()
	{
		return __('plugins.themes.oldGregg.description');
	}

	/* For retrieving articles from the database */
	public function browseLatest($hookName, $args)
	{
		$smarty = $args[0];
		$template = $args[1];
		if ($template != 'frontend/pages/indexJournal.tpl') return false;
		/* get number of latest article to display from user input; if there was none - use default */
		$latestArticles = $this->getOption("latestArticlesNumber");
		if (is_null($latestArticles)) {
			$latestArticles = OLDGREGG_LATEST_ARTICLES_DEFAULT;
		} else {
			$latestArticles = intval($latestArticles);
		}

		/* retrieve current journal id from the request */
		$request = $this->getRequest();
		$journal = $request->getJournal();
		$journalId = $journal->getId();

		/* retrieve latest articles */
		$publishedArticleObjects = Services::get("submission")->getMany([
			'status' => STATUS_PUBLISHED,
			'contextId' => $journalId,
			'count' => $latestArticles
		]);

		$smarty->assign('publishedArticles', iterator_to_array($publishedArticleObjects));
	}

	function sitewideData($hookName, $args) {
		$smarty = $args[0];

		$orcidImagePath = $this->request->getBaseUrl() . DIRECTORY_SEPARATOR . $this->getTemplatePath() . DIRECTORY_SEPARATOR . "images" . DIRECTORY_SEPARATOR . "orcid.png";
		$smarty->assign('orcidImagePath', $orcidImagePath);
	}

	/**
	 * @param $hookName string
	 * @param $args array [TemplateManager, string]
	 * @brief display most popular articles
	 * @return void
	 * Thanks to @ajnyga
	 */
	function browsePopular($hookName, $args) {
		$smarty = $args[0];
		$template = $args[1];

		if ($template != 'frontend/pages/indexJournal.tpl') return false;

		$request = $this->getRequest();
		$context = $request->getContext();

		$cacheManager = CacheManager::getManager();
		$cache = $cacheManager->getCache('oldgregg', $context->getId(), array($this, '_toCache'));
		$daysToStale = 1;
		if (time() - $cache->getCacheTime() > 60 * 60 * 24 * $daysToStale) {
			$cache->flush();
		}

		$popularArticles = $cache->getContents();

		$smarty->assign([
			'popularArticles' => $popularArticles,
			'locale' => AppLocale::getLocale(),
		]);

	}

	/**
	 * @param $cache FileCache
	 */
	function _toCache($cache) {
		$request = $this->getRequest();
		$context = $request->getContext();

		// Find most viewed articles
		$filter = array(
			STATISTICS_DIMENSION_ASSOC_TYPE => ASSOC_TYPE_SUBMISSION,
		);
		$filter[STATISTICS_DIMENSION_DAY]['from'] = date('Y-m-d', mktime(0, 0, 0, date("m")-12, date("d"),   date("Y")));
		$filter[STATISTICS_DIMENSION_DAY]['to'] = date('Y-m-d');
		$orderBy = array(STATISTICS_METRIC => STATISTICS_ORDER_DESC);
		$column = array(
			STATISTICS_DIMENSION_SUBMISSION_ID,
		);

		$latestArticles = $this->getOption("latestArticlesNumber");
		if (is_null($latestArticles)) {
			$latestArticles = OLDGREGG_LATEST_ARTICLES_DEFAULT;
		} else {
			$latestArticles = intval($latestArticles);
		}

		$dbrange = new DBResultRange($latestArticles);

		$results = $context->getMetrics(OJS_METRIC_TYPE_COUNTER, $column, $filter, $orderBy, $dbrange);

		// Write into cache
		$supportedLocales = AppLocale::getSupportedLocales();

		$popularArticles = array();
		foreach ($results as $result) {
			$publishedArticle = Services::get('submission')->get($result['submission_id']);
			// Can't cache objects
			$popularArticles[$result['submission_id']] = array(
				'localized_title' => $publishedArticle->getLocalizedFullTitle(),
				'views' => $result['metric'],
				'date_published' => $publishedArticle->getDatePublished()
			);

			$localizedTitle = array();
			foreach ($supportedLocales as $key => $locale) {
				$localizedTitle[$key] = $publishedArticle->getFullTitle($key);
			}

			$popularArticles[$result['submission_id']]['localized_title'] = $localizedTitle;

			if (!empty($publishedArticle->getAuthors())) {
				$authorsArray = array();
				foreach ($publishedArticle->getAuthors() as $author) {
					foreach ($supportedLocales as $key => $locale) {
						$authorArray[$key] = array(
							'family_name' => $author->getFamilyName($key),
							'given_name' => $author->getGivenName($key),
						);
					}

					$authorsArray[] = $authorArray;
				}

				$popularArticles[$result['submission_id']]['authors'] = $authorsArray;
			}
		}

		$cache->setEntireCache($popularArticles);
	}

	public function latestIssuesSlider($hookName, $args) {
		$smarty = $args[0];
		$template = $args[1];

		if ($template != 'frontend/pages/indexJournal.tpl') return false;

		$latestIssuesInput = $this->getOption("displayIssuesSlider");
		if (is_null($latestIssuesInput)) {
			$latestIssuesInput = OLDGREGG_LATEST_ISSUES_DEFAULT;
		} elseif (intval($latestIssuesInput) === 0) {
			return false;
		} else {
			$latestIssuesInput = intval($latestIssuesInput);
		}

		$request = $this->getRequest();
		$journal = $request->getJournal();
		$journalId = $journal->getId();

		$issuesIterator = Services::get('issue')->getMany([
			'count' => $latestIssuesInput,
			'contextId' => $journalId
		]);

		$defaultCoverImageUrl = "/" . $this->getPluginPath() . "/" . OLDGREGG_ISSUE_COVER_RELATIVE_URL;

		$latestIssues = iterator_to_array($issuesIterator);

		$smarty->assign('latestIssues', $latestIssues);
		$smarty->assign('defaultCoverImageUrl', $defaultCoverImageUrl);
	}

	public function journalDescription ($hookName, $args) {
		$smarty = $args[0];

		$showSummaryData = $this->getOption("journalSummary");

		$showSummary = false;
		if (!is_null($showSummaryData) && ($showSummaryData == "true")) {
			$showSummary = true;
		}

		$smarty->assign(array(
			'showSummary' => $showSummary,
			'journalFilesPath' => $this->getRequest()->getBaseUrl() . '/' . Config::getVar('files', 'public_files_dir') . '/journals/',
		));
	}

	/**
	 * @param $hookname string
	 * @param $args array [
	 *      @option TemplateManager
	 *      @option string relative path to the template
	 * ]
	 * @brief Add categories to the journal landing page
	 */
	public function categoriesJournalIndex($hookname, $args) {
		$templateMgr = $args[0];
		$template = $args[1];

		if ($template != "frontend/pages/indexJournal.tpl") return false;

		$reguest = $this->getRequest();
		$context = $reguest->getContext();

		$categoryDao = DAORegistry::getDAO('CategoryDAO');
		$categoriesObject = $categoryDao->getByContextId($context->getId());

		$numCategoriesHomepage = intval($this->getOption("numCategoriesHomepage"));

		$categories = array();
		while ($category = $categoriesObject->next()) {
			$categories[] = $category;
		}

		$templateMgr->assign(array(
			'categories' => $categories,
			'numCategoriesHomepage' => $numCategoriesHomepage
		));
	}


}

?>
