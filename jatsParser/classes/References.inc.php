<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.References
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class References
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO to treat references as an ArrayObject
 */
class References
{
    private $title;
    private $references;

    public function __construct() {
        $this->references = new ArrayObject(array());
    }

    public function getReferences()
    {
        if ($this->references == null) {
            $this->references = new ArrayObject();
        }
        return $this->references;
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


}
