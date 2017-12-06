<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.Row
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Row
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for table row
 */
class Row {
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

    /* for Cell as an array */
    public function getContent() {
        return new ArrayObject($this);
    }
}
