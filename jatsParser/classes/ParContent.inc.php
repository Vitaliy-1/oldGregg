<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.ParContent
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class ParContent
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for paragraph content (bold, italic text, inline references for bibliography, tables and figures)
 */
class ParContent {
    private $type;

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

    public function getContent() {
		return new ArrayObject($this);
	}
}
