<?php
/**
 * @file plugins.generic.jatsParser.lib.classes.ParText
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * @class ParText
 * @ingroup plugins_generic_jatsParser
 *
 * @brief POPO for paragraph text
 */
class ParText extends ParContent {
	private $content;

	public function setContent ($content) {
		$this->content= $content;
	}
	
	public function getContent() {
		return $this->content;
	}
}
