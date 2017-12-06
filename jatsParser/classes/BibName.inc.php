<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.BibitemName
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class BibitemName
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for authors names in references
 */
class BibName {
    private $surname;
    private $initials;
    private $givenname;

    public function __construct() {
        $this->initials = array();
    }

    /**
     * @return string
     */
    public function getSurname()
    {
        return $this->surname;
    }

    /**
     * @param string $surname
     */
    public function setSurname($surname)
    {
        $this->surname = $surname;
    }

    /**
     * @return array
     */
    public function getInitials()
    {
        return $this->initials;
    }

    /**
     * @param array $initials
     */
    public function setInitials(array $initials)
    {
        $this->initials = $initials;
    }

    /**
     * @return mixed
     */
    public function getGivenname()
    {
        return $this->givenname;
    }

    /**
     * @param mixed $givenname
     */
    public function setGivenname($givenname)
    {
        $this->givenname = $givenname;
    }
}
