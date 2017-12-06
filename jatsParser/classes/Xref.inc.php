<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.Xref
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Xref
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for in-text citations to bibliography
 */
class Xref extends ParContent {
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
