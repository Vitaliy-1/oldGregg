<?php

/**
 * @file plugins.generic.jatsParser.lib.classes.XrefVideo
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class XrefTable
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for in-text references to videos
 */
class XrefVideo
{
    private $content;
    private $rid;

    public function getContent()
    {
        return $this->content;
    }

    public function setContent($content)
    {
        $this->content = $content;
    }

    /**
     * @return mixed
     */
    public function getRid()
    {
        return $this->rid;
    }

    /**
     * @param mixed $rid
     */
    public function setRid($rid)
    {
        $this->rid = $rid;
    }
}