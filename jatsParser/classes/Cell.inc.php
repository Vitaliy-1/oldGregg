<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.Cell
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class Cell
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for table cell
 */
class Cell {
    private $colspan;
    private $rowspan;

    /**
     * @return mixed
     */
    public function getColspan()
    {
        return $this->colspan;
    }

    /**
     * @param mixed $colspan
     */
    public function setColspan($colspan)
    {
        $this->colspan = $colspan;
    }

    /**
     * @return mixed
     */
    public function getRowspan()
    {
        return $this->rowspan;
    }

    /**
     * @param mixed $rowspan
     */
    public function setRowspan($rowspan)
    {
        $this->rowspan = $rowspan;
    }

    /* for ParContent as an array */
    public function getContent() {
        return new ArrayObject($this);
    }
}
