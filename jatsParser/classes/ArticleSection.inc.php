<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.ArticleSection
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class ArticleSection
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for article section
 */

class ArticleSection {
    private $title;
    private $type;
    private $content;
    private $hasSection;

    public function __construct() {
        $this->content = new ArrayObject(array());
    }

	public function setTitle ($title) {
		$this->title = $title;
	}
	
	public function getTitle() {
		return $this->title;
	}

    /**
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param mixed $type
     */
    public function setType($type)
    {
        $this->type = $type;
    }

    public function getContent()
    {
        if ($this->content == null) {
            $this->content = new ArrayObject();
        }
        return $this->content;
    }

    /**
     * @return boolean
     */
    public function getHasSection()
    {
        return $this->hasSection;
    }

    /**
     * @param boolean $hasSection
     */
    public function setHasSection($hasSection)
    {
        $this->hasSection = $hasSection;
    }
}
