<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.XrefFig
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class XrefFig
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for in-text references to figures
 */
class XrefFig extends ParContent {
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
     * @param mixed $rid
     */
    public function setRid($rid)
    {
        $this->rid = $rid;
    }

    /**
     * @return mixed
     */
    public function getRid()
    {
        return $this->rid;
    }
}
