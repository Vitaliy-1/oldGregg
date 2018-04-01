<?php namespace JATSParser\Back;

use JATSParser\Back\PersonGroup as PersonGroup;

class Collaboration implements PersonGroup {

	/* @var $type string : author, editor */
	private $type;

	/* @var $name string */
	private $name;

	public function __construct(\DOMElement $collabNode) {
		$this->name = $collabNode->nodeValue;

		$parentNode = $collabNode->parentNode;
		$personGroupType = $parentNode->getAttribute('person-group-type');
		if (isset($personGroupType)) {
			$this->type = $personGroupType;
		}
	}

	/**
	 * @return string
	 */
	public function getType(): string {
		return $this->type;
	}

	/**
	 * @return string
	 */
	public function getName(): string
	{
		return $this->name;
	}
}