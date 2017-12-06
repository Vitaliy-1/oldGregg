<?php

/**
 * @file plugins.generic.jatsParser.lib.classes.Video
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Table
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for Video
 */
class Video
{
    private $label;
    private $link;
    private $id;
    private $content;
    private $title;

    public function __construct() {
        $this->content = new ArrayObject(array());
        $this->title = new ArrayObject(array());
    }

    /**
     * @return mixed
     */
    public function getLabel()
    {
        return $this->label;
    }

    /**
     * @param mixed $label
     */
    public function setLabel($label)
    {
        $this->label = $label;
    }

    /**
     * @return mixed
     */
    public function getLink()
    {
        return $this->link;
    }

    /**
     * @param mixed $link
     */
    public function setLink($link)
    {
        $this->link = $link;
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

    public function getContent()
    {
        if ($this->content == null) {
            $this->content = new ArrayObject();
        }
        return $this->content;
    }

    public function getTitle()
    {
        if ($this->title == null) {
            $this->title = new ArrayObject();
        }
        return $this->title;
    }
}