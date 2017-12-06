<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.BibitemJournal
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class BibitemJournal
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for journal article references
 */
class BibitemJournal {
    private $type;
    private $id;
    private $name;
    private $collab;
    private $title;
    private $source;
    private $year;
    private $volume;
    private $issue;
    private $fpage;
    private $lpage;
    private $doi;
    private $pmid;
    private $url;

    /* Do we need to explicitly point types of variables?
    * As be seen from JATS of other journals,
    * they constantly put chars in year (as a month) or
    * not int symbols in issue or fpage
    */

    public function __construct() {
        $this->name = new ArrayObject(array());
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

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }


    /**
     * @return ArrayObject
     */
    public function getName()
    {
        if ($this->name == null) {
            $this->name = new ArrayObject();
        }
        return $this->name;
    }

    /**
     * @param ArrayObject $name
     */
    public function setName(ArrayObject $name)
    {
        $this->name = $name;
    }

    /**
     * @return mixed
     */
    public function getCollab()
    {
        return $this->collab;
    }

    /**
     * @param mixed $collab
     */
    public function setCollab($collab)
    {
        $this->collab = $collab;
    }

    /**
     * @return mixed
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * @param mixed $title
     */
    public function setTitle($title)
    {
        $this->title = $title;
    }

    /**
     * @return mixed
     */
    public function getSource()
    {
        return $this->source;
    }

    /**
     * @param mixed $source
     */
    public function setSource($source)
    {
        $this->source = $source;
    }

    /**
     * @return mixed
     */
    public function getYear()
    {
        return $this->year;
    }

    /**
     * @param mixed $year
     */
    public function setYear($year)
    {
        $this->year = $year;
    }

    /**
     * @return mixed
     */
    public function getVolume()
    {
        return $this->volume;
    }

    /**
     * @param mixed $volume
     */
    public function setVolume($volume)
    {
        $this->volume = $volume;
    }

    /**
     * @return mixed
     */
    public function getIssue()
    {
        return $this->issue;
    }

    /**
     * @param mixed $issue
     */
    public function setIssue($issue)
    {
        $this->issue = $issue;
    }

    /**
     * @return mixed
     */
    public function getFpage()
    {
        return $this->fpage;
    }

    /**
     * @param mixed $fpage
     */
    public function setFpage($fpage)
    {
        $this->fpage = $fpage;
    }

    /**
     * @return mixed
     */
    public function getLpage()
    {
        return $this->lpage;
    }

    /**
     * @param mixed $lpage
     */
    public function setLpage($lpage)
    {
        $this->lpage = $lpage;
    }

    /**
     * @return mixed
     */
    public function getDoi()
    {
        return $this->doi;
    }

    /**
     * @param mixed $doi
     */
    public function setDoi($doi)
    {
        $this->doi = $doi;
    }

    /**
     * @return mixed
     */
    public function getPmid()
    {
        return $this->pmid;
    }

    /**
     * @param mixed $pmid
     */
    public function setPmid($pmid)
    {
        $this->pmid = $pmid;
    }

    /**
     * @return mixed
     */
    public function getUrl()
    {
        return $this->url;
    }

    /**
     * @param mixed $url
     */
    public function setUrl($url)
    {
        $this->url = $url;
    }

}
