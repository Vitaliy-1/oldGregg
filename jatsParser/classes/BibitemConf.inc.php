<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.BibitemConf
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class BibitemConf
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for conference references
 */
class BibitemConf {
    private $type;
    private $id;
    private $name;
    private $collab;
    private $source;
    private $confName;
    private $confLoc;
    private $confDate;
    private $year;
    private $doi;
    private $pmid;
    private $url;

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
    public function getConfName()
    {
        return $this->confName;
    }

    /**
     * @param mixed $confName
     */
    public function setConfName($confName)
    {
        $this->confName = $confName;
    }

    /**
     * @return mixed
     */
    public function getConfLoc()
    {
        return $this->confLoc;
    }

    /**
     * @param mixed $confLoc
     */
    public function setConfLoc($confLoc)
    {
        $this->confLoc = $confLoc;
    }

    /**
     * @return mixed
     */
    public function getConfDate()
    {
        return $this->confDate;
    }

    /**
     * @param mixed $confDate
     */
    public function setConfDate($confDate)
    {
        $this->confDate = $confDate;
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
