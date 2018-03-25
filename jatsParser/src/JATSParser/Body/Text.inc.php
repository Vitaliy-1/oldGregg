<?php namespace JATSParser\Body;

use JATSParser\Body\JATSElement as JATSElement;
use JATSParser\Body\Document as Document;

class Text implements JATSElement {

	/* @var array
	 * defines the type of a paragraph content, possible options are:
	 * normal
	 * bold
	 * xref -> 2 dimensional array where key is actual xref element's attribute and value - it's value
	 * sup
	 * sub
	 */

	private $type;

	private $content;

	private static $nodeCheck = array("bold", "italic", "sup", "sub", "xref", "underline", "monospace", "ext-link");

	public function __construct(\DOMText $paragraphContent) {
		$this->content = $paragraphContent->textContent;
		$this->extractTextNodeModifiers($paragraphContent);
		/* assign normal as a value to a text run if it has non */
		if ($this->type === NULL) {
			$this->type[] = "normal";
		}
	}

	/**
	 * @return string
	 */

	public function getContent() : string {
		return $this->content;
	}

	/**
	 * @return string[]
	 */
	public function getType(): array {
		return $this->type;
	}

	/**
	 * @return string[]
	 */
	public static function getNodeCheck(): array {
		return self::$nodeCheck;
	}

	/**
	 * @param \DOMText \DOMElement
	 */
	private function extractTextNodeModifiers($paragraphContent) {
		/* @var $parentNode \DOMElement */
		$parentNode = $paragraphContent->parentNode;
		if (in_array($parentNode->nodeName, self::$nodeCheck)) {
			$this->extractTextNodeModifiers($parentNode);
			if ($parentNode->nodeName === 'xref' || $parentNode->nodeName === 'ext-link') {
				$attributes = Document::getXpath()->query('@*', $parentNode);
				/* Need to rewrite DOMNodeList to a simple associative array */
				$xrefAttributes = array();
				foreach ($attributes as $attribute => $value) {
					$xrefAttributes[$value->nodeName] = $value->nodeValue;
				}
				$this->type[$parentNode->nodeName] = $xrefAttributes;
			} else {
				$this->type[] = $parentNode->nodeName;
			}
		}

		/* text inside table cells needs special treatment */
		if ($parentNode->nodeName == "p") {
			$parentNodeOfParent = $parentNode->parentNode;
			if ($parentNodeOfParent->nodeName == "th" || $parentNodeOfParent->nodeName == "td") {
				$this->type[] = $parentNode->nodeName;
				$this->extractTextNodeModifiers($parentNode);
			}
		}
	}
}