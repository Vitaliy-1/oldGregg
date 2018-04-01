<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Document as Document;
use JATSParser\Body\Text as Text;

class Par implements JATSElement {

	/**
	 *   @var $content array
	 */

	private $content;

	function __construct(\DOMElement $paragraph) {
		$xpath = Document::getXpath();
		$content = array();
		$parTextNodes = $xpath->query(".//text()", $paragraph);
		foreach ($parTextNodes as $parTextNode) {
			$jatsText = new Text($parTextNode);
			$content[] = $jatsText;
		}
		$this->content = $content;
	}

	public function getContent(): array {
		return $this->content;
	}
}