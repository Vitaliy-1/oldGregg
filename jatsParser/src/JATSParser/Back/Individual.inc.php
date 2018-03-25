<?php namespace JATSParser\Back;


use JATSParser\Back\PersonGroup as PersonGroup;
use JATSParser\Body\Document as Document;

class Individual implements PersonGroup {

	/* @var $type string : author, editor */
	private $type;

	/* @var $surname string */
	private $surname;

	/* @var $givenNames string */
	private $givenNames;

	public function __construct(\DOMElement $individualNode) {
		$xpath = Document::getXpath();

		$surnameNodes = $xpath->query('child::surname[1]', $individualNode);
		if ($surnameNodes->length > 0) {
			foreach ($surnameNodes as $surnameNode) {
				$this->surname = $surnameNode->nodeValue;
			}
		}

		$givenNamesNodes = $xpath->query('child::given-names[1]', $individualNode);
		if ($givenNamesNodes->length > 0) {
			foreach ($givenNamesNodes as $givenNamesNode) {
				$this->givenNames = $givenNamesNode->nodeValue;
			}
		}

		$parentNode = $individualNode->parentNode;
		$personGroupType = $parentNode->getAttribute('person-group-type');
		if (isset($personGroupType)) {
			$this->type = $personGroupType;
		} else {
			$this->type = 'author';
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
	public function getSurname()
	{
		return $this->surname;
	}

	/**
	 * @return string
	 */
	public function getGivenNames(): string
	{
		return $this->givenNames;
	}
}