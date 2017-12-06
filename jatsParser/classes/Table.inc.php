<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.Table
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Table
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for tables
 */
class Table {
    private $id;
    private $label;

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

    /* For caprion, title and Rows inside table */

    public function getContent() {
        return new ArrayObject($this);
    }

}
